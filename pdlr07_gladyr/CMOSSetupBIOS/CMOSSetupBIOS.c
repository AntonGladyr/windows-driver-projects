#include <ntddk.h>
#include "CMOSSetupBIOS.h"

NTSTATUS
DriverEntry(	IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath	)
{
	NTSTATUS		status			= STATUS_SUCCESS;
	PDEVICE_OBJECT	DeviceObject	= NULL;

	UNREFERENCED_PARAMETER(RegistryPath);

	status = IoCreateDevice(	DriverObject, 0,
							(PUNICODE_STRING)&deviceName,
							DEV_TYPE, FILE_DEVICE_SECURE_OPEN,
							FALSE, &DeviceObject );                        
	
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

	DriverObject->MajorFunction[IRP_MJ_CREATE]		= CreateCloseDispatchRoutine;
	DriverObject->MajorFunction[IRP_MJ_CLOSE]			= CreateCloseDispatchRoutine;
	DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL]	= DeviceControlDispatchRoutine;
	DriverObject->DriverUnload							= DriverUnload;

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
	NTSTATUS					status		= STATUS_SUCCESS;
	PIO_STACK_LOCATION			ioStack		= IoGetCurrentIrpStackLocation(Irp);
	ULONG						inBufLen		= ioStack->Parameters.DeviceIoControl.InputBufferLength;
	ULONG						outBufLen	= ioStack->Parameters.DeviceIoControl.OutputBufferLength;
	PCHAR               				inBuf		= Irp->AssociatedIrp.SystemBuffer;
	PCHAR               				outBuf		= Irp->AssociatedIrp.SystemBuffer;

	PAGED_CODE();
	
	Irp->IoStatus.Information = 0;
	switch(ioStack->Parameters.DeviceIoControl.IoControlCode)
	{
		case IOCTL_GET_CURRENT_DATE_TIME:
		//Перевіряємо розміри буферів. Розмір вхідного і вихідного буферів та їх 
		//наявність взагалі для кожного IOCTL-запиту в ЗАГАЛЬНОМУ ВИПАДКУ РІЗНИЙ
			if( outBufLen != 6 * sizeof(UCHAR) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}

#pragma warning(push)
#pragma warning(disable: 28138)
/*
28138 - The constant argument <operand> should instead be variable
The driver is calling a function that expects a variable or a non-constant 
expression, but the call includes a constant. For example, the parameter 
of the READ_PORT_ ... /WRITE_PORT_... macro must be a pointer to the 
port address, not the address provided as a constant.
There are a few older devices for which a constant parameter is acceptable
with  the READ_PORT and WRITE_PORT family of functions. When those 
devices receive this warning, the warning can be suppressed or ignored.
*/
			
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x07);
			*outBuf = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x08);
			*(outBuf + 1) = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x09);
			*(outBuf + 2) = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x04);
			*(outBuf + 3) = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x02);
			*(outBuf + 4) = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x00);
			*(outBuf + 5) = READ_PORT_UCHAR((PUCHAR)0x71);
			Irp->IoStatus.Information = 6 * sizeof(UCHAR);
			
#pragma warning(pop)	
			break;
			
		case IOCTL_SET_NEW_DATE_TIME:
			if( inBufLen != 6 * sizeof(UCHAR) )
			{
				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			if( outBufLen != 6 * sizeof(UCHAR) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d invalid\n", outBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			
#pragma warning(push)
#pragma warning(disable: 28138)
/*
28138 - The constant argument <operand> should instead be variable
The driver is calling a function that expects a variable or a non-constant 
expression, but the call includes a constant. For example, the parameter 
of the READ_PORT_ ... /WRITE_PORT_... macro must be a pointer to the 
port address, not the address provided as a constant.
There are a few older devices for which a constant parameter is acceptable
with  the READ_PORT and WRITE_PORT family of functions. When those 
devices receive this warning, the warning can be suppressed or ignored.
*/
			// set new date and time
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x07);
			WRITE_PORT_UCHAR((PUCHAR)0x71, *inBuf);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x08);
			WRITE_PORT_UCHAR((PUCHAR)0x71, *(inBuf + 1));
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x09);
			WRITE_PORT_UCHAR((PUCHAR)0x71, *(inBuf + 2));
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x04);
			WRITE_PORT_UCHAR((PUCHAR)0x71, *(inBuf + 3));
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x02);
			WRITE_PORT_UCHAR((PUCHAR)0x71, *(inBuf + 4));
			//WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x00);
			//WRITE_PORT_UCHAR((PUCHAR)0x71, *(inBuf + 5));
			
			// read date and time
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x07);
			*outBuf = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x08);
			*(outBuf + 1) = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x09);
			*(outBuf + 2) = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x04);
			*(outBuf + 3) = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x02);
			*(outBuf + 4) = READ_PORT_UCHAR((PUCHAR)0x71);
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x00);
			*(outBuf + 5) = READ_PORT_UCHAR((PUCHAR)0x71);
			Irp->IoStatus.Information = 6 * sizeof(UCHAR);

#pragma warning(pop)
			break;
			
		case IOCTL_GET_DIAGNOSTIC_STATUS:
			if( outBufLen != sizeof(UCHAR) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			
#pragma warning(push)
#pragma warning(disable: 28138)
/*
28138 - The constant argument <operand> should instead be variable
The driver is calling a function that expects a variable or a non-constant 
expression, but the call includes a constant. For example, the parameter 
of the READ_PORT_ ... /WRITE_PORT_... macro must be a pointer to the 
port address, not the address provided as a constant.
There are a few older devices for which a constant parameter is acceptable
with  the READ_PORT and WRITE_PORT family of functions. When those 
devices receive this warning, the warning can be suppressed or ignored.
*/
			
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x0E);
			*outBuf = READ_PORT_UCHAR((PUCHAR)0x71);
			Irp->IoStatus.Information =  sizeof(UCHAR);
			
#pragma warning(pop)
			break;
			
		case IOCTL_GET_STATUS_REGISTER_D:
			if( outBufLen != sizeof(UCHAR) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			
#pragma warning(push)
#pragma warning(disable: 28138)
/*
28138 - The constant argument <operand> should instead be variable
The driver is calling a function that expects a variable or a non-constant 
expression, but the call includes a constant. For example, the parameter 
of the READ_PORT_ ... /WRITE_PORT_... macro must be a pointer to the 
port address, not the address provided as a constant.
There are a few older devices for which a constant parameter is acceptable
with  the READ_PORT and WRITE_PORT family of functions. When those 
devices receive this warning, the warning can be suppressed or ignored.
*/
			
			WRITE_PORT_UCHAR((PUCHAR)0x70, (UCHAR)0x0D);
			*outBuf = READ_PORT_UCHAR((PUCHAR)0x71);
			Irp->IoStatus.Information =  sizeof(UCHAR);
			
#pragma warning(pop)
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
	PDEVICE_OBJECT	DeviceObject = DriverObject->DeviceObject;

	PAGED_CODE();

	IoDeleteSymbolicLink((PUNICODE_STRING)&symbolicLinkName);
	if (DeviceObject != NULL)
	{
		IoDeleteDevice(DeviceObject);
	}
}
