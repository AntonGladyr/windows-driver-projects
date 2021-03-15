#include "BIOSSetupSCP.h"

void ShowCurrentDateTime(HANDLE device)
{
	UCHAR					outputBuffer[6] = {0};
	DWORD					counterBytes = 0;
	
	if(DeviceIoControl(	device,
						IOCTL_GET_CURRENT_DATE_TIME,
						NULL,
						0,
						&outputBuffer, 
						sizeof(outputBuffer),
						&counterBytes, NULL)	)
		
	{
		_tprintf(_TEXT("\nCurrent time => %02x.%02x.%02x %02x:%02x:%02x\n"),
					outputBuffer[0], outputBuffer[1], outputBuffer[2],
					outputBuffer[3], outputBuffer[4], outputBuffer[5]);
	}
	else
	{
		_tprintf(_TEXT("\nIOCTL=0x%08X failed. ErrorCode=0x%08X."),
					IOCTL_GET_CURRENT_DATE_TIME, GetLastError());
	}
	return;
}

WORD inputNumber(WORD minValue, WORD maxValue )
{
	WORD userInput = 0;
	TCHAR term;
	int c;
	
	do
	{
		if( _tscanf("%x%c", &userInput, &term) != 2 || term != '\n')
		{
			_tprintf(_TEXT("Failure! The value must be a number. Try again...\n"));
			while ((c = getchar()) != '\n' && c != EOF) { }
		}
		else
		{
			if (userInput > maxValue || userInput < minValue )
				_tprintf(_TEXT("Failure! The value must be between 1 and %x. Try again...\n"), maxValue);
			else break;
		}
	}
	while(TRUE);
	return userInput;
}

void SetNewDateTime(HANDLE device)
{
	UCHAR					inputBuffer[6] = {0};
	UCHAR					outputBuffer[6] = {0};
	DWORD					counterBytes = 0;
	
	_tprintf(_TEXT("Enter new date day: "));
	inputBuffer[0] = (UCHAR)inputNumber(0x01, 0x31); // day 
	_tprintf(_TEXT("Enter new date month: "));
	inputBuffer[1] = (UCHAR)inputNumber(0x01, 0x12); // month
	_tprintf(_TEXT("Enter new date year: "));
	inputBuffer[2] = (UCHAR)inputNumber(0x00, 0x99); // year
	_tprintf(_TEXT("Enter new hours: "));
	inputBuffer[3] = (UCHAR)inputNumber(0x00, 0x23); // hours
	_tprintf(_TEXT("Enter new minutes: "));
	inputBuffer[4] = (UCHAR)inputNumber(0x00, 0x59); // minutes
	//_tprintf(_TEXT("Enter new seconds: "));
	//inputBuffer[5] = (UCHAR)inputNumber(0x59); // seconds
	
	if(DeviceIoControl(	device,
						IOCTL_SET_NEW_DATE_TIME,
						&inputBuffer,
						sizeof(inputBuffer),
						&outputBuffer, 
						sizeof(outputBuffer),
						&counterBytes, NULL)	)
		
	{
		_tprintf(_TEXT("\nNew set time => %02x.%02x.%02x %02x:%02x:%02x\n"),
					outputBuffer[0], outputBuffer[1], outputBuffer[2],
					outputBuffer[3], outputBuffer[4], outputBuffer[5]);
	}
	else
	{
		_tprintf(_TEXT("\nIOCTL=0x%08X failed. ErrorCode=0x%08X."),
					IOCTL_SET_NEW_DATE_TIME, GetLastError());
	}	
	
	return;
}

void ShowChecksumStatus(HANDLE device)
{
	UCHAR					outputBuffer = 0;
	UCHAR					checksum = 0;
	DWORD					counterBytes = 0;
	
	if(DeviceIoControl(	device,
						IOCTL_GET_DIAGNOSTIC_STATUS,
						NULL,
						0,
						&outputBuffer, 
						sizeof(outputBuffer),
						&counterBytes, NULL)	)
		
	{
		// reset all bits except checksum bit
		checksum = outputBuffer & (UCHAR)0x40; // XXXXXXXX AND 01000000. Sixth bit stands for checksum bit
		if (!checksum)
			_tprintf(_TEXT("CMOS checksum status is good (equals 0)\n"));
		else
			_tprintf(_TEXT("CMOS checksum status is bad (equals 1)\n"));
	}
	else
	{
		_tprintf(_TEXT("\nIOCTL=0x%08X failed. ErrorCode=0x%08X."),
					IOCTL_GET_DIAGNOSTIC_STATUS, GetLastError());
	}
	return;
}

void ShowCMOSBatteryStatus(HANDLE device)
{
	UCHAR					outputBuffer = 0;
	UCHAR					cmosBatteryStatus = 0;
	DWORD					counterBytes = 0;
	
	if(DeviceIoControl(	device,
						IOCTL_GET_STATUS_REGISTER_D,
						NULL,
						0,
						&outputBuffer, 
						sizeof(outputBuffer),
						&counterBytes, NULL)	)
		
	{
		// reset all bits except checksum bit
		// XXXXXXXX AND 10000000. Seventh bit stands for battery status bit
		cmosBatteryStatus = outputBuffer & (UCHAR)0x80;
		if (cmosBatteryStatus)
			_tprintf(_TEXT("CMOS battery power good (flag equals 1)\n"));
		else
			_tprintf(_TEXT("CMOS battery dead (flag equals 0)\n"));
	}
	else
	{
		_tprintf(_TEXT("\nIOCTL=0x%08X failed. ErrorCode=0x%08X."),
					IOCTL_GET_STATUS_REGISTER_D, GetLastError());
	}
	return;
}

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
				ShowCurrentDateTime(device);
				ShowChecksumStatus(device);
				ShowCMOSBatteryStatus(device);
				SetNewDateTime(device);
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
