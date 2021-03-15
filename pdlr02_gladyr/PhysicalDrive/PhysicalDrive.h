#include <windef.h>
#include <winbase.h>
#include <wincon.h>
#include <winuser.h>
#include <stdio.h>
#include <stdlib.h>
#include <tchar.h>
#include <winioctl.h>
#include <ntdddisk.h>

#pragma pack(push,1)

typedef struct _PARTITION_RECORD	{
	BYTE	BootFlag;
	BYTE	StartHead;
	WORD	StartCylSector;
	BYTE	OSID;
	BYTE	EndHead;
	WORD	EndCylSector;
	DWORD	StartLogicalSector;
	DWORD	TotalSectors;
} PARTITION_RECORD, *PPARTITION_RECORD;

C_ASSERT( sizeof(PARTITION_RECORD) == 16 );

typedef struct _MASTER_BOOT_RECORD {
	BYTE				MBRCode[0x1BE];
	PARTITION_RECORD	Partition0;
	PARTITION_RECORD	Partition1;
	PARTITION_RECORD	Partition2;
	PARTITION_RECORD	Partition3;
	WORD				Signature;
} MASTER_BOOT_RECORD, *PMASTER_BOOT_RECORD;

C_ASSERT( sizeof(MASTER_BOOT_RECORD) == 512 );

#pragma pack(pop)

