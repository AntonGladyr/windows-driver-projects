; Listing generated by Microsoft (R) Optimizing Compiler Version 15.00.30729.207 

	TITLE	c:\radasm\wdk\projects\driver_projects\pdlr06_gladyr\pciconfigviewer\pciconfigviewer.c
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	_deviceName_buffer
PUBLIC	_deviceName
PUBLIC	_symbolicLinkName_buffer
PUBLIC	_symbolicLinkName
CONST	SEGMENT
_deviceName_buffer DB '\', 00H, 'D', 00H, 'e', 00H, 'v', 00H, 'i', 00H, 'c'
	DB	00H, 'e', 00H, '\', 00H, 'p', 00H, 'c', 00H, 'i', 00H, 'c', 00H
	DB	'o', 00H, 'n', 00H, 'f', 00H, 'i', 00H, 'g', 00H, 'v', 00H, 'i'
	DB	00H, 'e', 00H, 'w', 00H, 'e', 00H, 'r', 00H, 00H, 00H
_deviceName DW	02eH
	DW	030H
	DD	FLAT:_deviceName_buffer
_symbolicLinkName_buffer DB '\', 00H, '?', 00H, '?', 00H, '\', 00H, 'p', 00H
	DB	'c', 00H, 'i', 00H, 'c', 00H, 'o', 00H, 'n', 00H, 'f', 00H, 'i'
	DB	00H, 'g', 00H, 'v', 00H, 'i', 00H, 'e', 00H, 'w', 00H, 'e', 00H
	DB	'r', 00H, 00H, 00H
_symbolicLinkName DW 026H
	DW	028H
	DD	FLAT:_symbolicLinkName_buffer
CONST	ENDS
PUBLIC	_DriverUnload@4
PUBLIC	_DeviceControlDispatchRoutine@8
PUBLIC	_CreateCloseDispatchRoutine@8
PUBLIC	??_C@_0DN@MPNLHDFJ@DriverEntry?3IoCreateSymbolicLink@PBOPGDP@ ;  ?? ::PBOPGDP::`string'
PUBLIC	??_C@_0FA@EDLJHCJH@DriverEntry?3IoCreateDevice?5fails@PBOPGDP@ ;  ?? ::PBOPGDP::`string'
PUBLIC	_DriverEntry@8
EXTRN	__imp__IoDeleteDevice@4:PROC
EXTRN	__imp__IoCreateSymbolicLink@8:PROC
EXTRN	_DbgPrint:PROC
EXTRN	__imp__IoCreateDevice@28:PROC
;	COMDAT ??_C@_0DN@MPNLHDFJ@DriverEntry?3IoCreateSymbolicLink@PBOPGDP@
; File c:\radasm\wdk\projects\driver_projects\pdlr06_gladyr\pciconfigviewer\pciconfigviewer.c
INIT$s	SEGMENT
??_C@_0DN@MPNLHDFJ@DriverEntry?3IoCreateSymbolicLink@PBOPGDP@ DB 'DriverE'
	DB	'ntry:IoCreateSymbolicLink fails with status = 0x%08X', 0aH, 00H ;  ?? ::PBOPGDP::`string'
INIT$s	ENDS
;	COMDAT ??_C@_0FA@EDLJHCJH@DriverEntry?3IoCreateDevice?5fails@PBOPGDP@
INIT$s	SEGMENT
??_C@_0FA@EDLJHCJH@DriverEntry?3IoCreateDevice?5fails@PBOPGDP@ DB 'Driver'
	DB	'Entry:IoCreateDevice fails with status = 0x%08X for device wi'
	DB	'th name %wZ', 0aH, 00H			;  ?? ::PBOPGDP::`string'
; Function compile flags: /Odtp
INIT$s	ENDS
;	COMDAT _DriverEntry@8
INIT	SEGMENT
_status$ = -8						; size = 4
_DeviceObject$ = -4					; size = 4
_DriverObject$ = 8					; size = 4
_RegistryPath$ = 12					; size = 4
_DriverEntry@8 PROC					; COMDAT

; 7    : {

	npad	2
	push	ebp
	mov	ebp, esp
	sub	esp, 8

; 8    : 	NTSTATUS		status		= STATUS_SUCCESS;

	mov	DWORD PTR _status$[ebp], 0

; 9    : 	PDEVICE_OBJECT	DeviceObject	= NULL;

	mov	DWORD PTR _DeviceObject$[ebp], 0

; 10   : 
; 11   : 	UNREFERENCED_PARAMETER(RegistryPath);
; 12   : 
; 13   : 	status = IoCreateDevice(	DriverObject, 0,
; 14   : 							(PUNICODE_STRING)&deviceName,
; 15   : 							DEV_TYPE, FILE_DEVICE_SECURE_OPEN,
; 16   : 							FALSE, &DeviceObject	);                        

	lea	eax, DWORD PTR _DeviceObject$[ebp]
	push	eax
	push	0
	push	256					; 00000100H
	push	34					; 00000022H
	push	OFFSET _deviceName
	push	0
	mov	ecx, DWORD PTR _DriverObject$[ebp]
	push	ecx
	call	DWORD PTR __imp__IoCreateDevice@28
	mov	DWORD PTR _status$[ebp], eax

; 17   : 	
; 18   : 	if (!NT_SUCCESS(status))

	cmp	DWORD PTR _status$[ebp], 0
	jge	SHORT $LN2@DriverEntr

; 19   : 	{
; 20   : 		KdPrint((__FUNCTION__":IoCreateDevice fails with status = 0x%08X for device with name %wZ\n", 
; 21   : 					status, (PUNICODE_STRING)&deviceName) );

	push	OFFSET _deviceName
	mov	edx, DWORD PTR _status$[ebp]
	push	edx
	push	OFFSET ??_C@_0FA@EDLJHCJH@DriverEntry?3IoCreateDevice?5fails@PBOPGDP@
	call	_DbgPrint
	add	esp, 12					; 0000000cH

; 22   : 		return status;

	mov	eax, DWORD PTR _status$[ebp]
	jmp	SHORT $LN3@DriverEntr
$LN2@DriverEntr:

; 23   : 	}
; 24   : 	
; 25   : 	status = IoCreateSymbolicLink(	(PUNICODE_STRING)&symbolicLinkName, 
; 26   : 								(PUNICODE_STRING)&deviceName	);

	push	OFFSET _deviceName
	push	OFFSET _symbolicLinkName
	call	DWORD PTR __imp__IoCreateSymbolicLink@8
	mov	DWORD PTR _status$[ebp], eax

; 27   : 		
; 28   : 	if (!NT_SUCCESS(status))

	cmp	DWORD PTR _status$[ebp], 0
	jge	SHORT $LN1@DriverEntr

; 29   : 	{
; 30   : 		KdPrint((__FUNCTION__":IoCreateSymbolicLink fails with status = 0x%08X\n", status));

	mov	eax, DWORD PTR _status$[ebp]
	push	eax
	push	OFFSET ??_C@_0DN@MPNLHDFJ@DriverEntry?3IoCreateSymbolicLink@PBOPGDP@
	call	_DbgPrint
	add	esp, 8

; 31   : 		IoDeleteDevice(DeviceObject);

	mov	ecx, DWORD PTR _DeviceObject$[ebp]
	push	ecx
	call	DWORD PTR __imp__IoDeleteDevice@4

; 32   : 		return status;

	mov	eax, DWORD PTR _status$[ebp]
	jmp	SHORT $LN3@DriverEntr
$LN1@DriverEntr:

; 33   : 	}
; 34   : 	DriverObject->MajorFunction[IRP_MJ_CREATE]			= CreateCloseDispatchRoutine; 

	mov	edx, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [edx+56], OFFSET _CreateCloseDispatchRoutine@8

; 35   : 	DriverObject->MajorFunction[IRP_MJ_CLOSE]				= CreateCloseDispatchRoutine;

	mov	eax, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [eax+64], OFFSET _CreateCloseDispatchRoutine@8

; 36   : 	DriverObject->MajorFunction[IRP_MJ_DEVICE_CONTROL]	= DeviceControlDispatchRoutine;

	mov	ecx, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [ecx+112], OFFSET _DeviceControlDispatchRoutine@8

; 37   : 	DriverObject->DriverUnload								= DriverUnload;

	mov	edx, DWORD PTR _DriverObject$[ebp]
	mov	DWORD PTR [edx+52], OFFSET _DriverUnload@4

; 38   : 
; 39   : 	return status;

	mov	eax, DWORD PTR _status$[ebp]
$LN3@DriverEntr:

; 40   : }

	mov	esp, ebp
	pop	ebp
	ret	8
_DriverEntry@8 ENDP
INIT	ENDS
PUBLIC	??_C@_03EAONPCJM@Irp?$AA@NNGAKEGL@		;  ?? ::NNGAKEGL::`string'
PUBLIC	??_C@_01GBGANLPD@0?$AA@NNGAKEGL@		;  ?? ::NNGAKEGL::`string'
PUBLIC	??_C@_0FH@DLBEFNBC@c?3?2radasm?2wdk?2projects?2driver_pr@NNGAKEGL@ ;  ?? ::NNGAKEGL::`string'
PUBLIC	??_C@_0CF@FOPNHIJF@EX?3?5Pageable?5code?5called?5at?5IRQL@NNGAKEGL@ ;  ?? ::NNGAKEGL::`string'
EXTRN	__imp_@IofCompleteRequest@8:PROC
EXTRN	__imp__RtlAssert@16:PROC
EXTRN	__imp__KeGetCurrentIrql@0:PROC
;	COMDAT ??_C@_03EAONPCJM@Irp?$AA@NNGAKEGL@
PAGE$s	SEGMENT
??_C@_03EAONPCJM@Irp?$AA@NNGAKEGL@ DB 'Irp', 00H	;  ?? ::NNGAKEGL::`string'
PAGE$s	ENDS
;	COMDAT ??_C@_01GBGANLPD@0?$AA@NNGAKEGL@
PAGE$s	SEGMENT
??_C@_01GBGANLPD@0?$AA@NNGAKEGL@ DB '0', 00H		;  ?? ::NNGAKEGL::`string'
PAGE$s	ENDS
;	COMDAT ??_C@_0FH@DLBEFNBC@c?3?2radasm?2wdk?2projects?2driver_pr@NNGAKEGL@
PAGE$s	SEGMENT
??_C@_0FH@DLBEFNBC@c?3?2radasm?2wdk?2projects?2driver_pr@NNGAKEGL@ DB 'c:'
	DB	'\radasm\wdk\projects\driver_projects\pdlr06_gladyr\pciconfigv'
	DB	'iewer\pciconfigviewer.c', 00H		;  ?? ::NNGAKEGL::`string'
PAGE$s	ENDS
;	COMDAT ??_C@_0CF@FOPNHIJF@EX?3?5Pageable?5code?5called?5at?5IRQL@NNGAKEGL@
PAGE$s	SEGMENT
??_C@_0CF@FOPNHIJF@EX?3?5Pageable?5code?5called?5at?5IRQL@NNGAKEGL@ DB 'E'
	DB	'X: Pageable code called at IRQL %d', 0aH, 00H ;  ?? ::NNGAKEGL::`string'
; Function compile flags: /Odtp
PAGE$s	ENDS
;	COMDAT _CreateCloseDispatchRoutine@8
PAGE	SEGMENT
tv80 = -4						; size = 4
_DeviceObject$ = 8					; size = 4
_Irp$ = 12						; size = 4
_CreateCloseDispatchRoutine@8 PROC			; COMDAT

; 45   : {

	npad	2
	push	ebp
	mov	ebp, esp
	push	ecx

; 46   : 	UNREFERENCED_PARAMETER(DeviceObject);
; 47   : 	PAGED_CODE();

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	movzx	eax, al
	cmp	eax, 1
	jle	SHORT $LN1@CreateClos
	call	DWORD PTR __imp__KeGetCurrentIrql@0
	movzx	ecx, al
	push	ecx
	push	OFFSET ??_C@_0CF@FOPNHIJF@EX?3?5Pageable?5code?5called?5at?5IRQL@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8
	push	0
	push	47					; 0000002fH
	push	OFFSET ??_C@_0FH@DLBEFNBC@c?3?2radasm?2wdk?2projects?2driver_pr@NNGAKEGL@
	push	OFFSET ??_C@_01GBGANLPD@0?$AA@NNGAKEGL@
	call	DWORD PTR __imp__RtlAssert@16
$LN1@CreateClos:

; 48   : 	ASSERT(Irp);

	cmp	DWORD PTR _Irp$[ebp], 0
	jne	SHORT $LN4@CreateClos
	push	0
	push	48					; 00000030H
	push	OFFSET ??_C@_0FH@DLBEFNBC@c?3?2radasm?2wdk?2projects?2driver_pr@NNGAKEGL@
	push	OFFSET ??_C@_03EAONPCJM@Irp?$AA@NNGAKEGL@
	call	DWORD PTR __imp__RtlAssert@16
	mov	DWORD PTR tv80[ebp], 0
	jmp	SHORT $LN5@CreateClos
$LN4@CreateClos:
	mov	DWORD PTR tv80[ebp], 1
$LN5@CreateClos:

; 49   : 
; 50   : 	Irp->IoStatus.Status = STATUS_SUCCESS;

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [edx+24], 0

; 51   : 	Irp->IoStatus.Information = 0;

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [eax+28], 0

; 52   : 	IoCompleteRequest(Irp, IO_NO_INCREMENT);

	xor	dl, dl
	mov	ecx, DWORD PTR _Irp$[ebp]
	call	DWORD PTR __imp_@IofCompleteRequest@8

; 53   : 	return STATUS_SUCCESS;

	xor	eax, eax

; 54   : }

	mov	esp, ebp
	pop	ebp
	ret	8
_CreateCloseDispatchRoutine@8 ENDP
PAGE	ENDS
PUBLIC	??_C@_0EC@EHPFAIPI@DeviceControlDispatchRoutine?3Out@NNGAKEGL@ ;  ?? ::NNGAKEGL::`string'
PUBLIC	??_C@_0DP@HLDLJDOO@DeviceControlDispatchRoutine?3Inp@NNGAKEGL@ ;  ?? ::NNGAKEGL::`string'
PUBLIC	_IoGetCurrentIrpStackLocation@4
EXTRN	__imp__READ_PORT_ULONG@4:PROC
EXTRN	__imp__WRITE_PORT_ULONG@8:PROC
EXTRN	_memset:PROC
;	COMDAT ??_C@_0EC@EHPFAIPI@DeviceControlDispatchRoutine?3Out@NNGAKEGL@
PAGE$s	SEGMENT
??_C@_0EC@EHPFAIPI@DeviceControlDispatchRoutine?3Out@NNGAKEGL@ DB 'Device'
	DB	'ControlDispatchRoutine:Output buffer length = %d too small', 0aH
	DB	00H						;  ?? ::NNGAKEGL::`string'
PAGE$s	ENDS
;	COMDAT ??_C@_0DP@HLDLJDOO@DeviceControlDispatchRoutine?3Inp@NNGAKEGL@
PAGE$s	SEGMENT
??_C@_0DP@HLDLJDOO@DeviceControlDispatchRoutine?3Inp@NNGAKEGL@ DB 'Device'
	DB	'ControlDispatchRoutine:Input buffer length = %d invalid', 0aH
	DB	00H						;  ?? ::NNGAKEGL::`string'
; Function compile flags: /Odtp
PAGE$s	ENDS
;	COMDAT _DeviceControlDispatchRoutine@8
PAGE	SEGMENT
tv82 = -60						; size = 4
_classCode$ = -56					; size = 4
_outBufLen$ = -52					; size = 4
_status$ = -48						; size = 4
_regNum$ = -44						; size = 4
_ioStack$ = -40						; size = 4
_inBufLen$ = -36					; size = 4
_slotNum$ = -32						; size = 4
_outBuf$ = -28						; size = 4
_bus$ = -24						; size = 4
_inBufReg$ = -20					; size = 4
_inBuf$ = -16						; size = 4
_device$ = -12						; size = 4
_function$ = -8						; size = 4
_isDeviceFound$ = -1					; size = 1
_DeviceObject$ = 8					; size = 4
_Irp$ = 12						; size = 4
_DeviceControlDispatchRoutine@8 PROC			; COMDAT

; 59   : {

	npad	2
	push	ebp
	mov	ebp, esp
	sub	esp, 60					; 0000003cH

; 60   : 	NTSTATUS				status		= STATUS_SUCCESS;

	mov	DWORD PTR _status$[ebp], 0

; 61   : 	PIO_STACK_LOCATION		ioStack		= IoGetCurrentIrpStackLocation(Irp);

	mov	eax, DWORD PTR _Irp$[ebp]
	push	eax
	call	_IoGetCurrentIrpStackLocation@4
	mov	DWORD PTR _ioStack$[ebp], eax

; 62   : 	ULONG					inBufLen		= ioStack->Parameters.DeviceIoControl.InputBufferLength;

	mov	ecx, DWORD PTR _ioStack$[ebp]
	mov	edx, DWORD PTR [ecx+8]
	mov	DWORD PTR _inBufLen$[ebp], edx

; 63   : 	ULONG					outBufLen	= ioStack->Parameters.DeviceIoControl.OutputBufferLength;

	mov	eax, DWORD PTR _ioStack$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	DWORD PTR _outBufLen$[ebp], ecx

; 64   : 	PPCI_SLOT_NUMBER_EXT	inBuf		= NULL;

	mov	DWORD PTR _inBuf$[ebp], 0

; 65   : 	PULONG					inBufReg		= NULL;

	mov	DWORD PTR _inBufReg$[ebp], 0

; 66   : 	PULONG					outBuf		= Irp->AssociatedIrp.SystemBuffer;

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR [edx+12]
	mov	DWORD PTR _outBuf$[ebp], eax

; 67   : 	PCI_SLOT_NUMBER_EXT	slotNum		= {0};

	mov	DWORD PTR _slotNum$[ebp], 0

; 68   : 	ULONG					regNum		= 0;

	mov	DWORD PTR _regNum$[ebp], 0

; 69   : 	ULONG					bus = 0, device = 0, function = 0;

	mov	DWORD PTR _bus$[ebp], 0
	mov	DWORD PTR _device$[ebp], 0
	mov	DWORD PTR _function$[ebp], 0

; 70   : 	ULONG					classCode = 0;

	mov	DWORD PTR _classCode$[ebp], 0

; 71   : 	BOOLEAN				isDeviceFound = FALSE;

	mov	BYTE PTR _isDeviceFound$[ebp], 0

; 72   : 		
; 73   : 	PAGED_CODE();

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	movzx	ecx, al
	cmp	ecx, 1
	jle	SHORT $LN42@DeviceCont
	call	DWORD PTR __imp__KeGetCurrentIrql@0
	movzx	edx, al
	push	edx
	push	OFFSET ??_C@_0CF@FOPNHIJF@EX?3?5Pageable?5code?5called?5at?5IRQL@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8
	push	0
	push	73					; 00000049H
	push	OFFSET ??_C@_0FH@DLBEFNBC@c?3?2radasm?2wdk?2projects?2driver_pr@NNGAKEGL@
	push	OFFSET ??_C@_01GBGANLPD@0?$AA@NNGAKEGL@
	call	DWORD PTR __imp__RtlAssert@16
$LN42@DeviceCont:

; 74   : 	
; 75   : 	Irp->IoStatus.Information = 0;

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [eax+28], 0

; 76   : 	switch(ioStack->Parameters.DeviceIoControl.IoControlCode)

	mov	ecx, DWORD PTR _ioStack$[ebp]
	mov	edx, DWORD PTR [ecx+12]
	mov	DWORD PTR tv82[ebp], edx
	cmp	DWORD PTR tv82[ebp], 2236416		; 00222000H
	je	SHORT $LN39@DeviceCont
	cmp	DWORD PTR tv82[ebp], 2236420		; 00222004H
	je	$LN31@DeviceCont
	cmp	DWORD PTR tv82[ebp], 2236424		; 00222008H
	je	$LN16@DeviceCont
	jmp	$LN1@DeviceCont
$LN39@DeviceCont:

; 77   : 	{
; 78   : 		case IOCTL_GET_PCI_COMMON_HEADER:
; 79   : 			inBuf = Irp->AssociatedIrp.SystemBuffer;

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	ecx, DWORD PTR [eax+12]
	mov	DWORD PTR _inBuf$[ebp], ecx

; 80   : 			if( inBufLen != sizeof(PCI_SLOT_NUMBER_EXT) )

	cmp	DWORD PTR _inBufLen$[ebp], 4
	je	SHORT $LN38@DeviceCont

; 81   : 			{
; 82   : 				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );

	mov	edx, DWORD PTR _inBufLen$[ebp]
	push	edx
	push	OFFSET ??_C@_0DP@HLDLJDOO@DeviceControlDispatchRoutine?3Inp@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8

; 83   : 				status = STATUS_INVALID_PARAMETER;

	mov	DWORD PTR _status$[ebp], -1073741811	; c000000dH

; 84   : 				break;

	jmp	$LN40@DeviceCont
$LN38@DeviceCont:

; 85   : 			}
; 86   : 			if( outBufLen < sizeof(PCI_COMMON_HEADER) )

	cmp	DWORD PTR _outBufLen$[ebp], 64		; 00000040H
	jae	SHORT $LN37@DeviceCont

; 87   : 			{
; 88   : 				KdPrint( (__FUNCTION__":Output buffer length = %d too small\n", outBufLen) );

	mov	eax, DWORD PTR _outBufLen$[ebp]
	push	eax
	push	OFFSET ??_C@_0EC@EHPFAIPI@DeviceControlDispatchRoutine?3Out@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8

; 89   : 				status = STATUS_BUFFER_TOO_SMALL;

	mov	DWORD PTR _status$[ebp], -1073741789	; c0000023H

; 90   : 				break;

	jmp	$LN40@DeviceCont
$LN37@DeviceCont:

; 91   : 			}
; 92   : 		
; 93   : 			slotNum	= *inBuf;

	mov	ecx, DWORD PTR _inBuf$[ebp]
	mov	edx, DWORD PTR [ecx]
	mov	DWORD PTR _slotNum$[ebp], edx

; 94   : 			slotNum.u.bits.RegisterNumber	= 0;

	mov	eax, DWORD PTR _slotNum$[ebp]
	and	eax, -253				; ffffff03H
	mov	DWORD PTR _slotNum$[ebp], eax

; 95   : 			slotNum.u.bits.Reserved1		= 0;

	mov	ecx, DWORD PTR _slotNum$[ebp]
	and	ecx, -4					; fffffffcH
	mov	DWORD PTR _slotNum$[ebp], ecx

; 96   : 			slotNum.u.bits.TestBit			= 1;

	mov	edx, DWORD PTR _slotNum$[ebp]
	or	edx, -2147483648			; 80000000H
	mov	DWORD PTR _slotNum$[ebp], edx

; 97   : 			
; 98   : #pragma warning(push)
; 99   : #pragma warning(disable: 28138)
; 100  : /*
; 101  : 28138 - The constant argument <operand> should instead be variable
; 102  : The driver is calling a function that expects a variable or a non-constant 
; 103  : expression, but the call includes a constant. For example, the parameter 
; 104  : of the READ_PORT_ ... /WRITE_PORT_... macro must be a pointer to the 
; 105  : port address, not the address provided as a constant.
; 106  : There are a few older devices for which a constant parameter is acceptable
; 107  : with  the READ_PORT and WRITE_PORT family of functions. When those 
; 108  : devices receive this warning, the warning can be suppressed or ignored.
; 109  : */
; 110  : 			WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);

	mov	eax, DWORD PTR _slotNum$[ebp]
	push	eax
	push	3320					; 00000cf8H
	call	DWORD PTR __imp__WRITE_PORT_ULONG@8

; 111  : 			*outBuf = READ_PORT_ULONG((PULONG)0xcfc);

	push	3324					; 00000cfcH
	call	DWORD PTR __imp__READ_PORT_ULONG@4
	mov	ecx, DWORD PTR _outBuf$[ebp]
	mov	DWORD PTR [ecx], eax

; 112  : 			if( (ULONG)0xffffffff != *outBuf)

	mov	edx, DWORD PTR _outBuf$[ebp]
	cmp	DWORD PTR [edx], -1
	je	SHORT $LN36@DeviceCont

; 113  : 			{
; 114  : 				for(regNum = 1 ; regNum <= 15 ; regNum++)

	mov	DWORD PTR _regNum$[ebp], 1
	jmp	SHORT $LN35@DeviceCont
$LN34@DeviceCont:
	mov	eax, DWORD PTR _regNum$[ebp]
	add	eax, 1
	mov	DWORD PTR _regNum$[ebp], eax
$LN35@DeviceCont:
	cmp	DWORD PTR _regNum$[ebp], 15		; 0000000fH
	ja	SHORT $LN33@DeviceCont

; 115  : 				{
; 116  : 					slotNum.u.bits.RegisterNumber+=4;

	mov	ecx, DWORD PTR _slotNum$[ebp]
	shr	ecx, 2
	and	ecx, 63					; 0000003fH
	add	ecx, 4
	and	ecx, 63					; 0000003fH
	shl	ecx, 2
	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -253				; ffffff03H
	or	edx, ecx
	mov	DWORD PTR _slotNum$[ebp], edx

; 117  : 					WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);

	mov	eax, DWORD PTR _slotNum$[ebp]
	push	eax
	push	3320					; 00000cf8H
	call	DWORD PTR __imp__WRITE_PORT_ULONG@8

; 118  : 					*(outBuf+regNum) = READ_PORT_ULONG((PULONG)0xcfc);

	push	3324					; 00000cfcH
	call	DWORD PTR __imp__READ_PORT_ULONG@4
	mov	ecx, DWORD PTR _regNum$[ebp]
	mov	edx, DWORD PTR _outBuf$[ebp]
	mov	DWORD PTR [edx+ecx*4], eax

; 119  : 				}

	jmp	SHORT $LN34@DeviceCont
$LN33@DeviceCont:

; 120  : 				Irp->IoStatus.Information = 16*sizeof(ULONG);

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [eax+28], 64			; 00000040H

; 121  : 			}
; 122  : 			else

	jmp	SHORT $LN32@DeviceCont
$LN36@DeviceCont:

; 123  : 			{
; 124  : 				status = STATUS_INVALID_PARAMETER;

	mov	DWORD PTR _status$[ebp], -1073741811	; c000000dH

; 125  : 				Irp->IoStatus.Information = sizeof(ULONG);

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [ecx+28], 4
$LN32@DeviceCont:

; 126  : 			}
; 127  : #pragma warning(pop)			
; 128  : 			break;

	jmp	$LN40@DeviceCont
$LN31@DeviceCont:

; 129  : 			
; 130  : 		case IOCTL_FIND_PCI_DEVICE:
; 131  : 			inBufReg = Irp->AssociatedIrp.SystemBuffer;

	mov	edx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR [edx+12]
	mov	DWORD PTR _inBufReg$[ebp], eax

; 132  : 			if( inBufLen != 2 * sizeof(ULONG) )

	cmp	DWORD PTR _inBufLen$[ebp], 8
	je	SHORT $LN30@DeviceCont

; 133  : 			{
; 134  : 				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );

	mov	ecx, DWORD PTR _inBufLen$[ebp]
	push	ecx
	push	OFFSET ??_C@_0DP@HLDLJDOO@DeviceControlDispatchRoutine?3Inp@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8

; 135  : 				status = STATUS_INVALID_PARAMETER;

	mov	DWORD PTR _status$[ebp], -1073741811	; c000000dH

; 136  : 				break;

	jmp	$LN40@DeviceCont
$LN30@DeviceCont:

; 137  : 			}
; 138  : 			if( outBufLen != sizeof(PCI_SLOT_NUMBER_EXT) + 16*sizeof(ULONG) )

	cmp	DWORD PTR _outBufLen$[ebp], 68		; 00000044H
	je	SHORT $LN29@DeviceCont

; 139  : 			{
; 140  : 				KdPrint( (__FUNCTION__":Output buffer length = %d too small\n", outBufLen) );

	mov	edx, DWORD PTR _outBufLen$[ebp]
	push	edx
	push	OFFSET ??_C@_0EC@EHPFAIPI@DeviceControlDispatchRoutine?3Out@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8

; 141  : 				status = STATUS_INVALID_PARAMETER;

	mov	DWORD PTR _status$[ebp], -1073741811	; c000000dH

; 142  : 				break;

	jmp	$LN40@DeviceCont
$LN29@DeviceCont:

; 143  : 			}
; 144  : 			
; 145  : 			slotNum.u.bits.RegisterNumber	= 0;

	mov	eax, DWORD PTR _slotNum$[ebp]
	and	eax, -253				; ffffff03H
	mov	DWORD PTR _slotNum$[ebp], eax

; 146  : 			slotNum.u.bits.Reserved1		= 0;

	mov	ecx, DWORD PTR _slotNum$[ebp]
	and	ecx, -4					; fffffffcH
	mov	DWORD PTR _slotNum$[ebp], ecx

; 147  : 			slotNum.u.bits.TestBit			= 1;

	mov	edx, DWORD PTR _slotNum$[ebp]
	or	edx, -2147483648			; 80000000H
	mov	DWORD PTR _slotNum$[ebp], edx

; 148  : 			
; 149  : #pragma warning(push)
; 150  : #pragma warning(disable: 28138)
; 151  : /*
; 152  : 28138 - The constant argument <operand> should instead be variable
; 153  : The driver is calling a function that expects a variable or a non-constant 
; 154  : expression, but the call includes a constant. For example, the parameter 
; 155  : of the READ_PORT_ ... /WRITE_PORT_... macro must be a pointer to the 
; 156  : port address, not the address provided as a constant.
; 157  : There are a few older devices for which a constant parameter is acceptable
; 158  : with  the READ_PORT and WRITE_PORT family of functions. When those 
; 159  : devices receive this warning, the warning can be suppressed or ignored.
; 160  : */
; 161  : 			
; 162  : 			for(bus = 0 ; bus < PCI_MAX_BRIDGE_NUMBER ; bus++)

	mov	DWORD PTR _bus$[ebp], 0
	jmp	SHORT $LN28@DeviceCont
$LN27@DeviceCont:
	mov	eax, DWORD PTR _bus$[ebp]
	add	eax, 1
	mov	DWORD PTR _bus$[ebp], eax
$LN28@DeviceCont:
	cmp	DWORD PTR _bus$[ebp], 255		; 000000ffH
	jae	$LN26@DeviceCont

; 163  : 			{
; 164  : 				slotNum.u.bits.BusNumber = bus;

	mov	ecx, DWORD PTR _bus$[ebp]
	and	ecx, 255				; 000000ffH
	shl	ecx, 16					; 00000010H
	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -16711681				; ff00ffffH
	or	edx, ecx
	mov	DWORD PTR _slotNum$[ebp], edx

; 165  : 				slotNum.u.bits.DeviceNumber = *(inBufReg + 1);			

	mov	eax, DWORD PTR _inBufReg$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	and	ecx, 31					; 0000001fH
	shl	ecx, 11					; 0000000bH
	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -63489				; ffff07ffH
	or	edx, ecx
	mov	DWORD PTR _slotNum$[ebp], edx

; 166  : 				for(function = 0 ; function < PCI_MAX_FUNCTION ; function++)

	mov	DWORD PTR _function$[ebp], 0
	jmp	SHORT $LN25@DeviceCont
$LN24@DeviceCont:
	mov	eax, DWORD PTR _function$[ebp]
	add	eax, 1
	mov	DWORD PTR _function$[ebp], eax
$LN25@DeviceCont:
	cmp	DWORD PTR _function$[ebp], 8
	jae	$LN23@DeviceCont

; 167  : 				{
; 168  : 					slotNum.u.bits.FunctionNumber = function;

	mov	ecx, DWORD PTR _function$[ebp]
	and	ecx, 7
	shl	ecx, 8
	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -1793				; fffff8ffH
	or	edx, ecx
	mov	DWORD PTR _slotNum$[ebp], edx

; 169  : 					WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);

	mov	eax, DWORD PTR _slotNum$[ebp]
	push	eax
	push	3320					; 00000cf8H
	call	DWORD PTR __imp__WRITE_PORT_ULONG@8

; 170  : 					if( *inBufReg == READ_PORT_ULONG((PULONG)0xcfc))

	push	3324					; 00000cfcH
	call	DWORD PTR __imp__READ_PORT_ULONG@4
	mov	ecx, DWORD PTR _inBufReg$[ebp]
	cmp	DWORD PTR [ecx], eax
	jne	SHORT $LN22@DeviceCont

; 171  : 					{
; 172  : 						*outBuf = READ_PORT_ULONG((PULONG)0xcfc);

	push	3324					; 00000cfcH
	call	DWORD PTR __imp__READ_PORT_ULONG@4
	mov	edx, DWORD PTR _outBuf$[ebp]
	mov	DWORD PTR [edx], eax

; 173  : 						for(regNum = 1 ; regNum <= 15 ; regNum++)

	mov	DWORD PTR _regNum$[ebp], 1
	jmp	SHORT $LN21@DeviceCont
$LN20@DeviceCont:
	mov	eax, DWORD PTR _regNum$[ebp]
	add	eax, 1
	mov	DWORD PTR _regNum$[ebp], eax
$LN21@DeviceCont:
	cmp	DWORD PTR _regNum$[ebp], 15		; 0000000fH
	ja	SHORT $LN19@DeviceCont

; 174  : 						{
; 175  : 							slotNum.u.bits.RegisterNumber+=4;

	mov	ecx, DWORD PTR _slotNum$[ebp]
	shr	ecx, 2
	and	ecx, 63					; 0000003fH
	add	ecx, 4
	and	ecx, 63					; 0000003fH
	shl	ecx, 2
	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -253				; ffffff03H
	or	edx, ecx
	mov	DWORD PTR _slotNum$[ebp], edx

; 176  : 							WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);

	mov	eax, DWORD PTR _slotNum$[ebp]
	push	eax
	push	3320					; 00000cf8H
	call	DWORD PTR __imp__WRITE_PORT_ULONG@8

; 177  : 							*(outBuf+regNum) = READ_PORT_ULONG((PULONG)0xcfc);

	push	3324					; 00000cfcH
	call	DWORD PTR __imp__READ_PORT_ULONG@4
	mov	ecx, DWORD PTR _regNum$[ebp]
	mov	edx, DWORD PTR _outBuf$[ebp]
	mov	DWORD PTR [edx+ecx*4], eax

; 178  : 						}

	jmp	SHORT $LN20@DeviceCont
$LN19@DeviceCont:

; 179  : 						*(outBuf+regNum) = slotNum.u.AsULONG;

	mov	eax, DWORD PTR _regNum$[ebp]
	mov	ecx, DWORD PTR _outBuf$[ebp]
	mov	edx, DWORD PTR _slotNum$[ebp]
	mov	DWORD PTR [ecx+eax*4], edx

; 180  : 						isDeviceFound = TRUE;

	mov	BYTE PTR _isDeviceFound$[ebp], 1

; 181  : 						break;

	jmp	SHORT $LN23@DeviceCont
$LN22@DeviceCont:

; 182  : 					}
; 183  : 					
; 184  : 					if (isDeviceFound == TRUE) break;

	movzx	eax, BYTE PTR _isDeviceFound$[ebp]
	cmp	eax, 1
	jne	SHORT $LN18@DeviceCont
	jmp	SHORT $LN23@DeviceCont
$LN18@DeviceCont:

; 185  : 				}

	jmp	$LN24@DeviceCont
$LN23@DeviceCont:

; 186  : 					
; 187  : 				if (isDeviceFound == TRUE) break;

	movzx	ecx, BYTE PTR _isDeviceFound$[ebp]
	cmp	ecx, 1
	jne	SHORT $LN17@DeviceCont
	jmp	SHORT $LN26@DeviceCont
$LN17@DeviceCont:

; 188  : 				slotNum.u.bits.BusNumber = 0;

	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -16711681				; ff00ffffH
	mov	DWORD PTR _slotNum$[ebp], edx

; 189  : 				slotNum.u.bits.DeviceNumber = 0;

	mov	eax, DWORD PTR _slotNum$[ebp]
	and	eax, -63489				; ffff07ffH
	mov	DWORD PTR _slotNum$[ebp], eax

; 190  : 				slotNum.u.bits.FunctionNumber = 0;

	mov	ecx, DWORD PTR _slotNum$[ebp]
	and	ecx, -1793				; fffff8ffH
	mov	DWORD PTR _slotNum$[ebp], ecx

; 191  : 				memset(outBuf, 0, 16*sizeof(ULONG) + sizeof(PCI_SLOT_NUMBER_EXT));

	push	68					; 00000044H
	push	0
	mov	edx, DWORD PTR _outBuf$[ebp]
	push	edx
	call	_memset
	add	esp, 12					; 0000000cH

; 192  : 			}

	jmp	$LN27@DeviceCont
$LN26@DeviceCont:

; 193  : 			
; 194  : 			Irp->IoStatus.Information = 16*sizeof(ULONG) + sizeof(PCI_SLOT_NUMBER_EXT) ;

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [eax+28], 68			; 00000044H

; 195  : #pragma warning(pop)	
; 196  : 			break;

	jmp	$LN40@DeviceCont
$LN16@DeviceCont:

; 197  : 		
; 198  : 		case IOCTL_GET_PCI_CLASS_CODE:
; 199  : 			inBufReg = Irp->AssociatedIrp.SystemBuffer;

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR [ecx+12]
	mov	DWORD PTR _inBufReg$[ebp], edx

; 200  : 			if( inBufLen != 2 * sizeof(ULONG) )

	cmp	DWORD PTR _inBufLen$[ebp], 8
	je	SHORT $LN15@DeviceCont

; 201  : 			{
; 202  : 				KdPrint( (__FUNCTION__":Input buffer length = %d invalid\n", inBufLen) );

	mov	eax, DWORD PTR _inBufLen$[ebp]
	push	eax
	push	OFFSET ??_C@_0DP@HLDLJDOO@DeviceControlDispatchRoutine?3Inp@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8

; 203  : 				status = STATUS_INVALID_PARAMETER;

	mov	DWORD PTR _status$[ebp], -1073741811	; c000000dH

; 204  : 				break;

	jmp	$LN40@DeviceCont
$LN15@DeviceCont:

; 205  : 			}
; 206  : 			if( outBufLen != sizeof(PCI_SLOT_NUMBER_EXT) + 16*sizeof(ULONG) )

	cmp	DWORD PTR _outBufLen$[ebp], 68		; 00000044H
	je	SHORT $LN14@DeviceCont

; 207  : 			{
; 208  : 				KdPrint( (__FUNCTION__":Output buffer length = %d too small\n", outBufLen) );

	mov	ecx, DWORD PTR _outBufLen$[ebp]
	push	ecx
	push	OFFSET ??_C@_0EC@EHPFAIPI@DeviceControlDispatchRoutine?3Out@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8

; 209  : 				status = STATUS_INVALID_PARAMETER;

	mov	DWORD PTR _status$[ebp], -1073741811	; c000000dH

; 210  : 				break;

	jmp	$LN40@DeviceCont
$LN14@DeviceCont:

; 211  : 			}
; 212  : 			
; 213  : 			slotNum.u.bits.RegisterNumber	= 8;

	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -253				; ffffff03H
	or	edx, 32					; 00000020H
	mov	DWORD PTR _slotNum$[ebp], edx

; 214  : 			slotNum.u.bits.Reserved1		= 0;

	mov	eax, DWORD PTR _slotNum$[ebp]
	and	eax, -4					; fffffffcH
	mov	DWORD PTR _slotNum$[ebp], eax

; 215  : 			slotNum.u.bits.TestBit			= 1;

	mov	ecx, DWORD PTR _slotNum$[ebp]
	or	ecx, -2147483648			; 80000000H
	mov	DWORD PTR _slotNum$[ebp], ecx

; 216  : 			
; 217  : #pragma warning(push)
; 218  : #pragma warning(disable: 28138)
; 219  : /*
; 220  : 28138 - The constant argument <operand> should instead be variable
; 221  : The driver is calling a function that expects a variable or a non-constant 
; 222  : expression, but the call includes a constant. For example, the parameter 
; 223  : of the READ_PORT_ ... /WRITE_PORT_... macro must be a pointer to the 
; 224  : port address, not the address provided as a constant.
; 225  : There are a few older devices for which a constant parameter is acceptable
; 226  : with  the READ_PORT and WRITE_PORT family of functions. When those 
; 227  : devices receive this warning, the warning can be suppressed or ignored.
; 228  : */
; 229  : 			
; 230  : 			for(bus = 0 ; bus < PCI_MAX_BRIDGE_NUMBER ; bus++)

	mov	DWORD PTR _bus$[ebp], 0
	jmp	SHORT $LN13@DeviceCont
$LN12@DeviceCont:
	mov	edx, DWORD PTR _bus$[ebp]
	add	edx, 1
	mov	DWORD PTR _bus$[ebp], edx
$LN13@DeviceCont:
	cmp	DWORD PTR _bus$[ebp], 255		; 000000ffH
	jae	$LN11@DeviceCont

; 231  : 			{
; 232  : 				slotNum.u.bits.BusNumber = bus;

	mov	eax, DWORD PTR _bus$[ebp]
	and	eax, 255				; 000000ffH
	shl	eax, 16					; 00000010H
	mov	ecx, DWORD PTR _slotNum$[ebp]
	and	ecx, -16711681				; ff00ffffH
	or	ecx, eax
	mov	DWORD PTR _slotNum$[ebp], ecx

; 233  : 				slotNum.u.bits.DeviceNumber = *(inBufReg + 1);			

	mov	edx, DWORD PTR _inBufReg$[ebp]
	mov	eax, DWORD PTR [edx+4]
	and	eax, 31					; 0000001fH
	shl	eax, 11					; 0000000bH
	mov	ecx, DWORD PTR _slotNum$[ebp]
	and	ecx, -63489				; ffff07ffH
	or	ecx, eax
	mov	DWORD PTR _slotNum$[ebp], ecx

; 234  : 				for(function = 0 ; function < PCI_MAX_FUNCTION ; function++)

	mov	DWORD PTR _function$[ebp], 0
	jmp	SHORT $LN10@DeviceCont
$LN9@DeviceCont:
	mov	edx, DWORD PTR _function$[ebp]
	add	edx, 1
	mov	DWORD PTR _function$[ebp], edx
$LN10@DeviceCont:
	cmp	DWORD PTR _function$[ebp], 8
	jae	$LN8@DeviceCont

; 235  : 				{
; 236  : 					slotNum.u.bits.FunctionNumber = function;

	mov	eax, DWORD PTR _function$[ebp]
	and	eax, 7
	shl	eax, 8
	mov	ecx, DWORD PTR _slotNum$[ebp]
	and	ecx, -1793				; fffff8ffH
	or	ecx, eax
	mov	DWORD PTR _slotNum$[ebp], ecx

; 237  : 					WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);

	mov	edx, DWORD PTR _slotNum$[ebp]
	push	edx
	push	3320					; 00000cf8H
	call	DWORD PTR __imp__WRITE_PORT_ULONG@8

; 238  : 					// reset the lowest 8 bits
; 239  : 					classCode = READ_PORT_ULONG((PULONG)0xcfc) & (ULONG)0xffffff00;

	push	3324					; 00000cfcH
	call	DWORD PTR __imp__READ_PORT_ULONG@4
	and	eax, -256				; ffffff00H
	mov	DWORD PTR _classCode$[ebp], eax

; 240  : 					if( *inBufReg == classCode )

	mov	eax, DWORD PTR _inBufReg$[ebp]
	mov	ecx, DWORD PTR [eax]
	cmp	ecx, DWORD PTR _classCode$[ebp]
	jne	$LN7@DeviceCont

; 241  : 					{
; 242  : 						slotNum.u.bits.RegisterNumber = 0;

	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -253				; ffffff03H
	mov	DWORD PTR _slotNum$[ebp], edx

; 243  : 						WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);

	mov	eax, DWORD PTR _slotNum$[ebp]
	push	eax
	push	3320					; 00000cf8H
	call	DWORD PTR __imp__WRITE_PORT_ULONG@8

; 244  : 						*outBuf = READ_PORT_ULONG((PULONG)0xcfc);

	push	3324					; 00000cfcH
	call	DWORD PTR __imp__READ_PORT_ULONG@4
	mov	ecx, DWORD PTR _outBuf$[ebp]
	mov	DWORD PTR [ecx], eax

; 245  : 						for(regNum = 1 ; regNum <= 15 ; regNum++)

	mov	DWORD PTR _regNum$[ebp], 1
	jmp	SHORT $LN6@DeviceCont
$LN5@DeviceCont:
	mov	edx, DWORD PTR _regNum$[ebp]
	add	edx, 1
	mov	DWORD PTR _regNum$[ebp], edx
$LN6@DeviceCont:
	cmp	DWORD PTR _regNum$[ebp], 15		; 0000000fH
	ja	SHORT $LN4@DeviceCont

; 246  : 						{
; 247  : 							slotNum.u.bits.RegisterNumber+=4;

	mov	eax, DWORD PTR _slotNum$[ebp]
	shr	eax, 2
	and	eax, 63					; 0000003fH
	add	eax, 4
	and	eax, 63					; 0000003fH
	shl	eax, 2
	mov	ecx, DWORD PTR _slotNum$[ebp]
	and	ecx, -253				; ffffff03H
	or	ecx, eax
	mov	DWORD PTR _slotNum$[ebp], ecx

; 248  : 							WRITE_PORT_ULONG((PULONG)0xcf8, slotNum.u.AsULONG);

	mov	edx, DWORD PTR _slotNum$[ebp]
	push	edx
	push	3320					; 00000cf8H
	call	DWORD PTR __imp__WRITE_PORT_ULONG@8

; 249  : 							*(outBuf+regNum) = READ_PORT_ULONG((PULONG)0xcfc);

	push	3324					; 00000cfcH
	call	DWORD PTR __imp__READ_PORT_ULONG@4
	mov	ecx, DWORD PTR _regNum$[ebp]
	mov	edx, DWORD PTR _outBuf$[ebp]
	mov	DWORD PTR [edx+ecx*4], eax

; 250  : 						}

	jmp	SHORT $LN5@DeviceCont
$LN4@DeviceCont:

; 251  : 						*(outBuf+regNum) = slotNum.u.AsULONG;

	mov	eax, DWORD PTR _regNum$[ebp]
	mov	ecx, DWORD PTR _outBuf$[ebp]
	mov	edx, DWORD PTR _slotNum$[ebp]
	mov	DWORD PTR [ecx+eax*4], edx

; 252  : 						isDeviceFound = TRUE;

	mov	BYTE PTR _isDeviceFound$[ebp], 1

; 253  : 						break;

	jmp	SHORT $LN8@DeviceCont
$LN7@DeviceCont:

; 254  : 					}
; 255  : 					if (isDeviceFound == TRUE) break;

	movzx	eax, BYTE PTR _isDeviceFound$[ebp]
	cmp	eax, 1
	jne	SHORT $LN3@DeviceCont
	jmp	SHORT $LN8@DeviceCont
$LN3@DeviceCont:

; 256  : 				}

	jmp	$LN9@DeviceCont
$LN8@DeviceCont:

; 257  : 				if (isDeviceFound == TRUE) break;

	movzx	ecx, BYTE PTR _isDeviceFound$[ebp]
	cmp	ecx, 1
	jne	SHORT $LN2@DeviceCont
	jmp	SHORT $LN11@DeviceCont
$LN2@DeviceCont:

; 258  : 				slotNum.u.bits.BusNumber = 0;

	mov	edx, DWORD PTR _slotNum$[ebp]
	and	edx, -16711681				; ff00ffffH
	mov	DWORD PTR _slotNum$[ebp], edx

; 259  : 				slotNum.u.bits.DeviceNumber = 0;

	mov	eax, DWORD PTR _slotNum$[ebp]
	and	eax, -63489				; ffff07ffH
	mov	DWORD PTR _slotNum$[ebp], eax

; 260  : 				slotNum.u.bits.FunctionNumber = 0;

	mov	ecx, DWORD PTR _slotNum$[ebp]
	and	ecx, -1793				; fffff8ffH
	mov	DWORD PTR _slotNum$[ebp], ecx

; 261  : 				memset(outBuf, 0, 16*sizeof(ULONG) + sizeof(PCI_SLOT_NUMBER_EXT));

	push	68					; 00000044H
	push	0
	mov	edx, DWORD PTR _outBuf$[ebp]
	push	edx
	call	_memset
	add	esp, 12					; 0000000cH

; 262  : 			}

	jmp	$LN12@DeviceCont
$LN11@DeviceCont:

; 263  : 			Irp->IoStatus.Information = 16*sizeof(ULONG) + sizeof(PCI_SLOT_NUMBER_EXT) ;

	mov	eax, DWORD PTR _Irp$[ebp]
	mov	DWORD PTR [eax+28], 68			; 00000044H

; 264  : #pragma warning(pop)	
; 265  : 			
; 266  : 			break;

	jmp	SHORT $LN40@DeviceCont
$LN1@DeviceCont:

; 267  : 
; 268  : 		default:
; 269  : 			status = STATUS_INVALID_DEVICE_REQUEST;

	mov	DWORD PTR _status$[ebp], -1073741808	; c0000010H
$LN40@DeviceCont:

; 270  : 			break;
; 271  : 	}	
; 272  : 		
; 273  : 	Irp->IoStatus.Status = status;

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	edx, DWORD PTR _status$[ebp]
	mov	DWORD PTR [ecx+24], edx

; 274  : 	IoCompleteRequest(Irp, IO_NO_INCREMENT);

	xor	dl, dl
	mov	ecx, DWORD PTR _Irp$[ebp]
	call	DWORD PTR __imp_@IofCompleteRequest@8

; 275  : 	return status;

	mov	eax, DWORD PTR _status$[ebp]

; 276  : }

	mov	esp, ebp
	pop	ebp
	ret	8
_DeviceControlDispatchRoutine@8 ENDP
PAGE	ENDS
PUBLIC	??_C@_0CM@LOONDNKF@Irp?9?$DOCurrentLocation?5?$DM?$DN?5Irp?9?$DOSta@FNODOBFM@ ;  ?? ::FNODOBFM::`string'
PUBLIC	??_C@_0BI@POHNOCHP@c?3?2winddk?2inc?2ddk?2wdm?4h?$AA@FNODOBFM@ ;  ?? ::FNODOBFM::`string'
;	COMDAT ??_C@_0CM@LOONDNKF@Irp?9?$DOCurrentLocation?5?$DM?$DN?5Irp?9?$DOSta@FNODOBFM@
; File c:\winddk\inc\ddk\wdm.h
text$s	SEGMENT
??_C@_0CM@LOONDNKF@Irp?9?$DOCurrentLocation?5?$DM?$DN?5Irp?9?$DOSta@FNODOBFM@ DB 'I'
	DB	'rp->CurrentLocation <= Irp->StackCount + 1', 00H ;  ?? ::FNODOBFM::`string'
text$s	ENDS
;	COMDAT ??_C@_0BI@POHNOCHP@c?3?2winddk?2inc?2ddk?2wdm?4h?$AA@FNODOBFM@
text$s	SEGMENT
??_C@_0BI@POHNOCHP@c?3?2winddk?2inc?2ddk?2wdm?4h?$AA@FNODOBFM@ DB 'c:\win'
	DB	'ddk\inc\ddk\wdm.h', 00H			;  ?? ::FNODOBFM::`string'
; Function compile flags: /Odtp
text$s	ENDS
;	COMDAT _IoGetCurrentIrpStackLocation@4
_TEXT	SEGMENT
tv74 = -4						; size = 4
_Irp$ = 8						; size = 4
_IoGetCurrentIrpStackLocation@4 PROC			; COMDAT

; 23316: {

	npad	2
	push	ebp
	mov	ebp, esp
	push	ecx

; 23317:     ASSERT(Irp->CurrentLocation <= Irp->StackCount + 1);

	mov	eax, DWORD PTR _Irp$[ebp]
	movsx	ecx, BYTE PTR [eax+35]
	mov	edx, DWORD PTR _Irp$[ebp]
	movsx	eax, BYTE PTR [edx+34]
	add	eax, 1
	cmp	ecx, eax
	jle	SHORT $LN3@IoGetCurre
	push	0
	push	23317					; 00005b15H
	push	OFFSET ??_C@_0BI@POHNOCHP@c?3?2winddk?2inc?2ddk?2wdm?4h?$AA@FNODOBFM@
	push	OFFSET ??_C@_0CM@LOONDNKF@Irp?9?$DOCurrentLocation?5?$DM?$DN?5Irp?9?$DOSta@FNODOBFM@
	call	DWORD PTR __imp__RtlAssert@16
	mov	DWORD PTR tv74[ebp], 0
	jmp	SHORT $LN4@IoGetCurre
$LN3@IoGetCurre:
	mov	DWORD PTR tv74[ebp], 1
$LN4@IoGetCurre:

; 23318:     return Irp->Tail.Overlay.CurrentStackLocation;

	mov	ecx, DWORD PTR _Irp$[ebp]
	mov	eax, DWORD PTR [ecx+96]

; 23319: }

	mov	esp, ebp
	pop	ebp
	ret	4
_IoGetCurrentIrpStackLocation@4 ENDP
_TEXT	ENDS
EXTRN	__imp__IoDeleteSymbolicLink@4:PROC
; Function compile flags: /Odtp
; File c:\radasm\wdk\projects\driver_projects\pdlr06_gladyr\pciconfigviewer\pciconfigviewer.c
;	COMDAT _DriverUnload@4
PAGE	SEGMENT
_DeviceObject$ = -4					; size = 4
_DriverObject$ = 8					; size = 4
_DriverUnload@4 PROC					; COMDAT

; 280  : {

	npad	2
	push	ebp
	mov	ebp, esp
	push	ecx

; 281  : 	PDEVICE_OBJECT	DeviceObject = DriverObject->DeviceObject;

	mov	eax, DWORD PTR _DriverObject$[ebp]
	mov	ecx, DWORD PTR [eax+4]
	mov	DWORD PTR _DeviceObject$[ebp], ecx

; 282  : 
; 283  : 	PAGED_CODE();

	call	DWORD PTR __imp__KeGetCurrentIrql@0
	movzx	edx, al
	cmp	edx, 1
	jle	SHORT $LN2@DriverUnlo
	call	DWORD PTR __imp__KeGetCurrentIrql@0
	movzx	eax, al
	push	eax
	push	OFFSET ??_C@_0CF@FOPNHIJF@EX?3?5Pageable?5code?5called?5at?5IRQL@NNGAKEGL@
	call	_DbgPrint
	add	esp, 8
	push	0
	push	283					; 0000011bH
	push	OFFSET ??_C@_0FH@DLBEFNBC@c?3?2radasm?2wdk?2projects?2driver_pr@NNGAKEGL@
	push	OFFSET ??_C@_01GBGANLPD@0?$AA@NNGAKEGL@
	call	DWORD PTR __imp__RtlAssert@16
$LN2@DriverUnlo:

; 284  : 
; 285  : 	IoDeleteSymbolicLink((PUNICODE_STRING)&symbolicLinkName);

	push	OFFSET _symbolicLinkName
	call	DWORD PTR __imp__IoDeleteSymbolicLink@4

; 286  : 	if (DeviceObject != NULL)

	cmp	DWORD PTR _DeviceObject$[ebp], 0
	je	SHORT $LN3@DriverUnlo

; 287  : 	{
; 288  : 		IoDeleteDevice(DeviceObject);

	mov	ecx, DWORD PTR _DeviceObject$[ebp]
	push	ecx
	call	DWORD PTR __imp__IoDeleteDevice@4
$LN3@DriverUnlo:

; 289  : 	}
; 290  : }

	mov	esp, ebp
	pop	ebp
	ret	4
_DriverUnload@4 ENDP
PAGE	ENDS
END
