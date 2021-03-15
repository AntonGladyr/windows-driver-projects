#include "..\common.h"

typedef struct _SELECTOR {
	union
	{
		struct
		{
			USHORT	CPL		: 2;
			USHORT	TI		: 1;
			USHORT	Index	: 13;
		} bits;
        		USHORT	SReg;
	} u;        		
} SELECTOR;

C_ASSERT(sizeof(SELECTOR) == sizeof(USHORT));

DRIVER_INITIALIZE DriverEntry;
NTSTATUS DriverEntry(
			IN OUT PDRIVER_OBJECT	DriverObject,
			IN PUNICODE_STRING		RegistryPath);
			
#ifdef ALLOC_PRAGMA
#pragma alloc_text(INIT, DriverEntry )
#endif
