; Listing generated by Microsoft (R) Optimizing Compiler Version 15.00.30729.207 

	TITLE	c:\radasm\wdk\projects\driver_projects\pdlr02_gladyr\physicaldrive\physicaldrive.c
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	??_C@_0BI@LGCNFJIL@?6Press?5?8Enter?8?5to?5exit?6?$AA@ ; `string'
PUBLIC	??_C@_0EN@IMJNCLIC@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9@ ; `string'
PUBLIC	??_C@_0BF@FLAOCOFA@Total?5sectors?7?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BJ@LKKPAOLL@StartLogicalSector?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BE@FBADIICD@EndCylSector?7?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BA@MPCOAMKN@EndHead?7?7?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0N@LHJPIPMM@OSID?7?7?7?3?7?$CFd?6?$AA@	; `string'
PUBLIC	??_C@_0BG@BPDDNENB@StartCylSector?7?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BC@LIDCHLMG@Start?5head?7?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BB@MFLHGCBF@Boot?5flag?7?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0EN@FHJLGDBD@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9Master?5Boot?5Rec@ ; `string'
PUBLIC	??_C@_0DB@IJBKPAKC@can?8t?5open?4?5ReadFile?5fails?5with?5@ ; `string'
PUBLIC	??_C@_0BM@FMEBBMNA@Partition?5?$CFd?5size?5is?5?$CFd?5Mb?6?$AA@ ; `string'
PUBLIC	??_C@_0BH@CFPGNDCP@Partition?5count?7?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BD@BIFJBDCI@Written?7?7?7?3?7?$CFd?5Kb?6?$AA@ ; `string'
PUBLIC	??_C@_0BA@HOLFFOGA@Read?7?7?7?3?7?$CFd?5Kb?6?$AA@ ; `string'
PUBLIC	??_C@_0BH@CPHIDFDB@Bytes?5per?5sector?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BI@IMPKOFIF@Sectors?5per?5track?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BK@KDEGAHIA@Tracks?5per?5cylinder?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_0BB@NKDKMMPF@Cylinders?7?7?3?7?$CFd?6?$AA@ ; `string'
PUBLIC	??_C@_03OFAPEBGM@?$CFs?6?$AA@			; `string'
PUBLIC	??_C@_05LLGELLBM@?$CFs?5?3?5?$AA@		; `string'
PUBLIC	??_C@_0BE@MCOMEFPO@?2?2?4?2PhysicalDrive?$CFu?$AA@ ; `string'
PUBLIC	??_C@_0BB@IMAHNEBK@?D?h?q?j?n?bi?5?o?p?h?q?r?p?n?$LP?$AA@ ; `string'
PUBLIC	??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@ ; `string'
PUBLIC	??_C@_0BJ@HPGIDJOG@ATAPI?0?5Secondary?0?5Master?$AA@ ; `string'
PUBLIC	??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@ ; `string'
PUBLIC	??_C@_0BH@OGDPNGL@ATAPI?0?5Primary?0?5Master?$AA@ ; `string'
PUBLIC	??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@ ; `string'
PUBLIC	??_C@_0BH@IPEJEKH@IDE?0?5Secondary?0?5Master?$AA@ ; `string'
PUBLIC	??_C@_0BE@JCMIAKKE@IDE?0?5Primary?0?5Slave?$AA@	; `string'
PUBLIC	??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@ ; `string'
PUBLIC	__$ArrayPad$
PUBLIC	_main
EXTRN	__imp__getchar:PROC
EXTRN	__imp__CloseHandle@4:PROC
EXTRN	__imp__GetLastError@0:PROC
EXTRN	__imp__ReadFile@20:PROC
EXTRN	__imp__DeviceIoControl@32:PROC
EXTRN	__imp__printf:PROC
EXTRN	__imp__CreateFileA@28:PROC
EXTRN	__imp__sprintf:PROC
EXTRN	__imp__SetConsoleTitleA@4:PROC
EXTRN	___security_cookie:DWORD
EXTRN	@__security_check_cookie@4:PROC
EXTRN	__alldiv:PROC
EXTRN	_memset:PROC
;	COMDAT ??_C@_0BI@LGCNFJIL@?6Press?5?8Enter?8?5to?5exit?6?$AA@
; File c:\radasm\wdk\projects\driver_projects\pdlr02_gladyr\physicaldrive\physicaldrive.c
CONST	SEGMENT
??_C@_0BI@LGCNFJIL@?6Press?5?8Enter?8?5to?5exit?6?$AA@ DB 0aH, 'Press ''E'
	DB	'nter'' to exit', 0aH, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_0EN@IMJNCLIC@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9@
CONST	SEGMENT
??_C@_0EN@IMJNCLIC@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9@ DB '-'
	DB	'-------------------------------------------------------------'
	DB	'-------------', 0aH, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_0BF@FLAOCOFA@Total?5sectors?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BF@FLAOCOFA@Total?5sectors?7?7?3?7?$CFd?6?$AA@ DB 'Total sectors', 09H
	DB	09H, ':', 09H, '%d', 0aH, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_0BJ@LKKPAOLL@StartLogicalSector?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BJ@LKKPAOLL@StartLogicalSector?7?3?7?$CFd?6?$AA@ DB 'StartLogicalS'
	DB	'ector', 09H, ':', 09H, '%d', 0aH, 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0BE@FBADIICD@EndCylSector?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BE@FBADIICD@EndCylSector?7?7?3?7?$CFd?6?$AA@ DB 'EndCylSector', 09H
	DB	09H, ':', 09H, '%d', 0aH, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_0BA@MPCOAMKN@EndHead?7?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BA@MPCOAMKN@EndHead?7?7?7?3?7?$CFd?6?$AA@ DB 'EndHead', 09H, 09H, 09H
	DB	':', 09H, '%d', 0aH, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_0N@LHJPIPMM@OSID?7?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0N@LHJPIPMM@OSID?7?7?7?3?7?$CFd?6?$AA@ DB 'OSID', 09H, 09H, 09H, ':'
	DB	09H, '%d', 0aH, 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_0BG@BPDDNENB@StartCylSector?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BG@BPDDNENB@StartCylSector?7?7?3?7?$CFd?6?$AA@ DB 'StartCylSector', 09H
	DB	09H, ':', 09H, '%d', 0aH, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_0BC@LIDCHLMG@Start?5head?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BC@LIDCHLMG@Start?5head?7?7?3?7?$CFd?6?$AA@ DB 'Start head', 09H, 09H
	DB	':', 09H, '%d', 0aH, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_0BB@MFLHGCBF@Boot?5flag?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BB@MFLHGCBF@Boot?5flag?7?7?3?7?$CFd?6?$AA@ DB 'Boot flag', 09H, 09H
	DB	':', 09H, '%d', 0aH, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_0EN@FHJLGDBD@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9Master?5Boot?5Rec@
CONST	SEGMENT
??_C@_0EN@FHJLGDBD@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9Master?5Boot?5Rec@ DB '-'
	DB	'----------------Master Boot Record of \\.\PhysicalDrive%u----'
	DB	'-------------', 0aH, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_0DB@IJBKPAKC@can?8t?5open?4?5ReadFile?5fails?5with?5@
CONST	SEGMENT
??_C@_0DB@IJBKPAKC@can?8t?5open?4?5ReadFile?5fails?5with?5@ DB 'can''t op'
	DB	'en. ReadFile fails with error code = %d', 0aH, 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BM@FMEBBMNA@Partition?5?$CFd?5size?5is?5?$CFd?5Mb?6?$AA@
CONST	SEGMENT
??_C@_0BM@FMEBBMNA@Partition?5?$CFd?5size?5is?5?$CFd?5Mb?6?$AA@ DB 'Parti'
	DB	'tion %d size is %d Mb', 0aH, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_0BH@CFPGNDCP@Partition?5count?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BH@CFPGNDCP@Partition?5count?7?7?3?7?$CFd?6?$AA@ DB 'Partition cou'
	DB	'nt', 09H, 09H, ':', 09H, '%d', 0aH, 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0BD@BIFJBDCI@Written?7?7?7?3?7?$CFd?5Kb?6?$AA@
CONST	SEGMENT
??_C@_0BD@BIFJBDCI@Written?7?7?7?3?7?$CFd?5Kb?6?$AA@ DB 'Written', 09H, 09H
	DB	09H, ':', 09H, '%d Kb', 0aH, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_0BA@HOLFFOGA@Read?7?7?7?3?7?$CFd?5Kb?6?$AA@
CONST	SEGMENT
??_C@_0BA@HOLFFOGA@Read?7?7?7?3?7?$CFd?5Kb?6?$AA@ DB 'Read', 09H, 09H, 09H
	DB	':', 09H, '%d Kb', 0aH, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_0BH@CPHIDFDB@Bytes?5per?5sector?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BH@CPHIDFDB@Bytes?5per?5sector?7?3?7?$CFd?6?$AA@ DB 'Bytes per sec'
	DB	'tor', 09H, ':', 09H, '%d', 0aH, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_0BI@IMPKOFIF@Sectors?5per?5track?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BI@IMPKOFIF@Sectors?5per?5track?7?3?7?$CFd?6?$AA@ DB 'Sectors per '
	DB	'track', 09H, ':', 09H, '%d', 0aH, 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0BK@KDEGAHIA@Tracks?5per?5cylinder?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BK@KDEGAHIA@Tracks?5per?5cylinder?7?3?7?$CFd?6?$AA@ DB 'Tracks per'
	DB	' cylinder', 09H, ':', 09H, '%d', 0aH, 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0BB@NKDKMMPF@Cylinders?7?7?3?7?$CFd?6?$AA@
CONST	SEGMENT
??_C@_0BB@NKDKMMPF@Cylinders?7?7?3?7?$CFd?6?$AA@ DB 'Cylinders', 09H, 09H
	DB	':', 09H, '%d', 0aH, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_03OFAPEBGM@?$CFs?6?$AA@
CONST	SEGMENT
??_C@_03OFAPEBGM@?$CFs?6?$AA@ DB '%s', 0aH, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_05LLGELLBM@?$CFs?5?3?5?$AA@
CONST	SEGMENT
??_C@_05LLGELLBM@?$CFs?5?3?5?$AA@ DB '%s : ', 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_0BE@MCOMEFPO@?2?2?4?2PhysicalDrive?$CFu?$AA@
CONST	SEGMENT
??_C@_0BE@MCOMEFPO@?2?2?4?2PhysicalDrive?$CFu?$AA@ DB '\\.\PhysicalDrive%'
	DB	'u', 00H					; `string'
CONST	ENDS
;	COMDAT ??_C@_0BB@IMAHNEBK@?D?h?q?j?n?bi?5?o?p?h?q?r?p?n?$LP?$AA@
CONST	SEGMENT
??_C@_0BB@IMAHNEBK@?D?h?q?j?n?bi?5?o?p?h?q?r?p?n?$LP?$AA@ DB 0c4H, 0e8H, 0f1H
	DB	0eaH, 0eeH, 0e2H, 'i ', 0efH, 0f0H, 0e8H, 0f1H, 0f2H, 0f0H, 0eeH
	DB	0bfH, 00H					; `string'
CONST	ENDS
;	COMDAT ??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@
CONST	SEGMENT
??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@ DB 'ATAPI, Secondary,'
	DB	' Slave', 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_0BJ@HPGIDJOG@ATAPI?0?5Secondary?0?5Master?$AA@
CONST	SEGMENT
??_C@_0BJ@HPGIDJOG@ATAPI?0?5Secondary?0?5Master?$AA@ DB 'ATAPI, Secondary'
	DB	', Master', 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@
CONST	SEGMENT
??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@ DB 'ATAPI, Primary, Sla'
	DB	've', 00H					; `string'
CONST	ENDS
;	COMDAT ??_C@_0BH@OGDPNGL@ATAPI?0?5Primary?0?5Master?$AA@
CONST	SEGMENT
??_C@_0BH@OGDPNGL@ATAPI?0?5Primary?0?5Master?$AA@ DB 'ATAPI, Primary, Mas'
	DB	'ter', 00H					; `string'
CONST	ENDS
;	COMDAT ??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@
CONST	SEGMENT
??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@ DB 'IDE, Secondary, Sla'
	DB	've', 00H					; `string'
CONST	ENDS
;	COMDAT ??_C@_0BH@IPEJEKH@IDE?0?5Secondary?0?5Master?$AA@
CONST	SEGMENT
??_C@_0BH@IPEJEKH@IDE?0?5Secondary?0?5Master?$AA@ DB 'IDE, Secondary, Mas'
	DB	'ter', 00H					; `string'
CONST	ENDS
;	COMDAT ??_C@_0BE@JCMIAKKE@IDE?0?5Primary?0?5Slave?$AA@
CONST	SEGMENT
??_C@_0BE@JCMIAKKE@IDE?0?5Primary?0?5Slave?$AA@ DB 'IDE, Primary, Slave', 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@
CONST	SEGMENT
??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@ DB 'IDE, Primary, Master'
	DB	00H						; `string'
; Function compile flags: /Odtp
CONST	ENDS
;	COMDAT _main
_TEXT	SEGMENT
_driveDeviceName$ = -1104				; size = 64
_driveBuf$ = -1040					; size = 160
_diskPerformance$ = -880				; size = 88
_mbr$ = -792						; size = 512
_channel$ = -280					; size = 200
__$ArrayPad$ = -76					; size = 4
_driveInfo$ = -72					; size = 4
_counterBytes$ = -68					; size = 4
_smartVerInfo$ = -64					; size = 24
_i$ = -40						; size = 4
_device$ = -36						; size = 4
_diskGeometry$ = -32					; size = 24
_driveNumber$ = -4					; size = 4
_main	PROC						; COMDAT

; 4    : {

	npad	2
	push	ebp
	mov	ebp, esp
	sub	esp, 1104				; 00000450H
	mov	eax, DWORD PTR ___security_cookie
	xor	eax, ebp
	mov	DWORD PTR __$ArrayPad$[ebp], eax
	push	esi
	push	edi

; 5    : 	ULONG						driveNumber = 0;

	mov	DWORD PTR _driveNumber$[ebp], 0

; 6    : 	HANDLE						device = NULL;

	mov	DWORD PTR _device$[ebp], 0

; 7    : 	TCHAR						driveDeviceName[64] = {0};

	mov	BYTE PTR _driveDeviceName$[ebp], 0
	push	63					; 0000003fH
	push	0
	lea	eax, DWORD PTR _driveDeviceName$[ebp+1]
	push	eax
	call	_memset
	add	esp, 12					; 0000000cH

; 8    : 	DWORD						counterBytes = 0;

	mov	DWORD PTR _counterBytes$[ebp], 0

; 9    : 	GETVERSIONINPARAMS		smartVerInfo = {0};

	mov	BYTE PTR _smartVerInfo$[ebp], 0
	xor	ecx, ecx
	mov	DWORD PTR _smartVerInfo$[ebp+1], ecx
	mov	DWORD PTR _smartVerInfo$[ebp+5], ecx
	mov	DWORD PTR _smartVerInfo$[ebp+9], ecx
	mov	DWORD PTR _smartVerInfo$[ebp+13], ecx
	mov	DWORD PTR _smartVerInfo$[ebp+17], ecx
	mov	WORD PTR _smartVerInfo$[ebp+21], cx
	mov	BYTE PTR _smartVerInfo$[ebp+23], cl

; 10   : 	DISK_GEOMETRY				diskGeometry = {0};

	mov	DWORD PTR _diskGeometry$[ebp], 0
	xor	edx, edx
	mov	DWORD PTR _diskGeometry$[ebp+4], edx
	mov	DWORD PTR _diskGeometry$[ebp+8], edx
	mov	DWORD PTR _diskGeometry$[ebp+12], edx
	mov	DWORD PTR _diskGeometry$[ebp+16], edx
	mov	DWORD PTR _diskGeometry$[ebp+20], edx

; 11   : 	DISK_PERFORMANCE			diskPerformance = {0};

	mov	DWORD PTR _diskPerformance$[ebp], 0
	push	84					; 00000054H
	push	0
	lea	eax, DWORD PTR _diskPerformance$[ebp+4]
	push	eax
	call	_memset
	add	esp, 12					; 0000000cH

; 12   : 	char							driveBuf[4*sizeof(DRIVE_LAYOUT_INFORMATION)] = {0};

	mov	BYTE PTR _driveBuf$[ebp], 0
	push	159					; 0000009fH
	push	0
	lea	ecx, DWORD PTR _driveBuf$[ebp+1]
	push	ecx
	call	_memset
	add	esp, 12					; 0000000cH

; 13   : 	MASTER_BOOT_RECORD		mbr;
; 14   : 	ULONG						i = 0;	

	mov	DWORD PTR _i$[ebp], 0

; 15   : 	TCHAR channel[8][25*sizeof(TCHAR)] = {
; 16   : 				"IDE, Primary, Master", "IDE, Primary, Slave",

	mov	edx, DWORD PTR ??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@
	mov	DWORD PTR _channel$[ebp], edx
	mov	eax, DWORD PTR ??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@+4
	mov	DWORD PTR _channel$[ebp+4], eax
	mov	ecx, DWORD PTR ??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@+8
	mov	DWORD PTR _channel$[ebp+8], ecx
	mov	edx, DWORD PTR ??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@+12
	mov	DWORD PTR _channel$[ebp+12], edx
	mov	eax, DWORD PTR ??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@+16
	mov	DWORD PTR _channel$[ebp+16], eax
	mov	cl, BYTE PTR ??_C@_0BF@PHHGEMKL@IDE?0?5Primary?0?5Master?$AA@+20
	mov	BYTE PTR _channel$[ebp+20], cl
	xor	edx, edx
	mov	DWORD PTR _channel$[ebp+21], edx
	mov	eax, DWORD PTR ??_C@_0BE@JCMIAKKE@IDE?0?5Primary?0?5Slave?$AA@
	mov	DWORD PTR _channel$[ebp+25], eax
	mov	ecx, DWORD PTR ??_C@_0BE@JCMIAKKE@IDE?0?5Primary?0?5Slave?$AA@+4
	mov	DWORD PTR _channel$[ebp+29], ecx
	mov	edx, DWORD PTR ??_C@_0BE@JCMIAKKE@IDE?0?5Primary?0?5Slave?$AA@+8
	mov	DWORD PTR _channel$[ebp+33], edx
	mov	eax, DWORD PTR ??_C@_0BE@JCMIAKKE@IDE?0?5Primary?0?5Slave?$AA@+12
	mov	DWORD PTR _channel$[ebp+37], eax
	mov	ecx, DWORD PTR ??_C@_0BE@JCMIAKKE@IDE?0?5Primary?0?5Slave?$AA@+16
	mov	DWORD PTR _channel$[ebp+41], ecx
	xor	edx, edx
	mov	DWORD PTR _channel$[ebp+45], edx
	mov	BYTE PTR _channel$[ebp+49], dl

; 17   : 				"IDE, Secondary, Master", "IDE, Secondary, Slave",

	mov	ecx, 5
	mov	esi, OFFSET ??_C@_0BH@IPEJEKH@IDE?0?5Secondary?0?5Master?$AA@
	lea	edi, DWORD PTR _channel$[ebp+50]
	rep movsd
	movsw
	movsb
	xor	eax, eax
	mov	WORD PTR _channel$[ebp+73], ax
	mov	ecx, DWORD PTR ??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@
	mov	DWORD PTR _channel$[ebp+75], ecx
	mov	edx, DWORD PTR ??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@+4
	mov	DWORD PTR _channel$[ebp+79], edx
	mov	eax, DWORD PTR ??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@+8
	mov	DWORD PTR _channel$[ebp+83], eax
	mov	ecx, DWORD PTR ??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@+12
	mov	DWORD PTR _channel$[ebp+87], ecx
	mov	edx, DWORD PTR ??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@+16
	mov	DWORD PTR _channel$[ebp+91], edx
	mov	ax, WORD PTR ??_C@_0BG@BPHKHGHN@IDE?0?5Secondary?0?5Slave?$AA@+20
	mov	WORD PTR _channel$[ebp+95], ax
	xor	ecx, ecx
	mov	WORD PTR _channel$[ebp+97], cx
	mov	BYTE PTR _channel$[ebp+99], cl

; 18   : 				"ATAPI, Primary, Master", "ATAPI, Primary, Slave",

	mov	ecx, 5
	mov	esi, OFFSET ??_C@_0BH@OGDPNGL@ATAPI?0?5Primary?0?5Master?$AA@
	lea	edi, DWORD PTR _channel$[ebp+100]
	rep movsd
	movsw
	movsb
	xor	edx, edx
	mov	WORD PTR _channel$[ebp+123], dx
	mov	eax, DWORD PTR ??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@
	mov	DWORD PTR _channel$[ebp+125], eax
	mov	ecx, DWORD PTR ??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@+4
	mov	DWORD PTR _channel$[ebp+129], ecx
	mov	edx, DWORD PTR ??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@+8
	mov	DWORD PTR _channel$[ebp+133], edx
	mov	eax, DWORD PTR ??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@+12
	mov	DWORD PTR _channel$[ebp+137], eax
	mov	ecx, DWORD PTR ??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@+16
	mov	DWORD PTR _channel$[ebp+141], ecx
	mov	dx, WORD PTR ??_C@_0BG@DOKGKFDI@ATAPI?0?5Primary?0?5Slave?$AA@+20
	mov	WORD PTR _channel$[ebp+145], dx
	xor	eax, eax
	mov	WORD PTR _channel$[ebp+147], ax
	mov	BYTE PTR _channel$[ebp+149], al

; 19   : 				"ATAPI, Secondary, Master", "ATAPI, Secondary, Slave"};	

	mov	ecx, 6
	mov	esi, OFFSET ??_C@_0BJ@HPGIDJOG@ATAPI?0?5Secondary?0?5Master?$AA@
	lea	edi, DWORD PTR _channel$[ebp+150]
	rep movsd
	movsb
	mov	ecx, DWORD PTR ??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@
	mov	DWORD PTR _channel$[ebp+175], ecx
	mov	edx, DWORD PTR ??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@+4
	mov	DWORD PTR _channel$[ebp+179], edx
	mov	eax, DWORD PTR ??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@+8
	mov	DWORD PTR _channel$[ebp+183], eax
	mov	ecx, DWORD PTR ??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@+12
	mov	DWORD PTR _channel$[ebp+187], ecx
	mov	edx, DWORD PTR ??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@+16
	mov	DWORD PTR _channel$[ebp+191], edx
	mov	eax, DWORD PTR ??_C@_0BI@IEOHKBHM@ATAPI?0?5Secondary?0?5Slave?$AA@+20
	mov	DWORD PTR _channel$[ebp+195], eax
	xor	ecx, ecx
	mov	BYTE PTR _channel$[ebp+199], cl

; 20   : 	
; 21   : 	PDRIVE_LAYOUT_INFORMATION driveInfo = (DRIVE_LAYOUT_INFORMATION*)&driveBuf;

	lea	edx, DWORD PTR _driveBuf$[ebp]
	mov	DWORD PTR _driveInfo$[ebp], edx

; 22   : 		
; 23   : 	SetConsoleTitle( _TEXT("������i �������") );

	push	OFFSET ??_C@_0BB@IMAHNEBK@?D?h?q?j?n?bi?5?o?p?h?q?r?p?n?$LP?$AA@
	call	DWORD PTR __imp__SetConsoleTitleA@4
$LN13@main:

; 24   : 	
; 25   : 	while(TRUE) {

	mov	eax, 1
	test	eax, eax
	je	$LN12@main

; 26   : 		_stprintf(driveDeviceName, "\\\\.\\PhysicalDrive%u", driveNumber);

	mov	ecx, DWORD PTR _driveNumber$[ebp]
	push	ecx
	push	OFFSET ??_C@_0BE@MCOMEFPO@?2?2?4?2PhysicalDrive?$CFu?$AA@
	lea	edx, DWORD PTR _driveDeviceName$[ebp]
	push	edx
	call	DWORD PTR __imp__sprintf
	add	esp, 12					; 0000000cH

; 27   : 		device = CreateFile(	driveDeviceName, 
; 28   : 							GENERIC_READ|GENERIC_WRITE, 
; 29   : 							FILE_SHARE_READ|FILE_SHARE_WRITE|FILE_SHARE_DELETE,
; 30   : 							NULL, 
; 31   : 							OPEN_EXISTING,
; 32   : 							0, 
; 33   : 							NULL	);

	push	0
	push	0
	push	3
	push	0
	push	7
	push	-1073741824				; c0000000H
	lea	eax, DWORD PTR _driveDeviceName$[ebp]
	push	eax
	call	DWORD PTR __imp__CreateFileA@28
	mov	DWORD PTR _device$[ebp], eax

; 34   : 		
; 35   : 		if(INVALID_HANDLE_VALUE == device)

	cmp	DWORD PTR _device$[ebp], -1
	jne	SHORT $LN11@main

; 36   : 		{
; 37   : 			break;

	jmp	$LN12@main
$LN11@main:

; 38   : 			/*_tprintf( _TEXT("can't open. CreateFile fails with error code = %d\n"), GetLastError());
; 39   : 			return -1; */
; 40   : 		}
; 41   : 		
; 42   : 		_tprintf( _TEXT("%s : "), driveDeviceName );

	lea	ecx, DWORD PTR _driveDeviceName$[ebp]
	push	ecx
	push	OFFSET ??_C@_05LLGELLBM@?$CFs?5?3?5?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 43   : 		
; 44   : 		if(	DeviceIoControl(device, 
; 45   : 					SMART_GET_VERSION, 
; 46   : 					(PVOID)NULL, 
; 47   : 					(DWORD)NULL, 
; 48   : 					&smartVerInfo, 
; 49   : 					sizeof(GETVERSIONINPARAMS), 
; 50   : 					&counterBytes, NULL)	)

	push	0
	lea	edx, DWORD PTR _counterBytes$[ebp]
	push	edx
	push	24					; 00000018H
	lea	eax, DWORD PTR _smartVerInfo$[ebp]
	push	eax
	push	0
	push	0
	push	475264					; 00074080H
	mov	ecx, DWORD PTR _device$[ebp]
	push	ecx
	call	DWORD PTR __imp__DeviceIoControl@32
	test	eax, eax
	je	SHORT $LN10@main

; 51   : 		{
; 52   : 			_tprintf( _TEXT("%s\n"), channel[smartVerInfo.bIDEDeviceMap / 2] );

	movzx	eax, BYTE PTR _smartVerInfo$[ebp+3]
	cdq
	sub	eax, edx
	sar	eax, 1
	imul	eax, 25					; 00000019H
	lea	edx, DWORD PTR _channel$[ebp+eax]
	push	edx
	push	OFFSET ??_C@_03OFAPEBGM@?$CFs?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8
$LN10@main:

; 53   : 		}
; 54   : 		if(	DeviceIoControl(device, 
; 55   : 					IOCTL_DISK_GET_DRIVE_GEOMETRY, 
; 56   : 					(PVOID)NULL, 
; 57   : 					(DWORD)NULL, 
; 58   : 					&diskGeometry, 
; 59   : 					sizeof(DISK_GEOMETRY), 
; 60   : 					&counterBytes, NULL)	)

	push	0
	lea	eax, DWORD PTR _counterBytes$[ebp]
	push	eax
	push	24					; 00000018H
	lea	ecx, DWORD PTR _diskGeometry$[ebp]
	push	ecx
	push	0
	push	0
	push	458752					; 00070000H
	mov	edx, DWORD PTR _device$[ebp]
	push	edx
	call	DWORD PTR __imp__DeviceIoControl@32
	test	eax, eax
	je	SHORT $LN9@main

; 61   : 		{
; 62   : 			_tprintf( _TEXT("Cylinders\t\t:\t%d\n"), diskGeometry.Cylinders);

	mov	eax, DWORD PTR _diskGeometry$[ebp+4]
	push	eax
	mov	ecx, DWORD PTR _diskGeometry$[ebp]
	push	ecx
	push	OFFSET ??_C@_0BB@NKDKMMPF@Cylinders?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 12					; 0000000cH

; 63   : 			_tprintf( _TEXT("Tracks per cylinder\t:\t%d\n"), diskGeometry.TracksPerCylinder); 

	mov	edx, DWORD PTR _diskGeometry$[ebp+12]
	push	edx
	push	OFFSET ??_C@_0BK@KDEGAHIA@Tracks?5per?5cylinder?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 64   : 			_tprintf( _TEXT("Sectors per track\t:\t%d\n"), diskGeometry.SectorsPerTrack);

	mov	eax, DWORD PTR _diskGeometry$[ebp+16]
	push	eax
	push	OFFSET ??_C@_0BI@IMPKOFIF@Sectors?5per?5track?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 65   : 			_tprintf( _TEXT("Bytes per sector\t:\t%d\n"), diskGeometry.BytesPerSector); 

	mov	ecx, DWORD PTR _diskGeometry$[ebp+20]
	push	ecx
	push	OFFSET ??_C@_0BH@CPHIDFDB@Bytes?5per?5sector?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8
$LN9@main:

; 66   : 		}
; 67   : 	
; 68   : 		if(	DeviceIoControl(device, 
; 69   : 					IOCTL_DISK_PERFORMANCE, 
; 70   : 					(PVOID)NULL, 
; 71   : 					(DWORD)NULL, 
; 72   : 					&diskPerformance, 
; 73   : 					sizeof(DISK_PERFORMANCE), 
; 74   : 					&counterBytes, NULL)	)

	push	0
	lea	edx, DWORD PTR _counterBytes$[ebp]
	push	edx
	push	88					; 00000058H
	lea	eax, DWORD PTR _diskPerformance$[ebp]
	push	eax
	push	0
	push	0
	push	458784					; 00070020H
	mov	ecx, DWORD PTR _device$[ebp]
	push	ecx
	call	DWORD PTR __imp__DeviceIoControl@32
	test	eax, eax
	je	SHORT $LN8@main

; 75   : 		{
; 76   : 			_tprintf( _TEXT("Read\t\t\t:\t%d Kb\n"), 
; 77   : 					diskPerformance.BytesRead.QuadPart  / 1024 );

	push	0
	push	1024					; 00000400H
	mov	edx, DWORD PTR _diskPerformance$[ebp+4]
	push	edx
	mov	eax, DWORD PTR _diskPerformance$[ebp]
	push	eax
	call	__alldiv
	push	edx
	push	eax
	push	OFFSET ??_C@_0BA@HOLFFOGA@Read?7?7?7?3?7?$CFd?5Kb?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 12					; 0000000cH

; 78   : 			_tprintf( _TEXT("Written\t\t\t:\t%d Kb\n"), 
; 79   : 					diskPerformance.BytesWritten.QuadPart   / 1024 );

	push	0
	push	1024					; 00000400H
	mov	ecx, DWORD PTR _diskPerformance$[ebp+12]
	push	ecx
	mov	edx, DWORD PTR _diskPerformance$[ebp+8]
	push	edx
	call	__alldiv
	push	edx
	push	eax
	push	OFFSET ??_C@_0BD@BIFJBDCI@Written?7?7?7?3?7?$CFd?5Kb?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 12					; 0000000cH
$LN8@main:

; 80   : 		}
; 81   : 	
; 82   : 		if(	DeviceIoControl(device, 
; 83   : 					IOCTL_DISK_GET_DRIVE_LAYOUT, 
; 84   : 					(PVOID)NULL, 
; 85   : 					(DWORD)NULL, 
; 86   : 					&driveBuf, 
; 87   : 					sizeof(driveBuf), 
; 88   : 					&counterBytes, NULL)	)

	push	0
	lea	eax, DWORD PTR _counterBytes$[ebp]
	push	eax
	push	160					; 000000a0H
	lea	ecx, DWORD PTR _driveBuf$[ebp]
	push	ecx
	push	0
	push	0
	push	475148					; 0007400cH
	mov	edx, DWORD PTR _device$[ebp]
	push	edx
	call	DWORD PTR __imp__DeviceIoControl@32
	test	eax, eax
	je	$LN7@main

; 89   : 		{
; 90   : 			_tprintf( _TEXT("Partition count\t\t:\t%d\n"),	driveInfo->PartitionCount );

	mov	eax, DWORD PTR _driveInfo$[ebp]
	mov	ecx, DWORD PTR [eax]
	push	ecx
	push	OFFSET ??_C@_0BH@CFPGNDCP@Partition?5count?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 91   : 			for( i = 0; i <  driveInfo->PartitionCount;  i++)

	mov	DWORD PTR _i$[ebp], 0
	jmp	SHORT $LN6@main
$LN5@main:
	mov	edx, DWORD PTR _i$[ebp]
	add	edx, 1
	mov	DWORD PTR _i$[ebp], edx
$LN6@main:
	mov	eax, DWORD PTR _driveInfo$[ebp]
	mov	ecx, DWORD PTR _i$[ebp]
	cmp	ecx, DWORD PTR [eax]
	jae	SHORT $LN7@main

; 92   : 			{
; 93   : 				if(driveInfo->PartitionEntry[i].PartitionNumber)

	mov	edx, DWORD PTR _i$[ebp]
	shl	edx, 5
	mov	eax, DWORD PTR _driveInfo$[ebp]
	cmp	DWORD PTR [eax+edx+28], 0
	je	SHORT $LN3@main

; 94   : 				{
; 95   : 					_tprintf( _TEXT("Partition %d size is %d Mb\n"), 
; 96   : 					driveInfo->PartitionEntry[i].PartitionNumber,
; 97   : 					driveInfo->PartitionEntry[i].PartitionLength.QuadPart / 1024 / 1024 );

	mov	ecx, DWORD PTR _i$[ebp]
	shl	ecx, 5
	mov	edx, DWORD PTR _driveInfo$[ebp]
	push	0
	push	1024					; 00000400H
	mov	eax, DWORD PTR [edx+ecx+20]
	push	eax
	mov	ecx, DWORD PTR [edx+ecx+16]
	push	ecx
	call	__alldiv
	push	0
	push	1024					; 00000400H
	push	edx
	push	eax
	call	__alldiv
	push	edx
	push	eax
	mov	edx, DWORD PTR _i$[ebp]
	shl	edx, 5
	mov	eax, DWORD PTR _driveInfo$[ebp]
	mov	ecx, DWORD PTR [eax+edx+28]
	push	ecx
	push	OFFSET ??_C@_0BM@FMEBBMNA@Partition?5?$CFd?5size?5is?5?$CFd?5Mb?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 16					; 00000010H
$LN3@main:

; 98   : 				}
; 99   : 			}

	jmp	SHORT $LN5@main
$LN7@main:

; 100  : 		}
; 101  : 		
; 102  : 		if ( !ReadFile(device,
; 103  : 				(PMASTER_BOOT_RECORD)&mbr,
; 104  : 				sizeof(mbr), 
; 105  : 				&counterBytes,
; 106  : 				 NULL)) 

	push	0
	lea	edx, DWORD PTR _counterBytes$[ebp]
	push	edx
	push	512					; 00000200H
	lea	eax, DWORD PTR _mbr$[ebp]
	push	eax
	mov	ecx, DWORD PTR _device$[ebp]
	push	ecx
	call	DWORD PTR __imp__ReadFile@20
	test	eax, eax
	jne	SHORT $LN2@main

; 107  : 			_tprintf( _TEXT("can't open. ReadFile fails with error code = %d\n"), GetLastError());

	call	DWORD PTR __imp__GetLastError@0
	push	eax
	push	OFFSET ??_C@_0DB@IJBKPAKC@can?8t?5open?4?5ReadFile?5fails?5with?5@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 108  : 		else 

	jmp	$LN1@main
$LN2@main:

; 109  : 		{
; 110  : 			_tprintf("-----------------Master Boot Record of \\\\.\\PhysicalDrive%u-----------------\n", driveNumber);

	mov	edx, DWORD PTR _driveNumber$[ebp]
	push	edx
	push	OFFSET ??_C@_0EN@FHJLGDBD@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9Master?5Boot?5Rec@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 111  : 			_tprintf( _TEXT("Boot flag\t\t:\t%d\n"), mbr.Partition0.BootFlag);

	movzx	eax, BYTE PTR _mbr$[ebp+446]
	push	eax
	push	OFFSET ??_C@_0BB@MFLHGCBF@Boot?5flag?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 112  : 			_tprintf( _TEXT("Start head\t\t:\t%d\n"), mbr.Partition0.StartHead);

	movzx	ecx, BYTE PTR _mbr$[ebp+447]
	push	ecx
	push	OFFSET ??_C@_0BC@LIDCHLMG@Start?5head?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 113  : 			_tprintf( _TEXT("StartCylSector\t\t:\t%d\n"), mbr.Partition0.StartCylSector);

	movzx	edx, WORD PTR _mbr$[ebp+448]
	push	edx
	push	OFFSET ??_C@_0BG@BPDDNENB@StartCylSector?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 114  : 			_tprintf( _TEXT("OSID\t\t\t:\t%d\n"), mbr.Partition0.OSID);

	movzx	eax, BYTE PTR _mbr$[ebp+450]
	push	eax
	push	OFFSET ??_C@_0N@LHJPIPMM@OSID?7?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 115  : 			_tprintf( _TEXT("EndHead\t\t\t:\t%d\n"), mbr.Partition0.EndHead);

	movzx	ecx, BYTE PTR _mbr$[ebp+451]
	push	ecx
	push	OFFSET ??_C@_0BA@MPCOAMKN@EndHead?7?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 116  : 			_tprintf( _TEXT("EndCylSector\t\t:\t%d\n"), mbr.Partition0.EndCylSector);

	movzx	edx, WORD PTR _mbr$[ebp+452]
	push	edx
	push	OFFSET ??_C@_0BE@FBADIICD@EndCylSector?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 117  : 			_tprintf( _TEXT("StartLogicalSector\t:\t%d\n"), mbr.Partition0.StartLogicalSector);

	mov	eax, DWORD PTR _mbr$[ebp+454]
	push	eax
	push	OFFSET ??_C@_0BJ@LKKPAOLL@StartLogicalSector?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 118  : 			_tprintf( _TEXT("Total sectors\t\t:\t%d\n"), mbr.Partition0.TotalSectors);

	mov	ecx, DWORD PTR _mbr$[ebp+458]
	push	ecx
	push	OFFSET ??_C@_0BF@FLAOCOFA@Total?5sectors?7?7?3?7?$CFd?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 8

; 119  : 			
; 120  : 			_tprintf("---------------------------------------------------------------------------\n");

	push	OFFSET ??_C@_0EN@IMJNCLIC@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9@
	call	DWORD PTR __imp__printf
	add	esp, 4

; 121  : 			_tprintf("---------------------------------------------------------------------------\n");

	push	OFFSET ??_C@_0EN@IMJNCLIC@?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9?9@
	call	DWORD PTR __imp__printf
	add	esp, 4
$LN1@main:

; 122  : 		}
; 123  : 		
; 124  : 		driveNumber++;

	mov	edx, DWORD PTR _driveNumber$[ebp]
	add	edx, 1
	mov	DWORD PTR _driveNumber$[ebp], edx

; 125  : 		CloseHandle(device);

	mov	eax, DWORD PTR _device$[ebp]
	push	eax
	call	DWORD PTR __imp__CloseHandle@4

; 126  : 	}

	jmp	$LN13@main
$LN12@main:

; 127  : 		
; 128  : 	_tprintf(_TEXT("\nPress 'Enter' to exit\n"));

	push	OFFSET ??_C@_0BI@LGCNFJIL@?6Press?5?8Enter?8?5to?5exit?6?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 4

; 129  : 	_gettchar();

	call	DWORD PTR __imp__getchar

; 130  : 
; 131  : 	return 0;

	xor	eax, eax

; 132  : }

	pop	edi
	pop	esi
	mov	ecx, DWORD PTR __$ArrayPad$[ebp]
	xor	ecx, ebp
	call	@__security_check_cookie@4
	mov	esp, ebp
	pop	ebp
	ret	0
_main	ENDP
_TEXT	ENDS
END
