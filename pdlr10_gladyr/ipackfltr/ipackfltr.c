#include "ipackfltr.h"

LIST_ENTRY		gPacketsListHead		= {0};
KSPIN_LOCK		gListSpinLock			= {0};

NTSTATUS
DriverEntry(	IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath	)
{
	NTSTATUS			status		= STATUS_SUCCESS;
	PDEVICE_OBJECT		DeviceObject	= NULL;
	PDEVICE_EXTENSION	devExt		= NULL;

	UNREFERENCED_PARAMETER(RegistryPath);

	__debugbreak();
	status = IoCreateDevice(	DriverObject,
							sizeof(DEVICE_EXTENSION),
							(PUNICODE_STRING)&deviceName,
							DEV_TYPE, FILE_DEVICE_SECURE_OPEN,
							FALSE, &DeviceObject	);                        
	
	if (!NT_SUCCESS(status))
	{
		KdPrint((__FUNCTION__":IoCreateDevice fails with status = 0x%08X for device with name %wZ\n", 
					status, (PUNICODE_STRING)&deviceName) );
		return status;
	}
	
	devExt = DeviceObject->DeviceExtension;
	status = IoGetDeviceObjectPointer(
					(PUNICODE_STRING)&IpFltrDevName,   
					FILE_ALL_ACCESS, 
					&devExt->IpFltrFileObj, 
					&devExt->IpFltrDevObj);   
    			
	if (!NT_SUCCESS(status))
	{
		KdPrint((__FUNCTION__":IoGetDeviceObjectPointer fails with status = 0x%08X\n",status ));
		IoDeleteDevice(DeviceObject);
		return status;
	}

	status = IoCreateSymbolicLink(	(PUNICODE_STRING)&symbolicLinkName, 
								(PUNICODE_STRING)&deviceName	);
		
	if (!NT_SUCCESS(status))
	{
		KdPrint((__FUNCTION__":IoCreateSymbolicLink fails with status = 0x%08X\n", status));
		ObDereferenceObject(devExt->IpFltrFileObj);
		IoDeleteDevice(DeviceObject);
		return status;
	}
	KeInitializeEvent( &devExt->IpFltrEvent, NotificationEvent,  FALSE);
	KeInitializeSpinLock( &gListSpinLock );
	InitializeListHead( &gPacketsListHead );
	devExt->IpFltrStatus.Status = STATUS_NOT_IMPLEMENTED;
	
	DeviceObject->Flags |= DO_BUFFERED_IO;//DO_DIRECT_IO;
			
	DriverObject->MajorFunction[IRP_MJ_CREATE]			= 
	DriverObject->MajorFunction[IRP_MJ_CLOSE]				= CloseDispatchRoutine;
	DriverObject->MajorFunction[IRP_MJ_READ]				= ReadDispatchRoutine;
	DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL]	= DeviceControlDispatchRoutine;
	DriverObject->DriverUnload								= DriverUnload;
	
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
ReadDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
					IN PIRP				Irp	)
{
	NTSTATUS				status			= STATUS_SUCCESS;
	PIO_STACK_LOCATION		ioStack			= IoGetCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION		devExt			= DeviceObject->DeviceExtension;
	ULONG					outBufLen		= ioStack->Parameters.Read.Length;
	PCHAR					outBuf			= Irp->AssociatedIrp.SystemBuffer;
	PLIST_ENTRY				packetsListEntry	= NULL;	
	IP_HEADER_LIST*			packetsListItem	= NULL;
	ULONG					packetsCount		= 0;
	ULONG					packetsPerBuffer	= 0;	
	
	PAGED_CODE();
	
	__debugbreak();
	Irp->IoStatus.Information = 0;
	
	if ( outBufLen < sizeof(IPHeader) )
	{
		KdPrint(( __FUNCTION__":Output buffer length = %d less than %d\n", 
				outBufLen, sizeof(IPHeader) ));		
		status = STATUS_BUFFER_TOO_SMALL;
	}
	else
	{
		packetsPerBuffer = outBufLen / sizeof(IPHeader);
	 
		for( packetsCount = 0 ; packetsCount < packetsPerBuffer; packetsCount++)
		{
			packetsListEntry = ExInterlockedRemoveHeadList(
												&gPacketsListHead,
												&gListSpinLock	); 			
			if(NULL == packetsListEntry)
				break;
			
			packetsListItem = CONTAINING_RECORD(packetsListEntry,
												IP_HEADER_LIST,	ListEntry);
			RtlCopyMemory(outBuf, (char*)&packetsListItem->IPHeaderItem, sizeof(IPHeader));
			Irp->IoStatus.Information += sizeof(IPHeader); 
			ExFreePool(packetsListItem);
		}
	}
	Irp->IoStatus.Status = status;
	IoCompleteRequest(Irp, IO_NO_INCREMENT);
	return status;
}

NTSTATUS
DeviceControlDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
							IN PIRP				Irp	)
{
	NTSTATUS				status			= STATUS_SUCCESS;
	PIO_STACK_LOCATION		ioStack			= IoGetCurrentIrpStackLocation(Irp);
	PDEVICE_EXTENSION		devExt			= DeviceObject->DeviceExtension;
	PLIST_ENTRY				packetsListEntry	= NULL;	
	IP_HEADER_LIST*			packetsListItem	= NULL;

	PAGED_CODE();
	
	__debugbreak();
	Irp->IoStatus.Information = 0;
	switch(ioStack->Parameters.DeviceIoControl.IoControlCode)
	{
		case IOCTL_SET_FILTER:
			status = SetIpPacketsFilter(DeviceObject, TRUE);
			break;
		
		case IOCTL_RESET_FILTER:
			status = SetIpPacketsFilter(DeviceObject, FALSE);
			while( NULL != (packetsListEntry = ExInterlockedRemoveHeadList(
												&gPacketsListHead,
												&gListSpinLock	))) 			
			{
				packetsListItem = CONTAINING_RECORD(packetsListEntry,
											IP_HEADER_LIST,	ListEntry);
				ExFreePool(packetsListItem);
			}
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
	PDEVICE_OBJECT		DeviceObject		= DriverObject->DeviceObject;
	PDEVICE_EXTENSION	devExt			= DeviceObject->DeviceExtension;
	PLIST_ENTRY			packetsListEntry	= NULL;	
	IP_HEADER_LIST*		packetsListItem	= NULL;
	
	PAGED_CODE();
	
	SetIpPacketsFilter(DeviceObject, FALSE);
		
	while( NULL != (packetsListEntry = ExInterlockedRemoveHeadList(
												&gPacketsListHead,
												&gListSpinLock	))) 			
	{
		packetsListItem = CONTAINING_RECORD(packetsListEntry,
											IP_HEADER_LIST,	ListEntry);
		ExFreePool(packetsListItem);
	}

	ObDereferenceObject(devExt->IpFltrFileObj);
	IoDeleteSymbolicLink((PUNICODE_STRING)&symbolicLinkName);
	IoDeleteDevice(DeviceObject);
}

PF_FORWARD_ACTION 
IpPacketsFilter(	unsigned char	*PacketHeader,
				unsigned char	*Packet,
				unsigned int	PacketLength,
				unsigned int	RecvInterfaceIndex,
				unsigned int	SendInterfaceIndex,
				IPAddr		RecvLinkNextHop,
				IPAddr		SendLinkNextHop	)
{
	IP_HEADER_LIST*		packetsListItem = NULL;
			
	packetsListItem = (IP_HEADER_LIST*)ExAllocatePoolWithTag( 
										NonPagedPool, 
										sizeof(IP_HEADER_LIST), 
										TAG);
	if(packetsListItem)
	{
		
		RtlCopyMemory( (char*)&packetsListItem->IPHeaderItem, 
						PacketHeader, sizeof(IPHeader) );
		ExInterlockedInsertTailList(	&gPacketsListHead, 
								&packetsListItem->ListEntry, 
								&gListSpinLock);	
	}	
	return PF_FORWARD;	
}

NTSTATUS
SetIpPacketsFilter(	IN PDEVICE_OBJECT	DeviceObject,
					IN BOOLEAN			state	)
{
	PDEVICE_EXTENSION		devExt		= DeviceObject->DeviceExtension;
	PIRP					ipFltrIrp		= NULL;
	NTSTATUS				status		= STATUS_SUCCESS;
		
//	if( NT_SUCCESS(devExt->IpFltrStatus.Status) )
//	{
//		return  devExt->IpFltrStatus.Status;
//	}

	if(state)
	{
		devExt->IpFltrExtHook.ExtensionPointer = IpPacketsFilter;	
	}
	else
	{
		devExt->IpFltrExtHook.ExtensionPointer = 0;
	}
	
	ipFltrIrp = IoBuildDeviceIoControlRequest(
						IOCTL_PF_SET_EXTENSION_POINTER, 
						devExt->IpFltrDevObj, 
						&devExt->IpFltrExtHook, 
						sizeof(devExt->IpFltrExtHook), 
						NULL,  0, FALSE, NULL, 
						&devExt->IpFltrStatus	);     

		if ( !ipFltrIrp )
		{
			KdPrint( (__FUNCTION__":IoBuildDeviceIoControlRequest fails\n") );
			return STATUS_INSUFFICIENT_RESOURCES;
		}
			
		status = IoCallDriver(devExt->IpFltrDevObj, ipFltrIrp);
		if ( STATUS_PENDING == status)
		{
			KdPrint((__FUNCTION__":IoCallDriver return STATUS_PENDING\n"));
			KeWaitForSingleObject(&devExt->IpFltrEvent, 
								UserRequest, 
								KernelMode, FALSE, NULL	);
		}
		KdPrint((__FUNCTION__" return status = 0x%08X\n", devExt->IpFltrStatus.Status));
		return  devExt->IpFltrStatus.Status;			
}
