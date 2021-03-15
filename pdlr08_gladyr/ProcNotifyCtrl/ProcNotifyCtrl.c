#include "ProcNotifyCtrl.h"

int __cdecl _tmain()
{
	HANDLE					scm = NULL;
	HANDLE					service = NULL;
	HANDLE					device = INVALID_HANDLE_VALUE;
	DWORD					counterBytes = 0, counterProcess = 0;
	DWORD					lastError = ERROR_SUCCESS;
	DWORD					statusBefore = SERVICE_NOT_INSTALLED;
	TCHAR					fullImagePath[2*MAX_PATH] = {0};
	SERVICE_STATUS			serviceStatus = {0};
	HANDLE					event[2]  = {NULL};
	PROCESS_NOTIFY_INFO	outputBuffer = {0};
	IMAGE_NOTIFY_INFO		outputImageBuffer = {0};
	DWORD					waitResult = 0;
	
	SetConsoleTitle(_TEXT("Програма управління драйвером"));
	
	event[0] = CreateEvent(NULL, FALSE, FALSE, NULL);
	if(!event[0])
	{
		lastError = GetLastError();
		_tprintf(_TEXT("\nCreateEvent fails with errorCode=0x%0X"), lastError);
		return lastError;
	}
	
	event[1] = CreateEvent(NULL, FALSE, FALSE, NULL);
	if(!event[1])
	{
		lastError = GetLastError();
		_tprintf(_TEXT("\nCreateEvent fails with errorCode=0x%0X"), lastError);
		return lastError;
	}
	
	scm = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
	if(!scm)
	{
		lastError = GetLastError();
		_tprintf(_TEXT("\nCan't open Service Control Manager. ErrorCode=0x%0X"), lastError);
		return lastError;
	}

	service = OpenService(scm, serviceName,	SERVICE_START + SERVICE_STOP);
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
							SERVICE_START + SERVICE_STOP + DELETE,
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
			_tprintf(_TEXT("\nService '%s' started"), serviceName);
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
			device = CreateFile(
						symbolicLinkName,
						GENERIC_READ + GENERIC_WRITE, 0, NULL,
						OPEN_EXISTING, 0, NULL);
			
			if(INVALID_HANDLE_VALUE == device)
			{
				lastError = GetLastError();
				_tprintf(_TEXT("\nCan't open symbolik link '%s'. ErrorCode=0x%0X."),
							symbolicLinkName, lastError);
			}
			else
			{
				if(DeviceIoControl(	device,
									IOCTL_START,
									&event,
									2 * sizeof(HANDLE),
									(PVOID)0, 
									(DWORD)0,
									&counterBytes, NULL)	)
				
				{
					_tprintf(_TEXT("\nTry to create two processes and then finish them\n"));
					while(counterProcess < 5)
					{
						waitResult = WaitForMultipleObjects(2, event, FALSE, INFINITE);
						switch (waitResult - WAIT_OBJECT_0)
						{
							case 0:
								if(DeviceIoControl(	device,
											IOCTL_GET_INFO,
											(PVOID)0, 
											(DWORD)0,
											&outputBuffer,
											sizeof(PROCESS_NOTIFY_INFO),
											&counterBytes, NULL)	)
								{
									_tprintf(_TEXT("\nProcess PID = %d %s %s"), 
										outputBuffer.ProcessId,
										outputBuffer.Create ? _TEXT("started") : _TEXT("finished"));	
										 counterProcess++;
								}
								break;
							case 1:
								if(DeviceIoControl(	device,
											IOCTL_GET_IMAGE_INFO,
											(PVOID)0, 
											(DWORD)0,
											&outputImageBuffer,
											sizeof(IMAGE_NOTIFY_INFO),
											&counterBytes, NULL)	)
								{
									_tprintf(_TEXT("\nModule %ws loaded at imagebase %p size: %p"), 
										outputImageBuffer.FullImageName,
										outputImageBuffer.ImageBase,
										 outputImageBuffer.ImageSize);	
								}
								break;
						}		
					}
					
					DeviceIoControl(	device, IOCTL_STOP,
									(PVOID)0, (DWORD)0,
									(PVOID)0, (DWORD)0,
									&counterBytes, NULL);
				}
				else
				{
					_tprintf(_TEXT("\nIOCTL_START failed. ErrorCode=0x%08X."),
								GetLastError());
				}
				CloseHandle(device);
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
