#include "PCIDevEnumerator.h"

void EnumeratePCIDevice(HANDLE enumerator)
{
	PCI_SLOT_NUMBER_EXT	slotNum = {0};
	ULONG					outputBuffer[16] = {0};
	DWORD					counterBytes = 0;
	ULONG					bus = 0, device = 0, function = 0;
	ULONG					regNum = 0;
		
	slotNum.u.bits.TestBit = 1;
	
	for(bus = 0 ; bus < PCI_MAX_BRIDGE_NUMBER ; bus++)
	{
		slotNum.u.bits.BusNumber = bus;
		for(device = 0 ; device < PCI_MAX_DEVICES ; device++)
		{
			slotNum.u.bits.DeviceNumber = device;			
			for(function = 0 ; function < PCI_MAX_FUNCTION ; function++)
			{
				slotNum.u.bits.FunctionNumber = function;
				if(DeviceIoControl(	enumerator,
									IOCTL_GET_PCI_COMMON_HEADER,
									&slotNum,
									sizeof(slotNum),
									&outputBuffer, 
									sizeof(outputBuffer),
									&counterBytes, NULL)	)
				
				{
					_tprintf(_TEXT("\nBus = %d, Device = %d, Function = %d\n"), bus, device, function);
					for(regNum = 0; regNum <= 15 ; regNum++)
					{
						_tprintf(_TEXT("Registry 0x%02X : 0x%08X\n"), regNum*4, outputBuffer[regNum]);	
					}
				}
			}
		}
	}	
	return;
}

void FindPCIDevice(HANDLE enumerator)
{
	PCI_SLOT_NUMBER_EXT	slotNum = {0};
	ULONG					outputBuffer[17] = {0};
	ULONG					regNum = 0;
	DWORD					counterBytes = 0;
	ULONG					inputBuffer[2] = {0};
	WORD					vendorID = 0, deviceID = 0, deviceNumber = 0;
	int c;
	
	
	_tprintf(_TEXT("Enter the vendor id as a hex value: 0x"));
	_tscanf("%x", &vendorID);
	while ((c = getchar()) != '\n' && c != EOF) { }
	_tprintf(_TEXT("Enter the device id as a hex value: 0x"));
	_tscanf("%x", &deviceID);
	while ((c = getchar()) != '\n' && c != EOF) { }
	_tprintf(_TEXT("Enter a number of the device: "));
	_tscanf("%d", &deviceNumber);
	while ((c = getchar()) != '\n' && c != EOF) { }
	
	inputBuffer[0] = deviceID;
	inputBuffer[0] = inputBuffer[0] << 16;
	inputBuffer[0] |= vendorID;
	inputBuffer[1] = deviceNumber;
	
	if(DeviceIoControl(	enumerator,
						IOCTL_FIND_PCI_DEVICE,
						&inputBuffer,
						sizeof(inputBuffer),
						&outputBuffer, 
						sizeof(outputBuffer),
						&counterBytes, NULL)	)
				
	{
		slotNum.u.AsULONG = outputBuffer[16];
		_tprintf(_TEXT("\nBus = %d, Device = %d, Function = %d\n"),
				 slotNum.u.bits.BusNumber, slotNum.u.bits.DeviceNumber, slotNum.u.bits.FunctionNumber);
		for(regNum = 0; regNum <= 15 ; regNum++)
		{
			_tprintf(_TEXT("Registry 0x%02X : 0x%08X\n"), regNum*4, outputBuffer[regNum]);	
		}
	}
	else
		_tprintf(_TEXT("\nUnsuccessful call of DeviceIoControl()\n"));
	return;
}

void FindPCIDeviceByClassCode(HANDLE enumerator)
{
	PCI_SLOT_NUMBER_EXT	slotNum = {0};
	ULONG					outputBuffer[17] = {0};
	ULONG					regNum = 0;
	DWORD					counterBytes = 0;
	ULONG					inputBuffer[2] = {0};
	ULONG					classCode = 0, deviceNumber = 0;
	int c;
	
	_tprintf(_TEXT("Enter a class code as a hex value: 0x"));
	_tscanf("%x", &classCode);
	while ((c = getchar()) != '\n' && c != EOF) { }
	_tprintf(_TEXT("Enter a number of the device: "));
	_tscanf("%d", &deviceNumber);
	while ((c = getchar()) != '\n' && c != EOF) { }
	
	// reset the lowest 8 bits
	classCode = classCode & (ULONG)0xffffff00;
	inputBuffer[0] = classCode;
	inputBuffer[1] = deviceNumber;
	
	if(DeviceIoControl(	enumerator,
						IOCTL_GET_PCI_CLASS_CODE,
						&inputBuffer,
						sizeof(inputBuffer),
						&outputBuffer, 
						sizeof(outputBuffer),
						&counterBytes, NULL)	)
				
	{
		slotNum.u.AsULONG = outputBuffer[16];
		_tprintf(_TEXT("\nBus = %d, Device = %d, Function = %d\n"),
				 slotNum.u.bits.BusNumber, slotNum.u.bits.DeviceNumber, slotNum.u.bits.FunctionNumber);
		for(regNum = 0; regNum <= 15 ; regNum++)
		{
			_tprintf(_TEXT("Registry 0x%02X : 0x%08X\n"), regNum*4, outputBuffer[regNum]);	
		}
	}
	else
		_tprintf(_TEXT("\nUnsuccessful call of DeviceIoControl()\n"));
	return;
}

int __cdecl _tmain()
{
	HANDLE			scm = NULL;
	HANDLE			service = NULL;
	HANDLE			device = INVALID_HANDLE_VALUE;
	DWORD			lastError	= ERROR_SUCCESS;
	DWORD			statusBefore = SERVICE_NOT_INSTALLED;
	DWORD			bytesReturned = 0;
	TCHAR			fullImagePath[2*MAX_PATH] = {0};
	SERVICE_STATUS	serviceStatus = {0};
	
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
		bytesReturned = GetFullPathName(
								imageName,
								sizeof (fullImagePath)/sizeof(TCHAR), 
								fullImagePath, NULL);
		if(bytesReturned == 0 || bytesReturned > sizeof (fullImagePath)/sizeof(TCHAR))
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
				EnumeratePCIDevice(device);
				_tprintf(_TEXT("\nSearch of PCI configuration space by DeviceID and VendorID.\n"));
				FindPCIDevice(device);
				_tprintf(_TEXT("\nSearch of PCI configuration space by class code.\n"));
				FindPCIDeviceByClassCode(device);
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
