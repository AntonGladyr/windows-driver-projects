#include "..\common.h"

extern PUSHORT NtBuildNumber;

typedef struct _SYSTEM_SERVICE_TABLE {
	PVOID		*ServiceTable; 
	PULONG		CounterTable; 
	ULONG		ServiceLimit; 
	PCHAR		ArgumentTable; 
} SYSTEM_SERVICE_TABLE, *PSYSTEM_SERVICE_TABLE, **PPSYSTEM_SERVICE_TABLE;

typedef struct _SERVICE_DESCRIPTOR_TABLE {
	SYSTEM_SERVICE_TABLE	ntoskrnl;
	SYSTEM_SERVICE_TABLE	win32k;
	SYSTEM_SERVICE_TABLE	Table3;
	SYSTEM_SERVICE_TABLE	Table4;
} SERVICE_DESCRIPTOR_TABLE, *PSERVICE_DESCRIPTOR_TABLE, **PPSERVICE_DESCRIPTOR_TABLE;

extern PSERVICE_DESCRIPTOR_TABLE KeServiceDescriptorTable;

NTSYSAPI 
NTSTATUS 
NTAPI 
ZwQueryInformationProcess(	IN HANDLE ProcessHandle,
							IN PROCESSINFOCLASS ProcessInformationClass, 
							OUT PVOID ProcessInformation,  
							IN ULONG ProcessInformationLength, 
							OUT PULONG ReturnLength	);

typedef NTSTATUS (NTAPI * fnZwOpenProcess) (
							OUT PHANDLE			ProcessHandle,
							IN ACCESS_MASK			DesiredAccess,
							IN POBJECT_ATTRIBUTES	ObjectAttributes,
							IN PCLIENT_ID			ClientId OPTIONAL);

typedef  NTSTATUS (NTAPI * fnZwTerminateProcess)(
    							IN HANDLE	 ProcessHandle,
    							IN NTSTATUS	ExitStatus);

NTSYSAPI
NTSTATUS
NTAPI
NewZwOpenProcess (	OUT PHANDLE			ProcessHandle,
					IN ACCESS_MASK			DesiredAccess,
					IN POBJECT_ATTRIBUTES	ObjectAttributes,
					IN PCLIENT_ID			ClientId OPTIONAL);

NTSYSAPI
NTSTATUS
NTAPI 
NewZwTerminateProcess(	IN HANDLE	ProcessHandle,
						IN NTSTATUS	ExitStatus    );

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
