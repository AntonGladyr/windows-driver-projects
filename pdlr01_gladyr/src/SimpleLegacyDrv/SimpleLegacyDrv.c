#include <ntddk.h>
#include "SimpleLegacyDrv.h"

NTSTATUS
DriverEntry(
	IN OUT PDRIVER_OBJECT	DriverObject,
	IN PUNICODE_STRING		RegistryPath
	)
{
	PEPROCESS	process	= NULL;
	SELECTOR	selector	= {0};
	__debugbreak();
	DbgPrint("\nStart DriverEntry");
	DbgPrint("\nRegistryPath : %wZ", RegistryPath);
	DbgPrint("\nCurrent IRQL : %d", KeGetCurrentIrql());
	process = PsGetCurrentProcess();
	DbgPrint("\nCurrent process : 0x%X ( %s ) ", process, process == PsInitialSystemProcess  ? "System Process" : "Not System Process");  
	__asm { mov selector,cs}
	DbgPrint("\nCS : 0x%04X ( Index = %d, TI = %d, CPL = %d ) ", selector.u.SReg, selector.u.bits.Index, selector.u.bits.TI, selector.u.bits.CPL);
	DbgPrint("\nFinish DriverEntry");
	return STATUS_DEVICE_CONFIGURATION_ERROR;
}

