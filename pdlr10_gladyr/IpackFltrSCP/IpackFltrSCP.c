#include "IpackFltrSCP.h"


typedef struct _ThreadContext {
	HANDLE		device;
	HANDLE		stopEvent;
}ThreadContext;

ThreadRoutine(void * ctx)
{
	IPHeader		outputBuffer[128]	= {0};	// від драйвера
	BOOL		result			= FALSE;
	ULONG		packetsNumber	= 0;
	DWORD		counterBytes		= 0;
	
	result = DeviceIoControl(	((ThreadContext*)ctx)->device, 
							IOCTL_SET_FILTER, 
							(void*)NULL, 0 , (void*)NULL, 0,
							&counterBytes, NULL);
	if(!result)
	{
		_tprintf(_TEXT("IOCTL_SET_FILTER failed. ErrorCode=0x%08X.\n"), GetLastError());
		ExitThread((DWORD)result);
	}
	
	while( WAIT_OBJECT_0 != WaitForSingleObject(
								((ThreadContext*)ctx)->stopEvent, 1000) ) 
	{
		if(!ReadFile(	((ThreadContext*)ctx)->device, 
					&outputBuffer, sizeof(outputBuffer), 
					&counterBytes, NULL)	)
		{
			_tprintf(_TEXT("\nReadFile failed. ErrorCode=0x%08X."), GetLastError());
			continue;	
		}
		
		for(	packetsNumber = 0; 
			packetsNumber < counterBytes / sizeof(IPHeader);
			packetsNumber++)
		{
			_tprintf(_TEXT("Src : %s\tDst : %s\tprotocol : "),
				inet_ntoa(outputBuffer[packetsNumber].iph_src),
				inet_ntoa(outputBuffer[packetsNumber].iph_dest));				
			
			switch(outputBuffer[packetsNumber].iph_protocol)
			{
				case	 1:
					_tprintf(_TEXT("ICMP\n"));
					break;
				case 2:
					_tprintf(_TEXT("IGMP\n"));
					break;
				case 4:
					_tprintf(_TEXT("IPv4\n"));
					break;
				case 6:
					_tprintf(_TEXT("TCP\n"));
					break;
				case 17:
					_tprintf(_TEXT("UDP\n"));
					break;
				case 27:
					_tprintf(_TEXT("RDP\n"));
					break;
				case 47:
					_tprintf(_TEXT("GRE\n"));
					break;
				default:
					_tprintf(_TEXT("%d\n", outputBuffer[packetsNumber].iph_protocol));
			}
		}

	}
	DeviceIoControl(	((ThreadContext*)ctx)->device, 
					IOCTL_RESET_FILTER, 
					(void*)NULL, 0 , (void*)NULL, 0,
					&counterBytes, NULL);
	
	ExitThread((DWORD)result);	
}

int __cdecl _tmain()
{
	HANDLE				scm = NULL;
	HANDLE				service = NULL;
	HANDLE				device = INVALID_HANDLE_VALUE;
	DWORD				counterBytes		= 0;	
	DWORD				lastError = ERROR_SUCCESS;
	DWORD				statusBefore = SERVICE_NOT_INSTALLED;
	TCHAR				fullImagePath[2*MAX_PATH] = {0};
	SERVICE_STATUS		serviceStatus = {0};
	ThreadContext		threadCtx	= {0};
	HANDLE				thread		= 0;
	 	
	SetConsoleTitle(_TEXT("Програма управління драйвером"));
	scm = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
	if(!scm)
	{
		lastError = GetLastError();
		_tprintf(_TEXT("\nCan't open Service Control Manager. ErrorCode=0x%0X"), lastError);
		return lastError;
	}

	service = OpenService(scm, serviceName,	SERVICE_START | SERVICE_STOP);
	if(service)
	{
		statusBefore |= SERVICE_OPENED;
		_tprintf(_TEXT("\nService '%s' opened"), serviceName);
	}
	else
	{
		_tprintf(_TEXT("\nCan't open service '%s'. ErrorCode=0x%0X.\nTry create..."), 
					serviceName, GetLastError());
		counterBytes = GetFullPathName(
								imageName,
								sizeof (fullImagePath)/sizeof(TCHAR), 
								fullImagePath, NULL);
		if(counterBytes == 0 || counterBytes > sizeof (fullImagePath)/sizeof(TCHAR))
		{
			lastError = GetLastError();
			_tprintf(_TEXT("\nCan't get full path for service image '%s'. ErrorCode=0x%0X."), 
						imageName, lastError);
		}
		else
		{
			service = CreateService(
							scm,
							serviceName,
							serviceName,
							SERVICE_START | SERVICE_STOP | DELETE,
							SERVICE_KERNEL_DRIVER,
							SERVICE_DEMAND_START,
							SERVICE_ERROR_IGNORE,
							fullImagePath,
							NULL, NULL, NULL, NULL, NULL);
			if(service)
			{
				statusBefore |= SERVICE_INSTALLED;
				_tprintf(_TEXT("\nService '%s' created"), serviceName);
			}
			else
			{
				lastError = GetLastError();
				_tprintf(_TEXT("\nCan't create service '%s'. ErrorCode=0x%0X."),
						 serviceName, lastError);
			}
		}
	}

	if(service)
	{
		if( StartService(service, 0, NULL) )
		{
			statusBefore |= SERVICE_STARTED;
			_tprintf(_TEXT("\nService '%s' started\n"), serviceName);
		}
		else
		{
			lastError = GetLastError();
			if(ERROR_SERVICE_ALREADY_RUNNING == lastError)
			{
				_tprintf(_TEXT("\nService '%s' already running"), serviceName);
				statusBefore |= SERVICE_RUNNING;
			}
			else
			{
				_tprintf(_TEXT("\nCan't start service '%s'. ErrorCode=0x%08X."),
							serviceName, lastError);
			}
		}
		
		if( (statusBefore & SERVICE_STARTED) || (statusBefore & SERVICE_RUNNING) )
		{
			threadCtx.device = CreateFile(
								symbolicLinkName,
								GENERIC_READ | GENERIC_WRITE, 
								0, NULL, 	OPEN_EXISTING, 0, NULL);
			
			if(INVALID_HANDLE_VALUE == threadCtx.device)
			{
				lastError = GetLastError();
				_tprintf(_TEXT("\nCan't open symbolik link '%s'. ErrorCode=0x%0X."),
							symbolicLinkName, lastError);
			}
			else
			{
				threadCtx.stopEvent = CreateEvent(NULL, FALSE, FALSE, NULL);
				thread = CreateThread(NULL,0,ThreadRoutine,&threadCtx,0,NULL);
				_gettchar();	_gettchar();
				SetEvent(threadCtx.stopEvent);
				WaitForSingleObject(thread, INFINITE);
				CloseHandle(threadCtx.device);
				CloseHandle(threadCtx.stopEvent);
			}
		}
	}

	if(statusBefore & SERVICE_STARTED)
	{
		if(ControlService(service, SERVICE_CONTROL_STOP, &serviceStatus))
		{
			_tprintf(_TEXT("\nService '%s' stopped"), serviceName);
		}
		else
		{
			lastError = GetLastError();
			_tprintf(_TEXT("\nCan't stop service '%s'. ErrorCode=0x%0X."),
						 serviceName, lastError);
		}
	}
	if( (statusBefore & SERVICE_INSTALLED) && (SERVICE_STOPPED == serviceStatus.dwCurrentState) )
	{
		if( DeleteService(service) )
		{
			_tprintf(_TEXT("\nService '%s' deleted"), serviceName);
		}
		else
		{
			lastError = GetLastError();
			_tprintf(_TEXT("\nCan't delete service '%s'. ErrorCode=0x%0X."),
						 serviceName, lastError);
		}
	}

	CloseServiceHandle(service);
	CloseServiceHandle(scm);
	_tprintf(_TEXT("\nPress 'Enter' to exit\n"));
	_gettchar();
	return lastError;
}
