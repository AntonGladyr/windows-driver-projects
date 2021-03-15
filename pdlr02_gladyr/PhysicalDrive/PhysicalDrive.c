#include "PhysicalDrive.h"

int __cdecl _tmain()
{
	ULONG						driveNumber = 0;
	HANDLE						device = NULL;
	TCHAR						driveDeviceName[64] = {0};
	DWORD						counterBytes = 0;
	GETVERSIONINPARAMS		smartVerInfo = {0};
	DISK_GEOMETRY				diskGeometry = {0};
	DISK_PERFORMANCE			diskPerformance = {0};
	char							driveBuf[4*sizeof(DRIVE_LAYOUT_INFORMATION)] = {0};
	MASTER_BOOT_RECORD		mbr;
	ULONG						i = 0;	
	TCHAR channel[8][25*sizeof(TCHAR)] = {
				"IDE, Primary, Master", "IDE, Primary, Slave",
				"IDE, Secondary, Master", "IDE, Secondary, Slave",
				"ATAPI, Primary, Master", "ATAPI, Primary, Slave",
				"ATAPI, Secondary, Master", "ATAPI, Secondary, Slave"};	
	
	PDRIVE_LAYOUT_INFORMATION driveInfo = (DRIVE_LAYOUT_INFORMATION*)&driveBuf;
		
	SetConsoleTitle( _TEXT("Дисковi пристрої") );
	
	while(TRUE) {
		_stprintf(driveDeviceName, "\\\\.\\PhysicalDrive%u", driveNumber);
		device = CreateFile(	driveDeviceName, 
							GENERIC_READ|GENERIC_WRITE, 
							FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_SHARE_DELETE,
							NULL, 
							OPEN_EXISTING,
							0, 
							NULL	);
		
		if(INVALID_HANDLE_VALUE == device)
		{
			break;
			/*_tprintf( _TEXT("can't open. CreateFile fails with error code = %d\n"), GetLastError());
			return -1; */
		}
		
		_tprintf( _TEXT("%s : "), driveDeviceName );
		
		if(	DeviceIoControl(device, 
					SMART_GET_VERSION, 
					(PVOID)NULL, 
					(DWORD)NULL, 
					&smartVerInfo, 
					sizeof(GETVERSIONINPARAMS), 
					&counterBytes, NULL)	)
		{
			_tprintf( _TEXT("%s\n"), channel[smartVerInfo.bIDEDeviceMap / 2] );
		}
		if(	DeviceIoControl(device, 
					IOCTL_DISK_GET_DRIVE_GEOMETRY, 
					(PVOID)NULL, 
					(DWORD)NULL, 
					&diskGeometry, 
					sizeof(DISK_GEOMETRY), 
					&counterBytes, NULL)	)
		{
			_tprintf( _TEXT("Cylinders\t\t:\t%d\n"), diskGeometry.Cylinders);
			_tprintf( _TEXT("Tracks per cylinder\t:\t%d\n"), diskGeometry.TracksPerCylinder); 
			_tprintf( _TEXT("Sectors per track\t:\t%d\n"), diskGeometry.SectorsPerTrack);
			_tprintf( _TEXT("Bytes per sector\t:\t%d\n"), diskGeometry.BytesPerSector); 
		}
	
		if(	DeviceIoControl(device, 
					IOCTL_DISK_PERFORMANCE, 
					(PVOID)NULL, 
					(DWORD)NULL, 
					&diskPerformance, 
					sizeof(DISK_PERFORMANCE), 
					&counterBytes, NULL)	)
		{
			_tprintf( _TEXT("Read\t\t\t:\t%d Kb\n"), 
					diskPerformance.BytesRead.QuadPart  / 1024 );
			_tprintf( _TEXT("Written\t\t\t:\t%d Kb\n"), 
					diskPerformance.BytesWritten.QuadPart   / 1024 );
		}
	
		if(	DeviceIoControl(device, 
					IOCTL_DISK_GET_DRIVE_LAYOUT, 
					(PVOID)NULL, 
					(DWORD)NULL, 
					&driveBuf, 
					sizeof(driveBuf), 
					&counterBytes, NULL)	)
		{
			_tprintf( _TEXT("Partition count\t\t:\t%d\n"),	driveInfo->PartitionCount );
			for( i = 0; i <  driveInfo->PartitionCount;  i++)
			{
				if(driveInfo->PartitionEntry[i].PartitionNumber)
				{
					_tprintf( _TEXT("Partition %d size is %d Mb\n"), 
					driveInfo->PartitionEntry[i].PartitionNumber,
					driveInfo->PartitionEntry[i].PartitionLength.QuadPart / 1024 / 1024 );
				}
			}
		}
		
		if ( !ReadFile(device,
				(PMASTER_BOOT_RECORD)&mbr,
				sizeof(mbr), 
				&counterBytes,
				 NULL)) 
			_tprintf( _TEXT("can't open. ReadFile fails with error code = %d\n"), GetLastError());
		else 
		{
			_tprintf("-----------------Master Boot Record of \\\\.\\PhysicalDrive%u-----------------\n", driveNumber);
			_tprintf( _TEXT("Boot flag\t\t:\t%d\n"), mbr.Partition0.BootFlag);
			_tprintf( _TEXT("Start head\t\t:\t%d\n"), mbr.Partition0.StartHead);
			_tprintf( _TEXT("StartCylSector\t\t:\t%d\n"), mbr.Partition0.StartCylSector);
			_tprintf( _TEXT("OSID\t\t\t:\t%d\n"), mbr.Partition0.OSID);
			_tprintf( _TEXT("EndHead\t\t\t:\t%d\n"), mbr.Partition0.EndHead);
			_tprintf( _TEXT("EndCylSector\t\t:\t%d\n"), mbr.Partition0.EndCylSector);
			_tprintf( _TEXT("StartLogicalSector\t:\t%d\n"), mbr.Partition0.StartLogicalSector);
			_tprintf( _TEXT("Total sectors\t\t:\t%d\n"), mbr.Partition0.TotalSectors);
			
			_tprintf("---------------------------------------------------------------------------\n");
			_tprintf("---------------------------------------------------------------------------\n");
		}
		
		driveNumber++;
		CloseHandle(device);
	}
		
	_tprintf(_TEXT("\nPress 'Enter' to exit\n"));
	_gettchar();

	return 0;
}
