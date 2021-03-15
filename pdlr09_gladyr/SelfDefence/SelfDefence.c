#include <ntddk.h>
#include "SelfDefence.h"

static ULONG					gZwOpenProcessNumber		= 0;
static ULONG					gZwTerminateProcessNumber	= 0;
static fnZwOpenProcess		gRealZwOpenProcess			= NULL;	
static fnZwTerminateProcess	gRealZwTerminateProcess		= NULL;
static HANDLE				gOwnerPID					= NULL;
static BOOLEAN				gActive						= FALSE;
static PMDL					gSSTMdl						= NULL;
static PVOID*					gSSTAddr					= NULL;

NTSTATUS
DriverEntry(	IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath	)
{
	NTSTATUS			status		= STATUS_SUCCESS;
	PDEVICE_OBJECT		DeviceObject	= NULL;

	UNREFERENCED_PARAMETER(RegistryPath);

/*
1 - NtOpenProcess
2 - NtTerminateProcess
3- ...........
 			NtBuildNumber	1			2			3			
Windows 2000	SP0	2195	0x006a		0x00e0		...........	
				SP1	2195	0x006a		0x00e0		...........
				SP2	2195	0x006a		0x00e0		...........
				SP3	2195	0x006a		0x00e0		...........
				SP4	2195	0x006a		0x00e0		...........
Windows XP		SP0	2600	0x007a		0x0101		...........	
				SP1	2600	0x007a		0x0101		...........
				SP2	2600	0x007a		0x0101		...........
				SP3	2600	0x007a		0x0101		...........
Windows 2003	SP0	3790	0x0080		0x010a		...........	
	Server		SP1	3790	0x0080		0x010a		...........
				SP2	3790	0x0080		0x010a		...........
Windows Vista	SP0	6000	0x00bf		0x014f		...........	
				SP1	6000	0x00c2		0x014e		...........	
				SP2	6002	0x00c2		0x014e		...........	
Windows 2008 	SP0	6001	0x00c2		0x014e		...........	
	Server		SP1	6001	0x00c2		0x014e		...........
				SP2	6002	0x00c2		0x014e		...........	
Windows 7		SP0	7600	0x00be		0x0172		...........
				SP1	7601	0x00be		0x0172		...........
*/

	KdPrint(("NtBuildNumber=%d",(USHORT)*NtBuildNumber));

	switch(*NtBuildNumber)
	{
		case 2195:
			gZwOpenProcessNumber		= 0x006a;
			gZwTerminateProcessNumber	= 0x00e0;
			break;
		case 2600:
			gZwOpenProcessNumber		= 0x007a;
			gZwTerminateProcessNumber	= 0x0101;
			break;
		case 3790:
			gZwOpenProcessNumber		= 0x0080;
			gZwTerminateProcessNumber	= 0x010a;
			break;
		case 6000:
			gZwOpenProcessNumber		= 0x00bf;
			gZwTerminateProcessNumber	= 0x014f;
			break;
		case 6002:
			gZwOpenProcessNumber		= 0x00c2;
			gZwTerminateProcessNumber	= 0x014e;
			break;
		case 6001:
			gZwOpenProcessNumber		= 0x00c2;
			gZwTerminateProcessNumber	= 0x014e;
			break;
		case 7600:
			gZwOpenProcessNumber		= 0x00be;
			gZwTerminateProcessNumber	= 0x0172;
			break;
		case 7601:
			gZwOpenProcessNumber		= 0x00be;
			gZwTerminateProcessNumber	= 0x0172;
			break;
		default:
			return STATUS_DEVICE_CONFIGURATION_ERROR;
			break; 
	}

	gSSTMdl	= IoAllocateMdl(	KeServiceDescriptorTable->ntoskrnl.ServiceTable,
							KeServiceDescriptorTable->ntoskrnl.ServiceLimit*sizeof(PVOID),
							FALSE, FALSE, NULL	);	

	if( !gSSTMdl)
	{
		KdPrint((__FUNCTION__" : IoAllocateMdl fails"));
		return STATUS_INSUFFICIENT_RESOURCES;
	}	
	
	 MmBuildMdlForNonPagedPool(gSSTMdl);
	gSSTAddr = MmGetSystemAddressForMdlSafe(gSSTMdl, NormalPagePriority);
	
	status = IoCreateDevice(DriverObject,
						NULL,
						(PUNICODE_STRING)&deviceName,
						DEV_TYPE, FILE_DEVICE_SECURE_OPEN,
						FALSE, &DeviceObject);                        

	if( !NT_SUCCESS(status) )
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

	DriverObject->MajorFunction[IRP_MJ_CREATE]			=  
	DriverObject->MajorFunction[IRP_MJ_CLOSE]				= CreateCloseDispatchRoutine;
	DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL]	= DeviceControlDispatchRoutine;
	DriverObject->DriverUnload								= DriverUnload;
	gActive	= FALSE;

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
	PHANDLE               			inBuf		= Irp->AssociatedIrp.SystemBuffer;
	ULONG					RegCr0		= 0;

	PAGED_CODE();
	
	Irp->IoStatus.Information = 0;
	switch(ioStack->Parameters.DeviceIoControl.IoControlCode)
	{
		case IOCTL_PROCESS_LOCK:
		
			if( inBufLen != sizeof(HANDLE) )
			{
				KdPrint( (__FUNCTION__" : Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			
			if ( gActive )
			{
				KdPrint( (__FUNCTION__" : Already active\n") );
				break;
			}

			 if(PsGetCurrentProcessId() != *inBuf)
			 {
				KdPrint( (__FUNCTION__" : Stranger process\n") );
				status = STATUS_INVALID_DEVICE_REQUEST;
				break;
			 }
			  
			gOwnerPID = *inBuf;
 		 	
   		 	gRealZwOpenProcess = InterlockedExchangePointer(
 		 			&gSSTAddr[gZwOpenProcessNumber],
 		 			NewZwOpenProcess);

 		 	gRealZwTerminateProcess = InterlockedExchangePointer(
 		 			&gSSTAddr[gZwTerminateProcessNumber],
 		 			NewZwTerminateProcess);
 			
 			gActive = TRUE;
			break;
		case IOCTL_PROCESS_UNLOCK:
			if( inBufLen != sizeof(HANDLE) )
			{
				KdPrint( (__FUNCTION__" : Input buffer length = %d invalid\n", inBufLen) );
				status = STATUS_INVALID_PARAMETER;
				break;
			}
			
			if ( !gActive )
			{
				KdPrint( (__FUNCTION__" : Not active\n") );
				break;
			}

			 if(PsGetCurrentProcessId() != *inBuf)
			 {
				KdPrint( (__FUNCTION__" : Stranger process\n") );
				status = STATUS_INVALID_DEVICE_REQUEST;
				break;
			 } 

  		 	InterlockedExchangePointer(
 		 			&gSSTAddr[gZwOpenProcessNumber],
 		 			gRealZwOpenProcess);

 		 	InterlockedExchangePointer(
 		 			&gSSTAddr[gZwTerminateProcessNumber],
 		 			gRealZwTerminateProcess);
		
 			gActive = FALSE;
 			gOwnerPID = NULL;
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
	ULONG				RegCr0		= 0;
	
	PAGED_CODE();
	
	if ( gActive )
	{
	 	InterlockedExchangePointer(
	 			&gSSTAddr[gZwOpenProcessNumber],
	 			gRealZwOpenProcess);

	 	InterlockedExchangePointer(
	 			&gSSTAddr[gZwTerminateProcessNumber],
	 			gRealZwTerminateProcess);
	}
	
	if( !gSSTMdl )
		IoFreeMdl(gSSTMdl);
				
	IoDeleteSymbolicLink((PUNICODE_STRING)&symbolicLinkName);
	IoDeleteDevice(DeviceObject);
}

NTSTATUS 
NTAPI 
NewZwOpenProcess(	OUT PHANDLE			ProcessHandle,
					IN ACCESS_MASK			DesiredAccess,
					IN POBJECT_ATTRIBUTES	ObjectAttributes,
					IN PCLIENT_ID			ClientId OPTIONAL	)
{
	if(ClientId)
	{
		if(ClientId->UniqueProcess == gOwnerPID)
/*
HANDLE WINAPI OpenProcess(	__in          DWORD dwDesiredAccess, 
							__in          BOOL bInheritHandle, 
							__in          DWORD dwProcessId	);

dwDesiredAccess :		
PROCESS_TERMINATE (0x0001)			-  TerminateProcess
PROCESS_CREATE_THREAD (0x0002)	- CreateRemoteThread 
PROCESS_VM_OPERATION (0x0008)		- VirtualProtectEx/WriteProcessMemory
PROCESS_SET_INFORMATION (0x0200)	- SetPriorityClass
PROCESS_SUSPEND_RESUME (0x800)	- SuspendThread i ResumeThread
*/ 		
		DesiredAccess &= ~( 0x0001 |0x0002|0x0008|0x0200|0x800 );	
	}
	return gRealZwOpenProcess(ProcessHandle, DesiredAccess, ObjectAttributes, ClientId);	
}

NTSTATUS 
NTAPI 
NewZwTerminateProcess(	IN HANDLE	ProcessHandle,
						IN NTSTATUS	ExitStatus    )
{
	PROCESS_BASIC_INFORMATION	processInfo	= {0};
	NTSTATUS						status		= STATUS_SUCCESS;
	HANDLE							processId	= 0;	
	
	if( (HANDLE)0 != ProcessHandle && (HANDLE)-1 !=ProcessHandle )
	{
		status = ZwQueryInformationProcess(
							ProcessHandle, 
							ProcessBasicInformation, 
							&processInfo,
							sizeof(PROCESS_BASIC_INFORMATION), 
							NULL);
		if ( NT_SUCCESS(status) )
		{
			if( processInfo.UniqueProcessId == (ULONG_PTR)gOwnerPID )
				return STATUS_ACCESS_DENIED;
		}		
	}
	return gRealZwTerminateProcess(ProcessHandle, ExitStatus);	
}