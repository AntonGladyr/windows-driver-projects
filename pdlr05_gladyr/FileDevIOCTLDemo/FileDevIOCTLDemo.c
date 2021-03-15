#include <ntddk.h>
#include "FileDevIOCTLDemo.h"

NTSTATUS
DriverEntry(	IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath	)
{
	NTSTATUS			status		= STATUS_SUCCESS;
	PDEVICE_OBJECT		DeviceObject	= NULL;
	PDEVICE_EXTENSION	devExt		= NULL;
	
	DECLARE_CONST_UNICODE_STRING(devFileName, L"\\??\\C:\\FileDevIOCTLDemoDeviceFile.txt");

	UNREFERENCED_PARAMETER(RegistryPath);

	status = IoCreateDevice(DriverObject,
							sizeof(DEVICE_EXTENSION),
							(PUNICODE_STRING)&deviceName,
							DEV_TYPE, FILE_DEVICE_SECURE_OPEN,
							FALSE, &DeviceObject);                        
	
	if (!NT_SUCCESS(status))
	{
		KdPrint((__FUNCTION__":IoCreateDevice fails with status = 0x%08X for device with name %wZ\n", 
					status, (PUNICODE_STRING)&deviceName) );
		return status;
	}
	
	status = IoCreateSymbolicLink(	(PUNICODE_STRING)&symbolicLinkName, 
									(PUNICODE_STRING)&deviceName	);
		
	if (!NT_SUCCESS(status))
	{
		KdPrint((__FUNCTION__":IoCreateSymbolicLink fails with status = 0x%08X\n", status));
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

	DriverObject->MajorFunction[IRP_MJ_CREATE]			= CreateCloseDispatchRoutine; 
	DriverObject->MajorFunction[IRP_MJ_CLOSE]				= CreateCloseDispatchRoutine;
	DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL]	= DeviceControlDispatchRoutine;
	DriverObject->DriverUnload								= DriverUnload;

	return status;
}

NTSTATUS
CreateCloseDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
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
DeviceControlDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
							IN PIRP				Irp	)
{
	NTSTATUS				status		= STATUS_SUCCESS;
	PIO_STACK_LOCATION		ioStack		= IoGetCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION		devExt		= DeviceObject->DeviceExtension;
	ULONG					inBufLen		= ioStack->Parameters.DeviceIoControl.InputBufferLength;
	ULONG					outBufLen	= ioStack->Parameters.DeviceIoControl.OutputBufferLength;
	PMDL					mdl			= NULL;
	PCHAR               			inBuf		= NULL;
	PCHAR               			outBuf		= NULL;

	PAGED_CODE();
	
	Irp->IoStatus.Information = 0;
	
	switch(ioStack->Parameters.DeviceIoControl.IoControlCode)
	{
		case IOCTL_BUFFERED_WRITE:
			if(inBufLen > IN_BUFFER_SIZE || !inBufLen)
			{
				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				Irp->IoStatus.Status = status;
				IoCompleteRequest(Irp, IO_NO_INCREMENT);
				return status;
			}
			inBuf = Irp->AssociatedIrp.SystemBuffer;
			status = ZwWriteFile(devExt->devFile,
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
			break;
			
		case IOCTL_BUFFERED_READ:
			if(outBufLen > OUT_BUFFER_SIZE || !outBufLen)
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d invalid\n", outBufLen) );
				status = STATUS_INVALID_PARAMETER;
				Irp->IoStatus.Status = status;
				IoCompleteRequest(Irp, IO_NO_INCREMENT);
				return status;
			}
			outBuf = Irp->AssociatedIrp.SystemBuffer;
			status = ZwReadFile(devExt->devFile,
							NULL, NULL, NULL,
							&devExt->devFileIoStatus,
							outBuf, outBufLen,
							&devExt->readOffset, 
							NULL);	
			if (NT_SUCCESS(status))
			{
				devExt->readOffset.LowPart+=devExt->devFileIoStatus.Information;
				Irp->IoStatus.Information = devExt->devFileIoStatus.Information;
			}			
			break;
		
		case IOCTL_DIRECT_WRITE:
			if(inBufLen > IN_BUFFER_SIZE || !inBufLen)
			{
				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				Irp->IoStatus.Status = status;
				IoCompleteRequest(Irp, IO_NO_INCREMENT);
				return status;
			}
			inBuf	= Irp->AssociatedIrp.SystemBuffer;
			status = ZwWriteFile(devExt->devFile,
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
			break;
		
		case IOCTL_DIRECT_READ:
			mdl = Irp->MdlAddress;
			outBuf = MmGetSystemAddressForMdlSafe(mdl, NormalPagePriority);
			status = ZwReadFile(devExt->devFile,
							NULL, NULL, NULL,
							&devExt->devFileIoStatus,
							outBuf, outBufLen,
							&devExt->readOffset, 
							NULL);	
			if (NT_SUCCESS(status))
			{
				devExt->readOffset.LowPart+=devExt->devFileIoStatus.Information;
				Irp->IoStatus.Information = devExt->devFileIoStatus.Information;
			}			
			break;

		case IOCTL_NEITHER_WRITE:
			if(inBufLen > IN_BUFFER_SIZE || !inBufLen)
			{
				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				Irp->IoStatus.Status = status;
				IoCompleteRequest(Irp, IO_NO_INCREMENT);
				return status;
			}
			inBuf	= ioStack->Parameters.DeviceIoControl.Type3InputBuffer;
			// перевіряємо чи розташовані буфери в адресному просторі режиму користувача
			if((inBuf + inBufLen) >= (PCHAR)MM_USER_PROBE_ADDRESS ||
				inBuf <= (PCHAR)MM_LOWEST_USER_ADDRESS )
			{
				KdPrint( (__FUNCTION__":Input buffer address = 0x%p invalid\n", inBuf) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			// перевіряємо вирівнювання і доступність для читання вхідного буфера
			try
			{
				ProbeForRead( inBuf, inBufLen, sizeof(UCHAR) );
			}
			except(EXCEPTION_EXECUTE_HANDLER)
			{
				status = GetExceptionCode();
				KdPrint((__FUNCTION__":ProbeForRead raise exception with code 0x%08X for input buffer\n", status));
				break;
       			}

			mdl = IoAllocateMdl(inBuf, inBufLen, FALSE, TRUE, NULL);
			if(!mdl)
			{
				KdPrint((__FUNCTION__":IoAllocateMdl return 0x%p for input buffer\n", mdl));
				status = STATUS_INSUFFICIENT_RESOURCES;
				break;
			}
								
			try
			{
				MmProbeAndLockPages(mdl, UserMode, IoReadAccess);
			}
			except(EXCEPTION_EXECUTE_HANDLER)
			{
				status = GetExceptionCode();
				KdPrint((__FUNCTION__":MmProbeAndLockPages raise exception with code 0x%08X for input buffer\n", status));
				IoFreeMdl(mdl);
				break;
			}
					
			inBuf = MmGetSystemAddressForMdlSafe(mdl, NormalPagePriority);
			if (!inBuf)
			{
				status = STATUS_INSUFFICIENT_RESOURCES;
        				KdPrint((__FUNCTION__":MmGetSystemAddressForMdlSafe return 0x%p for input buffer\n", inBuf));
       				break;
   			}
			status = ZwWriteFile(devExt->devFile,
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
			MmUnlockPages(mdl);
			IoFreeMdl(mdl);
			break;
			
		case IOCTL_NEITHER_READ:
			outBuf	=Irp->UserBuffer;
			// перевіряємо чи розташовані буфери в адресному просторі режиму користувача
			if((outBuf + outBufLen) >= (PCHAR)MM_USER_PROBE_ADDRESS ||
				outBuf <= (PCHAR)MM_LOWEST_USER_ADDRESS )
			{
				KdPrint( (__FUNCTION__":output buffer address = 0x%p invalid\n", outBuf) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			// перевіряємо вирівнювання і доступність для читання вхідного буфера
			try
			{
				ProbeForRead( outBuf, outBufLen, sizeof(UCHAR) );
			}
			except(EXCEPTION_EXECUTE_HANDLER)
			{
				status = GetExceptionCode();
				KdPrint((__FUNCTION__":ProbeForRead raise exception with code 0x%08X for output buffer\n", status));
				break;
       			}

			mdl = IoAllocateMdl(outBuf, outBufLen, FALSE, TRUE, NULL);
			if(!mdl)
			{
				KdPrint((__FUNCTION__":IoAllocateMdl return 0x%p for output buffer\n", mdl));
				status = STATUS_INSUFFICIENT_RESOURCES;
				break;
			}
								
			try
			{
				MmProbeAndLockPages(mdl, UserMode, IoReadAccess);
			}
			except(EXCEPTION_EXECUTE_HANDLER)
			{
				status = GetExceptionCode();
				KdPrint((__FUNCTION__":MmProbeAndLockPages raise exception with code 0x%08X for output buffer\n", status));
				IoFreeMdl(mdl);
				break;
			}
					
			outBuf = MmGetSystemAddressForMdlSafe(mdl, NormalPagePriority);
			if (!outBuf)
			{
				status = STATUS_INSUFFICIENT_RESOURCES;
        				KdPrint((__FUNCTION__":MmGetSystemAddressForMdlSafe return 0x%p for input buffer\n", inBuf));
       				break;
   			}
			status = ZwReadFile(devExt->devFile,
							NULL, NULL, NULL,
							&devExt->devFileIoStatus,
							outBuf, outBufLen,
							&devExt->readOffset, 
							NULL);	
			if (NT_SUCCESS(status))
			{
				devExt->readOffset.LowPart+=devExt->devFileIoStatus.Information;
				Irp->IoStatus.Information = devExt->devFileIoStatus.Information;
			}
			MmUnlockPages(mdl);
			IoFreeMdl(mdl);
			break;
			
		default:
			status = STATUS_INVALID_DEVICE_REQUEST;
			break;
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
