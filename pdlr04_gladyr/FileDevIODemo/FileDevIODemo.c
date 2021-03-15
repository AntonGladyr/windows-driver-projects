#include "FileDevIODemo.h"

NTSTATUS
DriverEntry(	IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath	)
{
	NTSTATUS			status		= STATUS_SUCCESS;
	PDEVICE_OBJECT		DeviceObject	= NULL;
	PDEVICE_EXTENSION	devExt		= NULL;
	
	DECLARE_CONST_UNICODE_STRING(devFileName, L"\\??\\C:\\FileDevIODemoDeviceFile.txt");

	UNREFERENCED_PARAMETER(RegistryPath);

	status = IoCreateDevice(DriverObject,
						sizeof(DEVICE_EXTENSION),
						(PUNICODE_STRING)&deviceName,
						DEV_TYPE, FILE_DEVICE_SECURE_OPEN,
						FALSE, &DeviceObject);                        
	
	if (!NT_SUCCESS(status))
	{
		KdPrint((__FUNCTION__" : IoCreateDevice fails with status = 0x%08X for device with name %wZ\n", 
					status, (PUNICODE_STRING)&deviceName) );
		return status;
	}
	
	status = IoCreateSymbolicLink(	(PUNICODE_STRING)&symbolicLinkName, 
								(PUNICODE_STRING)&deviceName	);
		
	if (!NT_SUCCESS(status))
	{
		KdPrint((__FUNCTION__" : IoCreateSymbolicLink fails with status = 0x%08X\n", status));
		IoDeleteDevice(DeviceObject);
		return status;
	}
	devExt = DeviceObject->DeviceExtension;
	InitializeObjectAttributes(	&devExt->devFileAttr, 
							(PUNICODE_STRING)&devFileName,
							OBJ_CASE_INSENSITIVE+OBJ_KERNEL_HANDLE, 
							NULL,NULL	);
	
	status =  ZwCreateFile(&devExt->devFile,
		GENERIC_READ+GENERIC_WRITE,
		&devExt->devFileAttr,
		&devExt->devFileIoStatus,
		0, FILE_ATTRIBUTE_NORMAL,
                	FILE_SHARE_READ | FILE_SHARE_WRITE, 
                	FILE_OVERWRITE_IF,
		FILE_NON_DIRECTORY_FILE, NULL, 0);
	
	if (!NT_SUCCESS(status))
	{
		KdPrint((__FUNCTION__" : ZwCreateFile fails with status = 0x%08X\n", status));	
		IoDeleteSymbolicLink((PUNICODE_STRING)&symbolicLinkName);
		IoDeleteDevice(DeviceObject);
		return status;
	}

	devExt->writeOffset.LowPart = devExt->writeOffset.HighPart = 0;
	devExt->readOffset.LowPart = devExt->readOffset.HighPart = 0;
	
	//DO_NEITHER_IO використовується за замовчанням і не потребує явного визначення
	//Для інших 
	//DeviceObject->Flags |= DO_BUFFERED_IO;
	//DeviceObject->Flags |= DO_DIRECT_IO;
			
	DriverObject->MajorFunction[IRP_MJ_CREATE]	= CreateDispatchRoutine;
	DriverObject->MajorFunction[IRP_MJ_CLOSE]		= CloseDispatchRoutine;
	DriverObject->MajorFunction[IRP_MJ_WRITE]		= WriteDispatchRoutine; 
	DriverObject->MajorFunction[IRP_MJ_READ]		= ReadDispatchRoutine;
			
	DriverObject->DriverUnload						= DriverUnload;
	return status;
}

NTSTATUS
CreateDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
						IN PIRP				Irp	)
{
	UNREFERENCED_PARAMETER(DeviceObject);
	PAGED_CODE();
	ASSERT(Irp);

	Irp->IoStatus.Status = STATUS_SUCCESS;
	Irp->IoStatus.Information = 0;
	IoCompleteRequest(Irp, IO_NO_INCREMENT);
	return STATUS_SUCCESS;
}

NTSTATUS
CloseDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
						IN PIRP				Irp	)
{
	UNREFERENCED_PARAMETER(DeviceObject);
	PAGED_CODE();
	ASSERT(Irp);

	Irp->IoStatus.Status = STATUS_SUCCESS;
	Irp->IoStatus.Information = 0;
	IoCompleteRequest(Irp, IO_NO_INCREMENT);
	return STATUS_SUCCESS;
}

NTSTATUS
WriteDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
					IN PIRP				Irp	)
{
	NTSTATUS				status	= STATUS_SUCCESS;
	PIO_STACK_LOCATION		ioStack	= IoGetCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION		devExt	= DeviceObject->DeviceExtension;
	ULONG					inBufLen	= ioStack->Parameters.Write.Length;
	PCHAR               			inBuf	= NULL;
	PMDL					mdl		= NULL;

	PAGED_CODE();
//__debugbreak();
	Irp->IoStatus.Information = 0;
	inBuf = Irp->UserBuffer;
	if((inBuf + inBufLen) >= (PCHAR)MM_USER_PROBE_ADDRESS ||
		inBuf <= (PCHAR)MM_LOWEST_USER_ADDRESS )
	{
		KdPrint( (__FUNCTION__" : Input buffer address = 0x%p invalid\n", inBuf) );
		status = STATUS_INVALID_PARAMETER;
		Irp->IoStatus.Status = status;
		IoCompleteRequest(Irp, IO_NO_INCREMENT);
		return status;
	}

	try
	{
		ProbeForRead( inBuf, inBufLen, sizeof(UCHAR) );
		mdl = IoAllocateMdl(inBuf, inBufLen, FALSE, TRUE, NULL);
		if (!mdl)
		{
			KdPrint((__FUNCTION__" : IoAllocateMdl return 0x%p for input buffer\n", mdl));
			status = STATUS_INSUFFICIENT_RESOURCES;
		}
		else
		{
			MmProbeAndLockPages(mdl, UserMode, IoReadAccess);
			inBuf = MmGetSystemAddressForMdlSafe(mdl, NormalPagePriority);
			if (!inBuf)
			{
				status = STATUS_INSUFFICIENT_RESOURCES;
   				KdPrint((__FUNCTION__" : MmGetSystemAddressForMdlSafe return 0x%p for input buffer\n", inBuf));
   			}
   			else
   			{
				status = ZwWriteFile(	devExt->devFile,
									NULL, NULL, NULL,
									&devExt->devFileIoStatus,
									inBuf, inBufLen,
									&devExt->writeOffset, 
									NULL);
				if (NT_SUCCESS(status))
				{
					devExt->writeOffset.LowPart+=devExt->devFileIoStatus.Information;
					Irp->IoStatus.Information = devExt->devFileIoStatus.Information;
				}
				else
				{
					KdPrint((__FUNCTION__" : ZwWriteFile fails with status = 0x%08X\n", status));
				}   					
   			}
			MmUnlockPages(mdl);
		}
	}
	except(EXCEPTION_EXECUTE_HANDLER)
	{
		status = GetExceptionCode();
		KdPrint((__FUNCTION__" : Exception code 0x%08X\n", status));
	}
		
	if(mdl)
	{
		IoFreeMdl(mdl);
	}

	Irp->IoStatus.Status = status;
	IoCompleteRequest(Irp, IO_NO_INCREMENT);
	return status;
}


NTSTATUS
ReadDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
					IN PIRP				Irp	)
{
	NTSTATUS				status		= STATUS_SUCCESS;
	PIO_STACK_LOCATION		ioStack		= IoGetCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION		devExt		= DeviceObject->DeviceExtension;
	ULONG					outBufLen	= ioStack->Parameters.Read.Length;
	PCHAR					outBuf		= NULL;
	PMDL					mdl			= NULL;
	

	PAGED_CODE();
//__debugbreak();
	Irp->IoStatus.Information = 0;
	if (!outBufLen)
	{
		KdPrint((__FUNCTION__" : Output buffer length = %d invalid\n", outBufLen));		
		Irp->IoStatus.Status = STATUS_INVALID_PARAMETER;
		IoCompleteRequest(Irp, IO_NO_INCREMENT);
		return STATUS_INVALID_PARAMETER;
	}
	
	outBuf =  Irp->UserBuffer;
	if(	(outBuf + outBufLen) >= (PCHAR)MM_USER_PROBE_ADDRESS  ||
		outBuf <= (PCHAR)MM_LOWEST_USER_ADDRESS)
	{
		KdPrint( (__FUNCTION__" : Output buffer address = 0x%p invalid\n", outBuf) );
		status = STATUS_INVALID_PARAMETER;
		Irp->IoStatus.Status = status;
		IoCompleteRequest(Irp, IO_NO_INCREMENT);
		return status;
	}

	try
	{
		ProbeForWrite( outBuf, outBufLen, sizeof(UCHAR) );
		mdl = IoAllocateMdl(outBuf, outBufLen, FALSE, TRUE, NULL);
		if (!mdl)
		{
			KdPrint((__FUNCTION__" : IoAllocateMdl return 0x%p for output buffer\n", mdl));
			status = STATUS_INSUFFICIENT_RESOURCES;
		}
		else
		{
			MmProbeAndLockPages(mdl, UserMode, IoReadAccess);
			outBuf = MmGetSystemAddressForMdlSafe(mdl, NormalPagePriority);
			if (!outBuf)
			{
				status = STATUS_INSUFFICIENT_RESOURCES;
				KdPrint((__FUNCTION__" : MmGetSystemAddressForMdlSafe return 0x%p for output buffer", outBuf));
			}
			else
			{
				status = ZwReadFile(	devExt->devFile,
									NULL, NULL, NULL,
									&devExt->devFileIoStatus,
									outBuf, outBufLen,
									&devExt->readOffset, NULL);
				if (NT_SUCCESS(status))
				{
					devExt->readOffset.LowPart += devExt->devFileIoStatus.Information;
					Irp->IoStatus.Information = devExt->devFileIoStatus.Information;
				}
				else
				{
					KdPrint((__FUNCTION__" : ZwReadFile fails with status = 0x%08X\n", status));
				}
			}
			MmUnlockPages(mdl);
		}
	}
	except(EXCEPTION_EXECUTE_HANDLER)
	{
		status = GetExceptionCode();
		KdPrint((__FUNCTION__" : Exception code 0x%08X\n",status));
	}
        		
	if(mdl)
	{
		IoFreeMdl(mdl);
	}
	
	Irp->IoStatus.Status = status;
	IoCompleteRequest(Irp, IO_NO_INCREMENT);
	return status;
}


VOID
DriverUnload(IN PDRIVER_OBJECT DriverObject)
{
	PDEVICE_OBJECT		DeviceObject	= DriverObject->DeviceObject;
	PDEVICE_EXTENSION	devExt		= DeviceObject->DeviceExtension;
	PAGED_CODE();

	ZwClose(devExt->devFile);
	IoDeleteSymbolicLink((PUNICODE_STRING)&symbolicLinkName);
	if (DeviceObject != NULL)
	{
		IoDeleteDevice(DeviceObject);
	}
}
