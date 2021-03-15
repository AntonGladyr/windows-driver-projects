#include <ntddk.h>
#include "ProcessNotify.h"

static BOOLEAN				gNotifyState			= FALSE;			
static PKEVENT				gEventSendData		= 0;
static PKEVENT				gEventImageSendData	= 0;
static KMUTEX				gMutex				= {0};
static KMUTEX				gImageMutex			= {0};		
static PROCESS_NOTIFY_INFO	gProcessNotifyInfo	= {0, 0, 0};
static IMAGE_NOTIFY_INFO	gProcessImageNotifyInfo = {0};

void ProcessNotifyRoutine(	HANDLE		parentId, 
						HANDLE		processId, 
						BOOLEAN	isCreate	)
{
	KeWaitForSingleObject(&gMutex, UserRequest, KernelMode, TRUE, NULL);
	gProcessNotifyInfo.ParentId	= parentId;
	gProcessNotifyInfo.ProcessId	= processId;
	gProcessNotifyInfo.Create		= isCreate;
	KeSetEvent(gEventSendData, IO_NO_INCREMENT, FALSE);
	KeReleaseMutex(&gMutex, FALSE);
	return;	
}

void ImageNotifyRoutine(	PUNICODE_STRING fullImageName,
						HANDLE processId,
						PIMAGE_INFO imageInfo	)
{
	KeWaitForSingleObject(&gImageMutex, UserRequest, KernelMode, TRUE, NULL);
	memcpy(gProcessImageNotifyInfo.FullImageName, fullImageName->Buffer, fullImageName->Length );
	gProcessImageNotifyInfo.ImageSize = imageInfo->ImageSize;
	gProcessImageNotifyInfo.ImageBase = imageInfo->ImageBase;
	KeSetEvent(gEventImageSendData, IO_NO_INCREMENT, FALSE);
	KeReleaseMutex(&gImageMutex, FALSE);
	return;
}

NTSTATUS
DriverEntry(	IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath	)
{
	NTSTATUS		status		= STATUS_SUCCESS;
	PDEVICE_OBJECT	DeviceObject	= NULL;

	UNREFERENCED_PARAMETER(RegistryPath);

	status = IoCreateDevice(	DriverObject,
							0,
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
	KeInitializeMutex(&gMutex, 0);
	KeInitializeMutex(&gImageMutex, 0);
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
	ULONG					inBufLen		= ioStack->Parameters.DeviceIoControl.InputBufferLength;
	ULONG					outBufLen	= ioStack->Parameters.DeviceIoControl.OutputBufferLength;
	PHANDLE               			inBuf		= Irp->AssociatedIrp.SystemBuffer;
	PVOID               			outBuf		= Irp->AssociatedIrp.SystemBuffer;
	
	PAGED_CODE();
	
	Irp->IoStatus.Information = 0;
	switch(ioStack->Parameters.DeviceIoControl.IoControlCode)
	{
		case IOCTL_START:
			if(gNotifyState)
			{
				KdPrint( (__FUNCTION__":IOCTL_START duplicate\n") );
				break;	
			}			

			if(inBufLen != 2 * sizeof(HANDLE) )
			{
				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			
			status = ObReferenceObjectByHandle(
								*inBuf, 
								EVENT_MODIFY_STATE, 
								*ExEventObjectType, 
								Irp->RequestorMode, 
								&gEventSendData, 
								NULL);
			if( !NT_SUCCESS(status) )
			{
				KdPrint( (__FUNCTION__":ObReferenceObjectByHandle  fails with status = 0x%08X\n", status) );
				break;
			}
			ObDereferenceObject(gEventSendData);
			
			status = ObReferenceObjectByHandle(
								*(inBuf+1), 
								EVENT_MODIFY_STATE, 
								*ExEventObjectType, 
								Irp->RequestorMode, 
								&gEventImageSendData, 
								NULL);
			if( !NT_SUCCESS(status) )
			{
				KdPrint( (__FUNCTION__":ObReferenceObjectByHandle  fails with status = 0x%08X\n", status) );
				break;
			}
			ObDereferenceObject(gEventImageSendData);
			status = PsSetCreateProcessNotifyRoutine(&ProcessNotifyRoutine, FALSE);
			if( NT_SUCCESS(status) )
			{
				gNotifyState = TRUE;
			}
			else
			{
				KdPrint( (__FUNCTION__":PsSetCreateProcessNotifyRoutine  fails with status = 0x%08X\n", status) );					
			}
			
			status = PsSetLoadImageNotifyRoutine(&ImageNotifyRoutine);
			if(! NT_SUCCESS(status) )
			{
				KdPrint( (__FUNCTION__":PsSetLoadImageNotifyRoutine  fails with status = 0x%08X\n", status) );
			}
			
			break;
			
		case IOCTL_STOP:
			if(gNotifyState)
			{
				status = PsSetCreateProcessNotifyRoutine(&ProcessNotifyRoutine, TRUE);
				if ( NT_SUCCESS(status) )
				{
					gNotifyState = FALSE;
				}
				else
				{
					KdPrint( (__FUNCTION__":PsSetCreateProcessNotifyRoutine  fails with status = 0x%08X\n", status) );						
				}
				
				status = PsRemoveLoadImageNotifyRoutine(&ImageNotifyRoutine);
				if(! NT_SUCCESS(status) )
				{
					KdPrint( (__FUNCTION__":PsRemoveLoadImageNotifyRoutine  fails with status = 0x%08X\n", status) );
				}		
			}
			break;
			
		case IOCTL_GET_INFO:
			if( outBufLen < sizeof(PROCESS_NOTIFY_INFO) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d small\n", inBufLen) );
				status = STATUS_BUFFER_TOO_SMALL;
				break;
			}
			KeWaitForSingleObject(&gMutex, UserRequest, KernelMode, TRUE, NULL);
			memcpy(outBuf, &gProcessNotifyInfo, sizeof(PROCESS_NOTIFY_INFO) );
			KeReleaseMutex(&gMutex, FALSE);
			status = STATUS_SUCCESS;
			Irp->IoStatus.Information = sizeof(PROCESS_NOTIFY_INFO);
			break;
		case IOCTL_GET_IMAGE_INFO:
			if( outBufLen < sizeof(IMAGE_NOTIFY_INFO) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d small\n", inBufLen) );
				status = STATUS_BUFFER_TOO_SMALL;
				break;
			}
			KeWaitForSingleObject(&gImageMutex, UserRequest, KernelMode, TRUE, NULL);
			memcpy(outBuf, &gProcessImageNotifyInfo, sizeof(IMAGE_NOTIFY_INFO) );
			KeReleaseMutex(&gImageMutex, FALSE);
			status = STATUS_SUCCESS;
			Irp->IoStatus.Information = sizeof(IMAGE_NOTIFY_INFO);
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
	PDEVICE_OBJECT	DeviceObject	= DriverObject->DeviceObject;
	NTSTATUS		status		= STATUS_SUCCESS;
	
	PAGED_CODE();

	if(gNotifyState)
	{
		status = PsSetCreateProcessNotifyRoutine(&ProcessNotifyRoutine, TRUE);
		if ( !NT_SUCCESS(status) )
		{
			KdPrint( (__FUNCTION__":PsSetCreateProcessNotifyRoutine  fails with status = 0x%08X\n", status) );						
		}
		
		status = PsRemoveLoadImageNotifyRoutine(&ImageNotifyRoutine);
		if(! NT_SUCCESS(status) )
		{
			KdPrint( (__FUNCTION__":PsRemoveLoadImageNotifyRoutine  fails with status = 0x%08X\n", status) );
		}				
	}

	IoDeleteSymbolicLink((PUNICODE_STRING)&symbolicLinkName);
	if (DeviceObject != NULL)
	{
		IoDeleteDevice(DeviceObject);
	}
}
