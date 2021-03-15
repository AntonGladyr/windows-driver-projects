#include <wdm.h>
#include "pciconfigviewer.h"

NTSTATUS
DriverEntry(	IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath	)
{
	NTSTATUS		status		= STATUS_SUCCESS;
	PDEVICE_OBJECT	DeviceObject	= NULL;

	UNREFERENCED_PARAMETER(RegistryPath);

	status = IoCreateDevice(	DriverObject, 0,
							(PUNICODE_STRING)&deviceName,
							DEV_TYPE, FILE_DEVICE_SECURE_OPEN,
							FALSE, &DeviceObject	);                        
	
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
	PPCI_SLOT_NUMBER_EXT	inBuf		= NULL;
	PULONG					inBufReg		= NULL;
	PULONG					outBuf		= Irp->AssociatedIrp.SystemBuffer;
	PCI_SLOT_NUMBER_EXT	slotNum		= {0};
	ULONG					regNum		= 0;
	ULONG					bus = 0, device = 0, function = 0;
	ULONG					classCode = 0;
	BOOLEAN				isDeviceFound = FALSE;
		
	PAGED_CODE();
	
	Irp->IoStatus.Information = 0;
	switch(ioStack->Parameters.DeviceIoControl.IoControlCode)
	{
		case IOCTL_GET_PCI_COMMON_HEADER:
			inBuf = Irp->AssociatedIrp.SystemBuffer;
			if( inBufLen != sizeof(PCI_SLOT_NUMBER_EXT) )
			{
				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			if( outBufLen < sizeof(PCI_COMMON_HEADER) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d too small\n", outBufLen) );
				status = STATUS_BUFFER_TOO_SMALL;
				break;
			}
		
			slotNum	= *inBuf;
			slotNum.u.bits.RegisterNumber	= 0;
			slotNum.u.bits.Reserved1		= 0;
			slotNum.u.bits.TestBit			= 1;
			
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
			WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);
			*outBuf = READ_PORT_ULONG((PULONG)0xcfc);
			if( (ULONG)0xffffffff != *outBuf)
			{
				for(regNum = 1 ; regNum <= 15 ; regNum++)
				{
					slotNum.u.bits.RegisterNumber+=4;
					WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);
					*(outBuf+regNum) = READ_PORT_ULONG((PULONG)0xcfc);
				}
				Irp->IoStatus.Information = 16*sizeof(ULONG);
			}
			else
			{
				status = STATUS_INVALID_PARAMETER;
				Irp->IoStatus.Information = sizeof(ULONG);
			}
#pragma warning(pop)			
			break;
			
		case IOCTL_FIND_PCI_DEVICE:
			inBufReg = Irp->AssociatedIrp.SystemBuffer;
			if( inBufLen != 2 * sizeof(ULONG) )
			{
				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			if( outBufLen != sizeof(PCI_SLOT_NUMBER_EXT) + 16*sizeof(ULONG) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d too small\n", outBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			
			slotNum.u.bits.RegisterNumber	= 0;
			slotNum.u.bits.Reserved1		= 0;
			slotNum.u.bits.TestBit			= 1;
			
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
			
			for(bus = 0 ; bus < PCI_MAX_BRIDGE_NUMBER ; bus++)
			{
				slotNum.u.bits.BusNumber = bus;
				slotNum.u.bits.DeviceNumber = *(inBufReg + 1);			
				for(function = 0 ; function < PCI_MAX_FUNCTION ; function++)
				{
					slotNum.u.bits.FunctionNumber = function;
					WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);
					if( *inBufReg == READ_PORT_ULONG((PULONG)0xcfc))
					{
						*outBuf = READ_PORT_ULONG((PULONG)0xcfc);
						for(regNum = 1 ; regNum <= 15 ; regNum++)
						{
							slotNum.u.bits.RegisterNumber+=4;
							WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);
							*(outBuf+regNum) = READ_PORT_ULONG((PULONG)0xcfc);
						}
						*(outBuf+regNum) = slotNum.u.AsULONG;
						isDeviceFound = TRUE;
						break;
					}
					
					if (isDeviceFound == TRUE) break;
				}
					
				if (isDeviceFound == TRUE) break;
				slotNum.u.bits.BusNumber = 0;
				slotNum.u.bits.DeviceNumber = 0;
				slotNum.u.bits.FunctionNumber = 0;
				memset(outBuf, 0, 16*sizeof(ULONG) + sizeof(PCI_SLOT_NUMBER_EXT));
			}
			
			Irp->IoStatus.Information = 16*sizeof(ULONG) + sizeof(PCI_SLOT_NUMBER_EXT) ;
#pragma warning(pop)	
			break;
		
		case IOCTL_GET_PCI_CLASS_CODE:
			inBufReg = Irp->AssociatedIrp.SystemBuffer;
			if( inBufLen != 2 * sizeof(ULONG) )
			{
				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			if( outBufLen != sizeof(PCI_SLOT_NUMBER_EXT) + 16*sizeof(ULONG) )
			{
				KdPrint( (__FUNCTION__":Output buffer length = %d too small\n", outBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			
			slotNum.u.bits.RegisterNumber	= 8;
			slotNum.u.bits.Reserved1		= 0;
			slotNum.u.bits.TestBit			= 1;
			
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
			
			for(bus = 0 ; bus < PCI_MAX_BRIDGE_NUMBER ; bus++)
			{
				slotNum.u.bits.BusNumber = bus;
				slotNum.u.bits.DeviceNumber = *(inBufReg + 1);			
				for(function = 0 ; function < PCI_MAX_FUNCTION ; function++)
				{
					slotNum.u.bits.FunctionNumber = function;
					WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);
					// reset the lowest 8 bits
					classCode = READ_PORT_ULONG((PULONG)0xcfc) & (ULONG)0xffffff00;
					if( *inBufReg == classCode )
					{
						slotNum.u.bits.RegisterNumber = 0;
						WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);
						*outBuf = READ_PORT_ULONG((PULONG)0xcfc);
						for(regNum = 1 ; regNum <= 15 ; regNum++)
						{
							slotNum.u.bits.RegisterNumber+=4;
							WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);
							*(outBuf+regNum) = READ_PORT_ULONG((PULONG)0xcfc);
						}
						*(outBuf+regNum) = slotNum.u.AsULONG;
						isDeviceFound = TRUE;
						break;
					}
					if (isDeviceFound == TRUE) break;
				}
				if (isDeviceFound == TRUE) break;
				slotNum.u.bits.BusNumber = 0;
				slotNum.u.bits.DeviceNumber = 0;
				slotNum.u.bits.FunctionNumber = 0;
				memset(outBuf, 0, 16*sizeof(ULONG) + sizeof(PCI_SLOT_NUMBER_EXT));
			}
			Irp->IoStatus.Information = 16*sizeof(ULONG) + sizeof(PCI_SLOT_NUMBER_EXT) ;
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
