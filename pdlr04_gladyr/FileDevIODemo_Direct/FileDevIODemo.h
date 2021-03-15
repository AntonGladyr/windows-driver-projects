#include <ntddk.h>
#include <ntstrsafe.h>

#include "..\common.h"

typedef struct _DEVICE_EXTENSION {
	HANDLE				devFile;
	OBJECT_ATTRIBUTES	devFileAttr;
	IO_STATUS_BLOCK	devFileIoStatus;
	LARGE_INTEGER  		writeOffset;
	LARGE_INTEGER  		readOffset;
} DEVICE_EXTENSION, *PDEVICE_EXTENSION;


DRIVER_INITIALIZE DriverEntry;
NTSTATUS DriverEntry(	IN OUT PDRIVER_OBJECT	DriverObject,
						IN PUNICODE_STRING		RegistryPath	);
			
__drv_dispatchType(IRP_MJ_CREATE) DRIVER_DISPATCH CreateDispatchRoutine; 
NTSTATUS CreateDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
								IN PIRP				Irp	);

__drv_dispatchType(IRP_MJ_CLOSE) DRIVER_DISPATCH CloseDispatchRoutine;
NTSTATUS CloseDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
								IN PIRP				Irp	);

__drv_dispatchType(IRP_MJ_WRITE) DRIVER_DISPATCH WriteDispatchRoutine; 
NTSTATUS WriteDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
								IN PIRP	Irp	);

__drv_dispatchType(IRP_MJ_READ) DRIVER_DISPATCH	ReadDispatchRoutine; 
NTSTATUS ReadDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
								IN PIRP	Irp	);

DRIVER_UNLOAD DriverUnload;
VOID DriverUnload(IN PDRIVER_OBJECT	DriverObject);

#ifdef ALLOC_PRAGMA
#pragma alloc_text(INIT, DriverEntry )

#pragma alloc_text(PAGE, CreateDispatchRoutine)
#pragma alloc_text(PAGE, CloseDispatchRoutine)
//#pragma alloc_text(PAGE, CreateCloseDispatchRoutine)

#pragma alloc_text(PAGE, WriteDispatchRoutine)
#pragma alloc_text(PAGE, ReadDispatchRoutine)

#pragma alloc_text(PAGE, DriverUnload)
#endif
