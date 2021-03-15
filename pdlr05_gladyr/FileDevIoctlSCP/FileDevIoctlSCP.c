#include "FileDevIoctlSCP.h"

int __cdecl _tmain()
{
	HANDLE				scm = NULL;
	HANDLE				service = NULL;
	HANDLE				device = INVALID_HANDLE_VALUE;
	DWORD				counterBytes = 0;
	DWORD				lastError = ERROR_SUCCESS;
	DWORD				statusBefore = SERVICE_NOT_INSTALLED;
	TCHAR				fullImagePath[2*MAX_PATH] = {0};
	SERVICE_STATUS		serviceStatus = {0};
	CHAR				inputBuffer[IN_BUFFER_SIZE]		= {0};	// для драйверу
	CHAR				outputBuffer[OUT_BUFFER_SIZE]	= {0};	// від драйвера
	
	SetConsoleTitle(_TEXT("Програма управління драйвером"));
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
				_tprintf(_TEXT("\nEnter first string\n"));
				scanf_s( "%s", &inputBuffer, sizeof(inputBuffer)-1 );
				if(DeviceIoControl(	device,
									IOCTL_BUFFERED_WRITE,
									&inputBuffer,
									strlen(inputBuffer),
									(PVOID)NULL, 
									(DWORD)NULL,
									&counterBytes, NULL)	)
				
				{
					_tprintf(_TEXT("\nIOCTL_BUFFERED_WRITE written %d bytes"), counterBytes);
				}
				else
				{
					_tprintf(_TEXT("\nIOCTL_BUFFERED_WRITE failed. ErrorCode=0x%08X."), GetLastError());
				}
				
				// Result of reading the file
				_tprintf(_TEXT("\nResult of reading the file. Buffered method: "));
				if(DeviceIoControl(	device,
									IOCTL_BUFFERED_READ,
									(PVOID)NULL, 
									(DWORD)NULL,
									&outputBuffer,
									strlen(inputBuffer),
									&counterBytes, NULL)	)
				
				{
					_tprintf(_TEXT("%s\n"), outputBuffer);
					_tprintf(_TEXT("IOCTL_BUFFERED_READ read %d bytes\n"), counterBytes);
				}
				else
				{
					_tprintf(_TEXT("\nIOCTL_BUFFERED_READ failed. ErrorCode=0x%08X."), GetLastError());
				}
				
				_tprintf(_TEXT("\nEnter second string\n"));
				scanf_s( "%s", &inputBuffer, sizeof(inputBuffer)-1 );
				if(DeviceIoControl(	device,
									IOCTL_DIRECT_WRITE,
									&inputBuffer,
									strlen(inputBuffer),
									(PVOID)NULL, 
									(DWORD)NULL,
									&counterBytes, NULL)	)
				
				{
					_tprintf(_TEXT("\nIOCTL_DIRECT_WRITE written %d bytes"), counterBytes);
				}
				else
				{
					_tprintf(_TEXT("\nIOCTL_DIRECT_WRITE failed. ErrorCode=0x%08X."), GetLastError());
				}
				
				memset(outputBuffer, 0, strlen(outputBuffer));
				_tprintf(_TEXT("\nResult of reading the file. Direct method: "));
				if(DeviceIoControl(	device,
									IOCTL_DIRECT_READ,
									(PVOID)NULL, 
									(DWORD)NULL,
									&outputBuffer,
									strlen(inputBuffer),
									&counterBytes, NULL)	)
				
				{
					_tprintf(_TEXT("%s\n"), outputBuffer);
					_tprintf(_TEXT("IOCTL_DIRECT_READ read %d bytes\n"), counterBytes);
				}
				else
				{
					_tprintf(_TEXT("\nIOCTL_DIRECT_READ failed. ErrorCode=0x%08X."), GetLastError());
				}
				
				_tprintf(_TEXT("\nEnter third string\n"));
				scanf_s( "%s", &inputBuffer, sizeof(inputBuffer)-1 );
				if(DeviceIoControl(	device,
									IOCTL_NEITHER_WRITE,
									&inputBuffer,
									strlen(inputBuffer),
									(PVOID)NULL, 
									(DWORD)NULL,
									&counterBytes, NULL)	)
				
				{
					_tprintf(_TEXT("\nIOCTL_NEITHER_WRITE written %d bytes"), counterBytes);
				}
				else
				{
					_tprintf(_TEXT("\nIOCTL_NEITHER_WRITE failed. ErrorCode=0x%08X."), GetLastError());
				}
				
				memset(outputBuffer, 0, strlen(outputBuffer));
				_tprintf(_TEXT("\nResult of reading the file. Neither method: "));
				if(DeviceIoControl(	device,
									IOCTL_NEITHER_READ,
									(PVOID)NULL, 
									(DWORD)NULL,
									&outputBuffer,
									strlen(inputBuffer),
									&counterBytes, NULL)	)
				
				{
					_tprintf(_TEXT("%s\n"), outputBuffer);
					_tprintf(_TEXT("IOCTL_DIRECT_READ read %d bytes\n"), counterBytes);
				}
				else
				{
					_tprintf(_TEXT("\nIOCTL_DIRECT_READ failed. ErrorCode=0x%08X."), GetLastError());
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
	_gettchar();_gettchar();
	return lastError;
}
