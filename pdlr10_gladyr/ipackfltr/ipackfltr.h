#include <ntddk.h>
#include "..\common.h"
#include <pfhook.h>

DECLARE_CONST_UNICODE_STRING(IpFltrDevName, DD_IPFLTRDRVR_DEVICE_NAME);

#define	TAG		'lFpI'	

typedef struct _DEVICE_EXTENSION {
	PDEVICE_OBJECT					IpFltrDevObj;
	PFILE_OBJECT					IpFltrFileObj;
	KEVENT							IpFltrEvent;
	IO_STATUS_BLOCK				IpFltrStatus;
	PF_SET_EXTENSION_HOOK_INFO	IpFltrExtHook;
} DEVICE_EXTENSION, *PDEVICE_EXTENSION;

typedef struct _IP_HEADER_LIST {
	LIST_ENTRY	ListEntry;
	IPHeader		IPHeaderItem;
} IP_HEADER_LIST, *PIP_HEADER_LIST;


DRIVER_INITIALIZE DriverEntry;
NTSTATUS DriverEntry(
			IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath);
			
__drv_dispatchType(IRP_MJ_CREATE) DRIVER_DISPATCH CreateDispatchRoutine; 
NTSTATUS CreateDispatchRoutine(
			IN PDEVICE_OBJECT       DeviceObject,
			IN PIRP                 		Irp);

__drv_dispatchType(IRP_MJ_CLOSE) DRIVER_DISPATCH CloseDispatchRoutine;
NTSTATUS CloseDispatchRoutine(
			IN PDEVICE_OBJECT       DeviceObject,
			IN PIRP                 		Irp);

__drv_dispatchType(IRP_MJ_READ) DRIVER_DISPATCH	ReadDispatchRoutine; 
NTSTATUS ReadDispatchRoutine(
			IN PDEVICE_OBJECT       DeviceObject,
			IN PIRP                 		Irp);

__drv_dispatchType(IRP_MJ_DEVICE_CONTROL) DRIVER_DISPATCH	DeviceControlDispatchRoutine;
NTSTATUS DeviceControlDispatchRoutine(
			IN PDEVICE_OBJECT	DeviceObject,
			IN PIRP				Irp);

DRIVER_UNLOAD DriverUnload;
VOID DriverUnload(IN PDRIVER_OBJECT	DriverObject);


PF_FORWARD_ACTION 
IpPacketsFilter(	unsigned char	*PacketHeader,
				unsigned char	*Packet,
				unsigned int	PacketLength,
				unsigned int	RecvInterfaceIndex,
				unsigned int	SendInterfaceIndex,
				IPAddr		RecvLinkNextHop,
				IPAddr		SendLinkNextHop	);

NTSTATUS
SetIpPacketsFilter(	IN PDEVICE_OBJECT	DeviceObject,
					IN BOOLEAN			state	);				

#ifdef ALLOC_PRAGMA
#pragma alloc_text(INIT, DriverEntry )
#pragma alloc_text(PAGE, CreateDispatchRoutine)
#pragma alloc_text(PAGE, CloseDispatchRoutine)
#pragma alloc_text(PAGE, ReadDispatchRoutine)
#pragma alloc_text(PAGE, DeviceControlDispatchRoutine)
#pragma alloc_text(PAGE, DriverUnload)
#endif
