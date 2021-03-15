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
			
__drv_dispatchType(IRP_MJ_CREATE) 
__drv_dispatchType(IRP_MJ_CLOSE) DRIVER_DISPATCH CreateCloseDispatchRoutine;
NTSTATUS CreateCloseDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
									IN PIRP				Irp	);

__drv_dispatchType(IRP_MJ_DEVICE_CONTROL) DRIVER_DISPATCH DeviceControlDispatchRoutine;
NTSTATUS DeviceControlDispatchRoutine(	IN PDEVICE_OBJECT	DeviceObject,
									IN PIRP				Irp	);

DRIVER_UNLOAD DriverUnload;
VOID DriverUnload(IN PDRIVER_OBJECT	DriverObject);

#ifdef ALLOC_PRAGMA
#pragma alloc_text(INIT, DriverEntry )
#pragma alloc_text(PAGE, CreateCloseDispatchRoutine)
#pragma alloc_text(PAGE, DeviceControlDispatchRoutine)
#pragma alloc_text(PAGE, DriverUnload)
#endif
