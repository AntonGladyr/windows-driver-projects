; Listing generated by Microsoft (R) Optimizing Compiler Version 15.00.30729.207 

	TITLE	c:\radasm\wdk\projects\driver_projects\pdlr04_gladyr\filedevioscp\filedevioscp.c
	.686P
	.XMM
	include listing.inc
	.model	flat

INCLUDELIB LIBCMT
INCLUDELIB OLDNAMES

PUBLIC	_serviceName
PUBLIC	_symbolicLinkName
PUBLIC	_imageName
_DATA	SEGMENT
_serviceName DB	'F', 00H, 'i', 00H, 'l', 00H, 'e', 00H, 'D', 00H, 'e', 00H
	DB	'v', 00H, 'I', 00H, 'O', 00H, 'D', 00H, 'e', 00H, 'm', 00H, 'o'
	DB	00H, 00H, 00H
_symbolicLinkName DB '\', 00H, '\', 00H, '.', 00H, '\', 00H, 'F', 00H, 'i'
	DB	00H, 'l', 00H, 'e', 00H, 'D', 00H, 'e', 00H, 'v', 00H, 'I', 00H
	DB	'O', 00H, 'D', 00H, 'e', 00H, 'm', 00H, 'o', 00H, 00H, 00H
_imageName DB	'F', 00H, 'i', 00H, 'l', 00H, 'e', 00H, 'D', 00H, 'e', 00H
	DB	'v', 00H, 'I', 00H, 'O', 00H, 'D', 00H, 'e', 00H, 'm', 00H, 'o'
	DB	00H, '.', 00H, 's', 00H, 'y', 00H, 's', 00H, 00H, 00H
_DATA	ENDS
PUBLIC	??_C@_1DA@HBHLMCKP@?$AA?6?$AAP?$AAr?$AAe?$AAs?$AAs?$AA?5?$AA?8?$AAE?$AAn?$AAt?$AAe?$AAr?$AA?8?$AA?5?$AAt?$AAo?$AA?5?$AAe?$AAx?$AAi?$AAt?$AA?6?$AA?$AA@ ; `string'
PUBLIC	??_C@_1FK@KCMKJLAP@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAd?$AAe?$AAl?$AAe?$AAt?$AAe?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo@ ; `string'
PUBLIC	??_C@_1CM@BNAEJNDE@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAd?$AAe?$AAl?$AAe?$AAt?$AAe?$AAd?$AA?$AA@ ; `string'
PUBLIC	??_C@_1FG@OPEJBFDE@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAs?$AAt?$AAo?$AAp?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC@ ; `string'
PUBLIC	??_C@_1CM@MPDEBAGD@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAs?$AAt?$AAo?$AAp?$AAp?$AAe?$AAd?$AA?$AA@ ; `string'
PUBLIC	??_C@_1EI@KGLDCLGB@?$AA?6?$AAR?$AAe?$AAa?$AAd?$AAF?$AAi?$AAl?$AAe?$AA?5?$AAf?$AAa?$AAi?$AAl?$AAe?$AAd?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC?$AAo?$AAd?$AAe?$AA?$DN?$AA0?$AAx?$AA?$CF?$AA0@ ; `string'
PUBLIC	??_C@_0BO@HGGFGIPK@?6ReadFile?5return?5?$CFd?5bytes?3?6?$CFs?$AA@ ; `string'
PUBLIC	??_C@_1EK@NOMAPGLJ@?$AAW?$AAr?$AAi?$AAt?$AAe?$AAF?$AAi?$AAl?$AAe?$AA?5?$AAf?$AAa?$AAi?$AAl?$AAe?$AAd?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC?$AAo?$AAd?$AAe?$AA?$DN?$AA0?$AAx?$AA?$CF?$AA0@ ; `string'
PUBLIC	??_C@_1CE@OFCHIDMD@?$AA?$CF?$AAd?$AA?5?$AAb?$AAy?$AAt?$AAe?$AAs?$AA?5?$AAw?$AAr?$AAi?$AAt?$AAt?$AAe?$AAn?$AA?6?$AA?$AA@ ; `string'
PUBLIC	??_C@_02DKCKIIND@?$CFs?$AA@			; `string'
PUBLIC	??_C@_1IG@JPPLKEBH@?$AA?6?$AAT?$AAy?$AAp?$AAe?$AA?5?$AAa?$AA?5?$AAf?$AAe?$AAw?$AA?5?$AAl?$AAi?$AAn?$AAe?$AAs?$AA?5?$AAa?$AAn?$AAd?$AA?5?$AAt?$AAh?$AAe?$AAn?$AA?5?$AAp?$AAr?$AAe?$AAs?$AAs@ ; `string'
PUBLIC	??_C@_1GC@JLKGGLBO@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAs?$AAy?$AAm?$AAb?$AAo?$AAl?$AAi?$AAk?$AA?5?$AAl?$AAi?$AAn?$AAk?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5@ ; `string'
PUBLIC	??_C@_1FK@LMKNJGB@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAs?$AAt?$AAa?$AAr?$AAt?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr@ ; `string'
PUBLIC	??_C@_1DM@EGBCKHGG@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAa?$AAl?$AAr?$AAe?$AAa?$AAd?$AAy?$AA?5?$AAr?$AAu?$AAn?$AAn?$AAi?$AAn?$AAg?$AA?$AA@ ; `string'
PUBLIC	??_C@_1CM@KGLKBNLK@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAs?$AAt?$AAa?$AAr?$AAt?$AAe?$AAd?$AA?$AA@ ; `string'
PUBLIC	??_C@_1FK@KJAADAND@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAc?$AAr?$AAe?$AAa?$AAt?$AAe?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo@ ; `string'
PUBLIC	??_C@_1CM@HHMAGJAG@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAc?$AAr?$AAe?$AAa?$AAt?$AAe?$AAd?$AA?$AA@ ; `string'
PUBLIC	??_C@_1HM@PAMANCBH@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAg?$AAe?$AAt?$AA?5?$AAf?$AAu?$AAl?$AAl?$AA?5?$AAp?$AAa?$AAt?$AAh?$AA?5?$AAf?$AAo?$AAr?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe@ ; `string'
PUBLIC	??_C@_1HC@PGADEBGC@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC@ ; `string'
PUBLIC	??_C@_1GK@IGFMAFKG@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AAC?$AAo?$AAn?$AAt?$AAr?$AAo?$AAl?$AA?5?$AAM?$AAa?$AAn?$AAa@ ; `string'
PUBLIC	??_C@_1DM@LIBBDIJD@?$AE?$BP?$AE?$EA?$AE?$DO?$AE3?$AE?$EA?$AE0?$AE?$DM?$AE0?$AA?5?$AEC?$AE?$DP?$AE?$EA?$AE0?$AE2?$AE?$DL?$AEV?$AE?$DN?$AE?$DN?$AEO?$AA?5?$AE4?$AE?$EA?$AE0?$AE9?$AE2?$AE5?$AE?$EA?$AE?$DO?$AE?$DM?$AA?$AA@ ; `string'
PUBLIC	__$ArrayPad$
PUBLIC	_wmain
EXTRN	_fgetwc:PROC
EXTRN	__imp___iob:BYTE
EXTRN	__imp__CloseServiceHandle@4:PROC
EXTRN	__imp__DeleteService@4:PROC
EXTRN	__imp__ControlService@12:PROC
EXTRN	__imp__CloseHandle@4:PROC
EXTRN	__imp__printf:PROC
EXTRN	__imp__ReadFile@20:PROC
EXTRN	__imp__WriteFile@20:PROC
EXTRN	_scanf_s:PROC
EXTRN	__imp__CreateFileW@28:PROC
EXTRN	__imp__StartServiceW@12:PROC
EXTRN	__imp__CreateServiceW@52:PROC
EXTRN	__imp__GetFullPathNameW@16:PROC
EXTRN	__imp__OpenServiceW@12:PROC
EXTRN	__imp__wprintf:PROC
EXTRN	__imp__GetLastError@0:PROC
EXTRN	__imp__OpenSCManagerW@12:PROC
EXTRN	__imp__SetConsoleTitleW@4:PROC
EXTRN	___security_cookie:DWORD
EXTRN	@__security_check_cookie@4:PROC
EXTRN	_memset:PROC
;	COMDAT ??_C@_1DA@HBHLMCKP@?$AA?6?$AAP?$AAr?$AAe?$AAs?$AAs?$AA?5?$AA?8?$AAE?$AAn?$AAt?$AAe?$AAr?$AA?8?$AA?5?$AAt?$AAo?$AA?5?$AAe?$AAx?$AAi?$AAt?$AA?6?$AA?$AA@
; File c:\radasm\wdk\projects\driver_projects\pdlr04_gladyr\filedevioscp\filedevioscp.c
CONST	SEGMENT
??_C@_1DA@HBHLMCKP@?$AA?6?$AAP?$AAr?$AAe?$AAs?$AAs?$AA?5?$AA?8?$AAE?$AAn?$AAt?$AAe?$AAr?$AA?8?$AA?5?$AAt?$AAo?$AA?5?$AAe?$AAx?$AAi?$AAt?$AA?6?$AA?$AA@ DB 0aH
	DB	00H, 'P', 00H, 'r', 00H, 'e', 00H, 's', 00H, 's', 00H, ' ', 00H
	DB	'''', 00H, 'E', 00H, 'n', 00H, 't', 00H, 'e', 00H, 'r', 00H, ''''
	DB	00H, ' ', 00H, 't', 00H, 'o', 00H, ' ', 00H, 'e', 00H, 'x', 00H
	DB	'i', 00H, 't', 00H, 0aH, 00H, 00H, 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_1FK@KCMKJLAP@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAd?$AAe?$AAl?$AAe?$AAt?$AAe?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo@
CONST	SEGMENT
??_C@_1FK@KCMKJLAP@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAd?$AAe?$AAl?$AAe?$AAt?$AAe?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo@ DB 0aH
	DB	00H, 'C', 00H, 'a', 00H, 'n', 00H, '''', 00H, 't', 00H, ' ', 00H
	DB	'd', 00H, 'e', 00H, 'l', 00H, 'e', 00H, 't', 00H, 'e', 00H, ' '
	DB	00H, 's', 00H, 'e', 00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, ' ', 00H, '''', 00H, '%', 00H, 's', 00H, '''', 00H, '.'
	DB	00H, ' ', 00H, 'E', 00H, 'r', 00H, 'r', 00H, 'o', 00H, 'r', 00H
	DB	'C', 00H, 'o', 00H, 'd', 00H, 'e', 00H, '=', 00H, '0', 00H, 'x'
	DB	00H, '%', 00H, '0', 00H, 'X', 00H, '.', 00H, 00H, 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_1CM@BNAEJNDE@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAd?$AAe?$AAl?$AAe?$AAt?$AAe?$AAd?$AA?$AA@
CONST	SEGMENT
??_C@_1CM@BNAEJNDE@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAd?$AAe?$AAl?$AAe?$AAt?$AAe?$AAd?$AA?$AA@ DB 0aH
	DB	00H, 'S', 00H, 'e', 00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, ' ', 00H, '''', 00H, '%', 00H, 's', 00H, '''', 00H, ' '
	DB	00H, 'd', 00H, 'e', 00H, 'l', 00H, 'e', 00H, 't', 00H, 'e', 00H
	DB	'd', 00H, 00H, 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_1FG@OPEJBFDE@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAs?$AAt?$AAo?$AAp?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC@
CONST	SEGMENT
??_C@_1FG@OPEJBFDE@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAs?$AAt?$AAo?$AAp?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC@ DB 0aH
	DB	00H, 'C', 00H, 'a', 00H, 'n', 00H, '''', 00H, 't', 00H, ' ', 00H
	DB	's', 00H, 't', 00H, 'o', 00H, 'p', 00H, ' ', 00H, 's', 00H, 'e'
	DB	00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H, 'e', 00H, ' ', 00H
	DB	'''', 00H, '%', 00H, 's', 00H, '''', 00H, '.', 00H, ' ', 00H, 'E'
	DB	00H, 'r', 00H, 'r', 00H, 'o', 00H, 'r', 00H, 'C', 00H, 'o', 00H
	DB	'd', 00H, 'e', 00H, '=', 00H, '0', 00H, 'x', 00H, '%', 00H, '0'
	DB	00H, 'X', 00H, '.', 00H, 00H, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_1CM@MPDEBAGD@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAs?$AAt?$AAo?$AAp?$AAp?$AAe?$AAd?$AA?$AA@
CONST	SEGMENT
??_C@_1CM@MPDEBAGD@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAs?$AAt?$AAo?$AAp?$AAp?$AAe?$AAd?$AA?$AA@ DB 0aH
	DB	00H, 'S', 00H, 'e', 00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, ' ', 00H, '''', 00H, '%', 00H, 's', 00H, '''', 00H, ' '
	DB	00H, 's', 00H, 't', 00H, 'o', 00H, 'p', 00H, 'p', 00H, 'e', 00H
	DB	'd', 00H, 00H, 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_1EI@KGLDCLGB@?$AA?6?$AAR?$AAe?$AAa?$AAd?$AAF?$AAi?$AAl?$AAe?$AA?5?$AAf?$AAa?$AAi?$AAl?$AAe?$AAd?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC?$AAo?$AAd?$AAe?$AA?$DN?$AA0?$AAx?$AA?$CF?$AA0@
CONST	SEGMENT
??_C@_1EI@KGLDCLGB@?$AA?6?$AAR?$AAe?$AAa?$AAd?$AAF?$AAi?$AAl?$AAe?$AA?5?$AAf?$AAa?$AAi?$AAl?$AAe?$AAd?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC?$AAo?$AAd?$AAe?$AA?$DN?$AA0?$AAx?$AA?$CF?$AA0@ DB 0aH
	DB	00H, 'R', 00H, 'e', 00H, 'a', 00H, 'd', 00H, 'F', 00H, 'i', 00H
	DB	'l', 00H, 'e', 00H, ' ', 00H, 'f', 00H, 'a', 00H, 'i', 00H, 'l'
	DB	00H, 'e', 00H, 'd', 00H, '.', 00H, ' ', 00H, 'E', 00H, 'r', 00H
	DB	'r', 00H, 'o', 00H, 'r', 00H, 'C', 00H, 'o', 00H, 'd', 00H, 'e'
	DB	00H, '=', 00H, '0', 00H, 'x', 00H, '%', 00H, '0', 00H, '8', 00H
	DB	'X', 00H, '.', 00H, 00H, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_0BO@HGGFGIPK@?6ReadFile?5return?5?$CFd?5bytes?3?6?$CFs?$AA@
CONST	SEGMENT
??_C@_0BO@HGGFGIPK@?6ReadFile?5return?5?$CFd?5bytes?3?6?$CFs?$AA@ DB 0aH, 'R'
	DB	'eadFile return %d bytes:', 0aH, '%s', 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_1EK@NOMAPGLJ@?$AAW?$AAr?$AAi?$AAt?$AAe?$AAF?$AAi?$AAl?$AAe?$AA?5?$AAf?$AAa?$AAi?$AAl?$AAe?$AAd?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC?$AAo?$AAd?$AAe?$AA?$DN?$AA0?$AAx?$AA?$CF?$AA0@
CONST	SEGMENT
??_C@_1EK@NOMAPGLJ@?$AAW?$AAr?$AAi?$AAt?$AAe?$AAF?$AAi?$AAl?$AAe?$AA?5?$AAf?$AAa?$AAi?$AAl?$AAe?$AAd?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC?$AAo?$AAd?$AAe?$AA?$DN?$AA0?$AAx?$AA?$CF?$AA0@ DB 'W'
	DB	00H, 'r', 00H, 'i', 00H, 't', 00H, 'e', 00H, 'F', 00H, 'i', 00H
	DB	'l', 00H, 'e', 00H, ' ', 00H, 'f', 00H, 'a', 00H, 'i', 00H, 'l'
	DB	00H, 'e', 00H, 'd', 00H, '.', 00H, ' ', 00H, 'E', 00H, 'r', 00H
	DB	'r', 00H, 'o', 00H, 'r', 00H, 'C', 00H, 'o', 00H, 'd', 00H, 'e'
	DB	00H, '=', 00H, '0', 00H, 'x', 00H, '%', 00H, '0', 00H, '8', 00H
	DB	'X', 00H, '.', 00H, 0aH, 00H, 00H, 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_1CE@OFCHIDMD@?$AA?$CF?$AAd?$AA?5?$AAb?$AAy?$AAt?$AAe?$AAs?$AA?5?$AAw?$AAr?$AAi?$AAt?$AAt?$AAe?$AAn?$AA?6?$AA?$AA@
CONST	SEGMENT
??_C@_1CE@OFCHIDMD@?$AA?$CF?$AAd?$AA?5?$AAb?$AAy?$AAt?$AAe?$AAs?$AA?5?$AAw?$AAr?$AAi?$AAt?$AAt?$AAe?$AAn?$AA?6?$AA?$AA@ DB '%'
	DB	00H, 'd', 00H, ' ', 00H, 'b', 00H, 'y', 00H, 't', 00H, 'e', 00H
	DB	's', 00H, ' ', 00H, 'w', 00H, 'r', 00H, 'i', 00H, 't', 00H, 't'
	DB	00H, 'e', 00H, 'n', 00H, 0aH, 00H, 00H, 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_02DKCKIIND@?$CFs?$AA@
CONST	SEGMENT
??_C@_02DKCKIIND@?$CFs?$AA@ DB '%s', 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_1IG@JPPLKEBH@?$AA?6?$AAT?$AAy?$AAp?$AAe?$AA?5?$AAa?$AA?5?$AAf?$AAe?$AAw?$AA?5?$AAl?$AAi?$AAn?$AAe?$AAs?$AA?5?$AAa?$AAn?$AAd?$AA?5?$AAt?$AAh?$AAe?$AAn?$AA?5?$AAp?$AAr?$AAe?$AAs?$AAs@
CONST	SEGMENT
??_C@_1IG@JPPLKEBH@?$AA?6?$AAT?$AAy?$AAp?$AAe?$AA?5?$AAa?$AA?5?$AAf?$AAe?$AAw?$AA?5?$AAl?$AAi?$AAn?$AAe?$AAs?$AA?5?$AAa?$AAn?$AAd?$AA?5?$AAt?$AAh?$AAe?$AAn?$AA?5?$AAp?$AAr?$AAe?$AAs?$AAs@ DB 0aH
	DB	00H, 'T', 00H, 'y', 00H, 'p', 00H, 'e', 00H, ' ', 00H, 'a', 00H
	DB	' ', 00H, 'f', 00H, 'e', 00H, 'w', 00H, ' ', 00H, 'l', 00H, 'i'
	DB	00H, 'n', 00H, 'e', 00H, 's', 00H, ' ', 00H, 'a', 00H, 'n', 00H
	DB	'd', 00H, ' ', 00H, 't', 00H, 'h', 00H, 'e', 00H, 'n', 00H, ' '
	DB	00H, 'p', 00H, 'r', 00H, 'e', 00H, 's', 00H, 's', 00H, ' ', 00H
	DB	'''', 00H, 'C', 00H, 't', 00H, 'r', 00H, 'l', 00H, '-', 00H, 'Z'
	DB	00H, '''', 00H, ' ', 00H, 'a', 00H, 'n', 00H, 'd', 00H, ' ', 00H
	DB	'''', 00H, 'E', 00H, 'n', 00H, 't', 00H, 'e', 00H, 'r', 00H, ''''
	DB	00H, ' ', 00H, 't', 00H, 'o', 00H, ' ', 00H, 'c', 00H, 'o', 00H
	DB	'm', 00H, 'p', 00H, 'l', 00H, 'e', 00H, 't', 00H, 'e', 00H, 0aH
	DB	00H, 00H, 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_1GC@JLKGGLBO@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAs?$AAy?$AAm?$AAb?$AAo?$AAl?$AAi?$AAk?$AA?5?$AAl?$AAi?$AAn?$AAk?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5@
CONST	SEGMENT
??_C@_1GC@JLKGGLBO@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAs?$AAy?$AAm?$AAb?$AAo?$AAl?$AAi?$AAk?$AA?5?$AAl?$AAi?$AAn?$AAk?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5@ DB 0aH
	DB	00H, 'C', 00H, 'a', 00H, 'n', 00H, '''', 00H, 't', 00H, ' ', 00H
	DB	'o', 00H, 'p', 00H, 'e', 00H, 'n', 00H, ' ', 00H, 's', 00H, 'y'
	DB	00H, 'm', 00H, 'b', 00H, 'o', 00H, 'l', 00H, 'i', 00H, 'k', 00H
	DB	' ', 00H, 'l', 00H, 'i', 00H, 'n', 00H, 'k', 00H, ' ', 00H, ''''
	DB	00H, '%', 00H, 's', 00H, '''', 00H, '.', 00H, ' ', 00H, 'E', 00H
	DB	'r', 00H, 'r', 00H, 'o', 00H, 'r', 00H, 'C', 00H, 'o', 00H, 'd'
	DB	00H, 'e', 00H, '=', 00H, '0', 00H, 'x', 00H, '%', 00H, '0', 00H
	DB	'X', 00H, '.', 00H, 00H, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_1FK@LMKNJGB@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAs?$AAt?$AAa?$AAr?$AAt?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr@
CONST	SEGMENT
??_C@_1FK@LMKNJGB@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAs?$AAt?$AAa?$AAr?$AAt?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr@ DB 0aH
	DB	00H, 'C', 00H, 'a', 00H, 'n', 00H, '''', 00H, 't', 00H, ' ', 00H
	DB	's', 00H, 't', 00H, 'a', 00H, 'r', 00H, 't', 00H, ' ', 00H, 's'
	DB	00H, 'e', 00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H, 'e', 00H
	DB	' ', 00H, '''', 00H, '%', 00H, 's', 00H, '''', 00H, '.', 00H, ' '
	DB	00H, 'E', 00H, 'r', 00H, 'r', 00H, 'o', 00H, 'r', 00H, 'C', 00H
	DB	'o', 00H, 'd', 00H, 'e', 00H, '=', 00H, '0', 00H, 'x', 00H, '%'
	DB	00H, '0', 00H, '8', 00H, 'X', 00H, '.', 00H, 00H, 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_1DM@EGBCKHGG@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAa?$AAl?$AAr?$AAe?$AAa?$AAd?$AAy?$AA?5?$AAr?$AAu?$AAn?$AAn?$AAi?$AAn?$AAg?$AA?$AA@
CONST	SEGMENT
??_C@_1DM@EGBCKHGG@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAa?$AAl?$AAr?$AAe?$AAa?$AAd?$AAy?$AA?5?$AAr?$AAu?$AAn?$AAn?$AAi?$AAn?$AAg?$AA?$AA@ DB 0aH
	DB	00H, 'S', 00H, 'e', 00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, ' ', 00H, '''', 00H, '%', 00H, 's', 00H, '''', 00H, ' '
	DB	00H, 'a', 00H, 'l', 00H, 'r', 00H, 'e', 00H, 'a', 00H, 'd', 00H
	DB	'y', 00H, ' ', 00H, 'r', 00H, 'u', 00H, 'n', 00H, 'n', 00H, 'i'
	DB	00H, 'n', 00H, 'g', 00H, 00H, 00H		; `string'
CONST	ENDS
;	COMDAT ??_C@_1CM@KGLKBNLK@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAs?$AAt?$AAa?$AAr?$AAt?$AAe?$AAd?$AA?$AA@
CONST	SEGMENT
??_C@_1CM@KGLKBNLK@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAs?$AAt?$AAa?$AAr?$AAt?$AAe?$AAd?$AA?$AA@ DB 0aH
	DB	00H, 'S', 00H, 'e', 00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, ' ', 00H, '''', 00H, '%', 00H, 's', 00H, '''', 00H, ' '
	DB	00H, 's', 00H, 't', 00H, 'a', 00H, 'r', 00H, 't', 00H, 'e', 00H
	DB	'd', 00H, 00H, 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_1FK@KJAADAND@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAc?$AAr?$AAe?$AAa?$AAt?$AAe?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo@
CONST	SEGMENT
??_C@_1FK@KJAADAND@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAc?$AAr?$AAe?$AAa?$AAt?$AAe?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo@ DB 0aH
	DB	00H, 'C', 00H, 'a', 00H, 'n', 00H, '''', 00H, 't', 00H, ' ', 00H
	DB	'c', 00H, 'r', 00H, 'e', 00H, 'a', 00H, 't', 00H, 'e', 00H, ' '
	DB	00H, 's', 00H, 'e', 00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, ' ', 00H, '''', 00H, '%', 00H, 's', 00H, '''', 00H, '.'
	DB	00H, ' ', 00H, 'E', 00H, 'r', 00H, 'r', 00H, 'o', 00H, 'r', 00H
	DB	'C', 00H, 'o', 00H, 'd', 00H, 'e', 00H, '=', 00H, '0', 00H, 'x'
	DB	00H, '%', 00H, '0', 00H, 'X', 00H, '.', 00H, 00H, 00H ; `string'
CONST	ENDS
;	COMDAT ??_C@_1CM@HHMAGJAG@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAc?$AAr?$AAe?$AAa?$AAt?$AAe?$AAd?$AA?$AA@
CONST	SEGMENT
??_C@_1CM@HHMAGJAG@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAc?$AAr?$AAe?$AAa?$AAt?$AAe?$AAd?$AA?$AA@ DB 0aH
	DB	00H, 'S', 00H, 'e', 00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H
	DB	'e', 00H, ' ', 00H, '''', 00H, '%', 00H, 's', 00H, '''', 00H, ' '
	DB	00H, 'c', 00H, 'r', 00H, 'e', 00H, 'a', 00H, 't', 00H, 'e', 00H
	DB	'd', 00H, 00H, 00H				; `string'
CONST	ENDS
;	COMDAT ??_C@_1HM@PAMANCBH@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAg?$AAe?$AAt?$AA?5?$AAf?$AAu?$AAl?$AAl?$AA?5?$AAp?$AAa?$AAt?$AAh?$AA?5?$AAf?$AAo?$AAr?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe@
CONST	SEGMENT
??_C@_1HM@PAMANCBH@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAg?$AAe?$AAt?$AA?5?$AAf?$AAu?$AAl?$AAl?$AA?5?$AAp?$AAa?$AAt?$AAh?$AA?5?$AAf?$AAo?$AAr?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe@ DB 0aH
	DB	00H, 'C', 00H, 'a', 00H, 'n', 00H, '''', 00H, 't', 00H, ' ', 00H
	DB	'g', 00H, 'e', 00H, 't', 00H, ' ', 00H, 'f', 00H, 'u', 00H, 'l'
	DB	00H, 'l', 00H, ' ', 00H, 'p', 00H, 'a', 00H, 't', 00H, 'h', 00H
	DB	' ', 00H, 'f', 00H, 'o', 00H, 'r', 00H, ' ', 00H, 's', 00H, 'e'
	DB	00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H, 'e', 00H, ' ', 00H
	DB	'i', 00H, 'm', 00H, 'a', 00H, 'g', 00H, 'e', 00H, ' ', 00H, ''''
	DB	00H, '%', 00H, 's', 00H, '''', 00H, '.', 00H, ' ', 00H, 'E', 00H
	DB	'r', 00H, 'r', 00H, 'o', 00H, 'r', 00H, 'C', 00H, 'o', 00H, 'd'
	DB	00H, 'e', 00H, '=', 00H, '0', 00H, 'x', 00H, '%', 00H, '0', 00H
	DB	'X', 00H, '.', 00H, 00H, 00H			; `string'
CONST	ENDS
;	COMDAT ??_C@_1HC@PGADEBGC@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC@
CONST	SEGMENT
??_C@_1HC@PGADEBGC@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC@ DB 0aH
	DB	00H, 'C', 00H, 'a', 00H, 'n', 00H, '''', 00H, 't', 00H, ' ', 00H
	DB	'o', 00H, 'p', 00H, 'e', 00H, 'n', 00H, ' ', 00H, 's', 00H, 'e'
	DB	00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H, 'e', 00H, ' ', 00H
	DB	'''', 00H, '%', 00H, 's', 00H, '''', 00H, '.', 00H, ' ', 00H, 'E'
	DB	00H, 'r', 00H, 'r', 00H, 'o', 00H, 'r', 00H, 'C', 00H, 'o', 00H
	DB	'd', 00H, 'e', 00H, '=', 00H, '0', 00H, 'x', 00H, '%', 00H, '0'
	DB	00H, 'X', 00H, '.', 00H, 0aH, 00H, 'T', 00H, 'r', 00H, 'y', 00H
	DB	' ', 00H, 'c', 00H, 'r', 00H, 'e', 00H, 'a', 00H, 't', 00H, 'e'
	DB	00H, '.', 00H, '.', 00H, '.', 00H, 00H, 00H	; `string'
CONST	ENDS
;	COMDAT ??_C@_1GK@IGFMAFKG@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AAC?$AAo?$AAn?$AAt?$AAr?$AAo?$AAl?$AA?5?$AAM?$AAa?$AAn?$AAa@
CONST	SEGMENT
??_C@_1GK@IGFMAFKG@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AAC?$AAo?$AAn?$AAt?$AAr?$AAo?$AAl?$AA?5?$AAM?$AAa?$AAn?$AAa@ DB 0aH
	DB	00H, 'C', 00H, 'a', 00H, 'n', 00H, '''', 00H, 't', 00H, ' ', 00H
	DB	'o', 00H, 'p', 00H, 'e', 00H, 'n', 00H, ' ', 00H, 'S', 00H, 'e'
	DB	00H, 'r', 00H, 'v', 00H, 'i', 00H, 'c', 00H, 'e', 00H, ' ', 00H
	DB	'C', 00H, 'o', 00H, 'n', 00H, 't', 00H, 'r', 00H, 'o', 00H, 'l'
	DB	00H, ' ', 00H, 'M', 00H, 'a', 00H, 'n', 00H, 'a', 00H, 'g', 00H
	DB	'e', 00H, 'r', 00H, '.', 00H, ' ', 00H, 'E', 00H, 'r', 00H, 'r'
	DB	00H, 'o', 00H, 'r', 00H, 'C', 00H, 'o', 00H, 'd', 00H, 'e', 00H
	DB	'=', 00H, '0', 00H, 'x', 00H, '%', 00H, '0', 00H, 'X', 00H, 00H
	DB	00H						; `string'
CONST	ENDS
;	COMDAT ??_C@_1DM@LIBBDIJD@?$AE?$BP?$AE?$EA?$AE?$DO?$AE3?$AE?$EA?$AE0?$AE?$DM?$AE0?$AA?5?$AEC?$AE?$DP?$AE?$EA?$AE0?$AE2?$AE?$DL?$AEV?$AE?$DN?$AE?$DN?$AEO?$AA?5?$AE4?$AE?$EA?$AE0?$AE9?$AE2?$AE5?$AE?$EA?$AE?$DO?$AE?$DM?$AA?$AA@
CONST	SEGMENT
??_C@_1DM@LIBBDIJD@?$AE?$BP?$AE?$EA?$AE?$DO?$AE3?$AE?$EA?$AE0?$AE?$DM?$AE0?$AA?5?$AEC?$AE?$DP?$AE?$EA?$AE0?$AE2?$AE?$DL?$AEV?$AE?$DN?$AE?$DN?$AEO?$AA?5?$AE4?$AE?$EA?$AE0?$AE9?$AE2?$AE5?$AE?$EA?$AE?$DO?$AE?$DM?$AA?$AA@ DB 01fH
	DB	04H, '@', 04H, '>', 04H, '3', 04H, '@', 04H, '0', 04H, '<', 04H
	DB	'0', 04H, ' ', 00H, 'C', 04H, '?', 04H, '@', 04H, '0', 04H, '2'
	DB	04H, ';', 04H, 'V', 04H, '=', 04H, '=', 04H, 'O', 04H, ' ', 00H
	DB	'4', 04H, '@', 04H, '0', 04H, '9', 04H, '2', 04H, '5', 04H, '@'
	DB	04H, '>', 04H, '<', 04H, 00H, 00H		; `string'
; Function compile flags: /Odtp
CONST	ENDS
;	COMDAT _wmain
_TEXT	SEGMENT
_statusBefore$ = -1616					; size = 4
_lastError$ = -1612					; size = 4
_serviceStatus$ = -1608					; size = 28
_counterBytes$ = -1580					; size = 4
_scm$ = -1576						; size = 4
_service$ = -1572					; size = 4
_outputBuffer$ = -1568					; size = 256
_device$ = -1308					; size = 4
_fullImagePath$ = -1304					; size = 1040
_inputBuffer$ = -264					; size = 256
__$ArrayPad$ = -4					; size = 4
_wmain	PROC						; COMDAT

; 4    : {

	npad	2
	push	ebp
	mov	ebp, esp
	sub	esp, 1616				; 00000650H
	mov	eax, DWORD PTR ___security_cookie
	xor	eax, ebp
	mov	DWORD PTR __$ArrayPad$[ebp], eax

; 5    : 	HANDLE				scm = NULL;

	mov	DWORD PTR _scm$[ebp], 0

; 6    : 	HANDLE				service = NULL;

	mov	DWORD PTR _service$[ebp], 0

; 7    : 	HANDLE				device = INVALID_HANDLE_VALUE;

	mov	DWORD PTR _device$[ebp], -1

; 8    : 	DWORD				counterBytes = 0;

	mov	DWORD PTR _counterBytes$[ebp], 0

; 9    : 	DWORD				lastError = ERROR_SUCCESS;

	mov	DWORD PTR _lastError$[ebp], 0

; 10   : 	DWORD				statusBefore = SERVICE_NOT_INSTALLED;

	mov	DWORD PTR _statusBefore$[ebp], 0

; 11   : 	TCHAR				fullImagePath[2*MAX_PATH] = {0};

	xor	eax, eax
	mov	WORD PTR _fullImagePath$[ebp], ax
	push	1038					; 0000040eH
	push	0
	lea	ecx, DWORD PTR _fullImagePath$[ebp+2]
	push	ecx
	call	_memset
	add	esp, 12					; 0000000cH

; 12   : 	SERVICE_STATUS		serviceStatus = {0};

	mov	DWORD PTR _serviceStatus$[ebp], 0
	xor	edx, edx
	mov	DWORD PTR _serviceStatus$[ebp+4], edx
	mov	DWORD PTR _serviceStatus$[ebp+8], edx
	mov	DWORD PTR _serviceStatus$[ebp+12], edx
	mov	DWORD PTR _serviceStatus$[ebp+16], edx
	mov	DWORD PTR _serviceStatus$[ebp+20], edx
	mov	DWORD PTR _serviceStatus$[ebp+24], edx

; 13   : 	CHAR				inputBuffer[IN_BUFFER_SIZE]		= {0};	// ��� ��������

	mov	BYTE PTR _inputBuffer$[ebp], 0
	push	255					; 000000ffH
	push	0
	lea	eax, DWORD PTR _inputBuffer$[ebp+1]
	push	eax
	call	_memset
	add	esp, 12					; 0000000cH

; 14   : 	CHAR				outputBuffer[OUT_BUFFER_SIZE]	= {0};	// �� ��������

	mov	BYTE PTR _outputBuffer$[ebp], 0
	push	255					; 000000ffH
	push	0
	lea	ecx, DWORD PTR _outputBuffer$[ebp+1]
	push	ecx
	call	_memset
	add	esp, 12					; 0000000cH

; 15   : 	
; 16   : 	SetConsoleTitle(_TEXT("�������� ��������� ���������"));

	push	OFFSET ??_C@_1DM@LIBBDIJD@?$AE?$BP?$AE?$EA?$AE?$DO?$AE3?$AE?$EA?$AE0?$AE?$DM?$AE0?$AA?5?$AEC?$AE?$DP?$AE?$EA?$AE0?$AE2?$AE?$DL?$AEV?$AE?$DN?$AE?$DN?$AEO?$AA?5?$AE4?$AE?$EA?$AE0?$AE9?$AE2?$AE5?$AE?$EA?$AE?$DO?$AE?$DM?$AA?$AA@
	call	DWORD PTR __imp__SetConsoleTitleW@4

; 17   : 	scm = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);

	push	983103					; 000f003fH
	push	0
	push	0
	call	DWORD PTR __imp__OpenSCManagerW@12
	mov	DWORD PTR _scm$[ebp], eax

; 18   : 	if(!scm)

	cmp	DWORD PTR _scm$[ebp], 0
	jne	SHORT $LN29@wmain

; 19   : 	{
; 20   : 		lastError = GetLastError();

	call	DWORD PTR __imp__GetLastError@0
	mov	DWORD PTR _lastError$[ebp], eax

; 21   : 		_tprintf(_TEXT("\nCan't open Service Control Manager. ErrorCode=0x%0X"), lastError);

	mov	edx, DWORD PTR _lastError$[ebp]
	push	edx
	push	OFFSET ??_C@_1GK@IGFMAFKG@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AAC?$AAo?$AAn?$AAt?$AAr?$AAo?$AAl?$AA?5?$AAM?$AAa?$AAn?$AAa@
	call	DWORD PTR __imp__wprintf
	add	esp, 8

; 22   : 		return lastError;

	mov	eax, DWORD PTR _lastError$[ebp]
	jmp	$LN30@wmain
$LN29@wmain:

; 23   : 	}
; 24   : 
; 25   : 	service = OpenService(scm, serviceName,	SERVICE_START + SERVICE_STOP);

	push	48					; 00000030H
	push	OFFSET _serviceName
	mov	eax, DWORD PTR _scm$[ebp]
	push	eax
	call	DWORD PTR __imp__OpenServiceW@12
	mov	DWORD PTR _service$[ebp], eax

; 26   : 	if(service)

	cmp	DWORD PTR _service$[ebp], 0
	je	SHORT $LN28@wmain

; 27   : 	{
; 28   : 		statusBefore |= SERVICE_OPENED;

	mov	ecx, DWORD PTR _statusBefore$[ebp]
	or	ecx, 8
	mov	DWORD PTR _statusBefore$[ebp], ecx

; 29   : 	}
; 30   : 	else

	jmp	$LN27@wmain
$LN28@wmain:

; 31   : 	{
; 32   : 		_tprintf(_TEXT("\nCan't open service '%s'. ErrorCode=0x%0X.\nTry create..."), serviceName, GetLastError());

	call	DWORD PTR __imp__GetLastError@0
	push	eax
	push	OFFSET _serviceName
	push	OFFSET ??_C@_1HC@PGADEBGC@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC@
	call	DWORD PTR __imp__wprintf
	add	esp, 12					; 0000000cH

; 33   : 		counterBytes = GetFullPathName(
; 34   : 								imageName,
; 35   : 								sizeof (fullImagePath)/sizeof(TCHAR), 
; 36   : 								fullImagePath, 
; 37   : 								NULL);

	push	0
	lea	edx, DWORD PTR _fullImagePath$[ebp]
	push	edx
	push	520					; 00000208H
	push	OFFSET _imageName
	call	DWORD PTR __imp__GetFullPathNameW@16
	mov	DWORD PTR _counterBytes$[ebp], eax

; 38   : 		if(counterBytes == 0 || counterBytes > sizeof (fullImagePath)/sizeof(TCHAR))

	cmp	DWORD PTR _counterBytes$[ebp], 0
	je	SHORT $LN25@wmain
	cmp	DWORD PTR _counterBytes$[ebp], 520	; 00000208H
	jbe	SHORT $LN26@wmain
$LN25@wmain:

; 39   : 		{
; 40   : 			lastError = GetLastError();

	call	DWORD PTR __imp__GetLastError@0
	mov	DWORD PTR _lastError$[ebp], eax

; 41   : 			_tprintf(_TEXT("\nCan't get full path for service image '%s'. ErrorCode=0x%0X."), 
; 42   : 						imageName, lastError);

	mov	eax, DWORD PTR _lastError$[ebp]
	push	eax
	push	OFFSET _imageName
	push	OFFSET ??_C@_1HM@PAMANCBH@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAg?$AAe?$AAt?$AA?5?$AAf?$AAu?$AAl?$AAl?$AA?5?$AAp?$AAa?$AAt?$AAh?$AA?5?$AAf?$AAo?$AAr?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe@
	call	DWORD PTR __imp__wprintf
	add	esp, 12					; 0000000cH

; 43   : 		}
; 44   : 		else

	jmp	$LN27@wmain
$LN26@wmain:

; 45   : 		{
; 46   : 			service = CreateService(
; 47   : 							scm,
; 48   : 							serviceName,
; 49   : 							serviceName,
; 50   : 							SERVICE_START + SERVICE_STOP + DELETE,
; 51   : 							SERVICE_KERNEL_DRIVER,
; 52   : 							SERVICE_DEMAND_START,
; 53   : 							SERVICE_ERROR_IGNORE,
; 54   : 							fullImagePath,
; 55   : 							NULL, NULL, NULL, NULL, NULL);

	push	0
	push	0
	push	0
	push	0
	push	0
	lea	ecx, DWORD PTR _fullImagePath$[ebp]
	push	ecx
	push	0
	push	3
	push	1
	push	65584					; 00010030H
	push	OFFSET _serviceName
	push	OFFSET _serviceName
	mov	edx, DWORD PTR _scm$[ebp]
	push	edx
	call	DWORD PTR __imp__CreateServiceW@52
	mov	DWORD PTR _service$[ebp], eax

; 56   : 			if(service)

	cmp	DWORD PTR _service$[ebp], 0
	je	SHORT $LN23@wmain

; 57   : 			{
; 58   : 				statusBefore |= SERVICE_INSTALLED;

	mov	eax, DWORD PTR _statusBefore$[ebp]
	or	eax, 1
	mov	DWORD PTR _statusBefore$[ebp], eax

; 59   : 				_tprintf(_TEXT("\nService '%s' created"), serviceName);

	push	OFFSET _serviceName
	push	OFFSET ??_C@_1CM@HHMAGJAG@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAc?$AAr?$AAe?$AAa?$AAt?$AAe?$AAd?$AA?$AA@
	call	DWORD PTR __imp__wprintf
	add	esp, 8

; 60   : 			}
; 61   : 			else

	jmp	SHORT $LN27@wmain
$LN23@wmain:

; 62   : 			{
; 63   : 				lastError = GetLastError();

	call	DWORD PTR __imp__GetLastError@0
	mov	DWORD PTR _lastError$[ebp], eax

; 64   : 				_tprintf(_TEXT("\nCan't create service '%s'. ErrorCode=0x%0X."),
; 65   : 						 serviceName, lastError);

	mov	ecx, DWORD PTR _lastError$[ebp]
	push	ecx
	push	OFFSET _serviceName
	push	OFFSET ??_C@_1FK@KJAADAND@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAc?$AAr?$AAe?$AAa?$AAt?$AAe?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo@
	call	DWORD PTR __imp__wprintf
	add	esp, 12					; 0000000cH
$LN27@wmain:

; 66   : 			}
; 67   : 		}
; 68   : 	}
; 69   : 
; 70   : 	if(service)

	cmp	DWORD PTR _service$[ebp], 0
	je	$LN21@wmain

; 71   : 	{
; 72   : 		if( StartService(service, 0, NULL) )

	push	0
	push	0
	mov	edx, DWORD PTR _service$[ebp]
	push	edx
	call	DWORD PTR __imp__StartServiceW@12
	test	eax, eax
	je	SHORT $LN20@wmain

; 73   : 		{
; 74   : 			statusBefore |= SERVICE_STARTED;

	mov	eax, DWORD PTR _statusBefore$[ebp]
	or	eax, 2
	mov	DWORD PTR _statusBefore$[ebp], eax

; 75   : 			_tprintf(_TEXT("\nService '%s' started"), serviceName);

	push	OFFSET _serviceName
	push	OFFSET ??_C@_1CM@KGLKBNLK@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAs?$AAt?$AAa?$AAr?$AAt?$AAe?$AAd?$AA?$AA@
	call	DWORD PTR __imp__wprintf
	add	esp, 8

; 76   : 		}
; 77   : 		else

	jmp	SHORT $LN19@wmain
$LN20@wmain:

; 78   : 		{
; 79   : 			lastError = GetLastError();

	call	DWORD PTR __imp__GetLastError@0
	mov	DWORD PTR _lastError$[ebp], eax

; 80   : 			if(ERROR_SERVICE_ALREADY_RUNNING == lastError)

	cmp	DWORD PTR _lastError$[ebp], 1056	; 00000420H
	jne	SHORT $LN18@wmain

; 81   : 			{
; 82   : 				_tprintf(_TEXT("\nService '%s' already running"), serviceName);

	push	OFFSET _serviceName
	push	OFFSET ??_C@_1DM@EGBCKHGG@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAa?$AAl?$AAr?$AAe?$AAa?$AAd?$AAy?$AA?5?$AAr?$AAu?$AAn?$AAn?$AAi?$AAn?$AAg?$AA?$AA@
	call	DWORD PTR __imp__wprintf
	add	esp, 8

; 83   : 				statusBefore |= SERVICE_RUNNING;

	mov	ecx, DWORD PTR _statusBefore$[ebp]
	or	ecx, 4
	mov	DWORD PTR _statusBefore$[ebp], ecx

; 84   : 			}
; 85   : 			else

	jmp	SHORT $LN19@wmain
$LN18@wmain:

; 86   : 			{
; 87   : 				_tprintf(_TEXT("\nCan't start service '%s'. ErrorCode=0x%08X."),
; 88   : 							serviceName, lastError);

	mov	edx, DWORD PTR _lastError$[ebp]
	push	edx
	push	OFFSET _serviceName
	push	OFFSET ??_C@_1FK@LMKNJGB@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAs?$AAt?$AAa?$AAr?$AAt?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr@
	call	DWORD PTR __imp__wprintf
	add	esp, 12					; 0000000cH
$LN19@wmain:

; 89   : 			}
; 90   : 		}
; 91   : 		
; 92   : 		if( (statusBefore & SERVICE_STARTED) || (statusBefore & SERVICE_RUNNING) )

	mov	eax, DWORD PTR _statusBefore$[ebp]
	and	eax, 2
	jne	SHORT $LN15@wmain
	mov	ecx, DWORD PTR _statusBefore$[ebp]
	and	ecx, 4
	je	$LN21@wmain
$LN15@wmain:

; 93   : 		{
; 94   : 			device = CreateFile(
; 95   : 						symbolicLinkName,
; 96   : 						GENERIC_READ + GENERIC_WRITE, 0, NULL,
; 97   : 						OPEN_EXISTING, 0, NULL);

	push	0
	push	0
	push	3
	push	0
	push	0
	push	-1073741824				; c0000000H
	push	OFFSET _symbolicLinkName
	call	DWORD PTR __imp__CreateFileW@28
	mov	DWORD PTR _device$[ebp], eax

; 98   : 			
; 99   : 			if(INVALID_HANDLE_VALUE == device)

	cmp	DWORD PTR _device$[ebp], -1
	jne	SHORT $LN14@wmain

; 100  : 			{
; 101  : 				lastError = GetLastError();

	call	DWORD PTR __imp__GetLastError@0
	mov	DWORD PTR _lastError$[ebp], eax

; 102  : 				_tprintf(_TEXT("\nCan't open symbolik link '%s'. ErrorCode=0x%0X."),
; 103  : 							symbolicLinkName, lastError);

	mov	edx, DWORD PTR _lastError$[ebp]
	push	edx
	push	OFFSET _symbolicLinkName
	push	OFFSET ??_C@_1GC@JLKGGLBO@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAo?$AAp?$AAe?$AAn?$AA?5?$AAs?$AAy?$AAm?$AAb?$AAo?$AAl?$AAi?$AAk?$AA?5?$AAl?$AAi?$AAn?$AAk?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5@
	call	DWORD PTR __imp__wprintf
	add	esp, 12					; 0000000cH

; 104  : 			}
; 105  : 			else

	jmp	$LN21@wmain
$LN14@wmain:

; 106  : 			{
; 107  : 				__debugbreak();

	int	3

; 108  : 				_tprintf(_TEXT("\nType a few lines and then press 'Ctrl-Z' and 'Enter' to complete\n"));

	push	OFFSET ??_C@_1IG@JPPLKEBH@?$AA?6?$AAT?$AAy?$AAp?$AAe?$AA?5?$AAa?$AA?5?$AAf?$AAe?$AAw?$AA?5?$AAl?$AAi?$AAn?$AAe?$AAs?$AA?5?$AAa?$AAn?$AAd?$AA?5?$AAt?$AAh?$AAe?$AAn?$AA?5?$AAp?$AAr?$AAe?$AAs?$AAs@
	call	DWORD PTR __imp__wprintf
	add	esp, 4
$LN12@wmain:

; 109  : 				while ( EOF != scanf_s( "%s", &inputBuffer, sizeof(inputBuffer)-1 ))

	push	255					; 000000ffH
	lea	eax, DWORD PTR _inputBuffer$[ebp]
	push	eax
	push	OFFSET ??_C@_02DKCKIIND@?$CFs?$AA@
	call	_scanf_s
	add	esp, 12					; 0000000cH
	cmp	eax, -1
	je	SHORT $LN11@wmain

; 110  : 				{
; 111  : 					//&inputBuffer,strlen(inputBuffer)
; 112  : 					if( WriteFile(device, NULL, 0, &counterBytes, NULL) )

	push	0
	lea	ecx, DWORD PTR _counterBytes$[ebp]
	push	ecx
	push	0
	push	0
	mov	edx, DWORD PTR _device$[ebp]
	push	edx
	call	DWORD PTR __imp__WriteFile@20
	test	eax, eax
	je	SHORT $LN10@wmain

; 113  : 					{
; 114  : 						_tprintf(_TEXT("%d bytes written\n"), counterBytes);

	mov	eax, DWORD PTR _counterBytes$[ebp]
	push	eax
	push	OFFSET ??_C@_1CE@OFCHIDMD@?$AA?$CF?$AAd?$AA?5?$AAb?$AAy?$AAt?$AAe?$AAs?$AA?5?$AAw?$AAr?$AAi?$AAt?$AAt?$AAe?$AAn?$AA?6?$AA?$AA@
	call	DWORD PTR __imp__wprintf
	add	esp, 8

; 115  : 					}
; 116  : 					else

	jmp	SHORT $LN9@wmain
$LN10@wmain:

; 117  : 					{
; 118  : 						_tprintf(_TEXT("WriteFile failed. ErrorCode=0x%08X.\n"), GetLastError());	

	call	DWORD PTR __imp__GetLastError@0
	push	eax
	push	OFFSET ??_C@_1EK@NOMAPGLJ@?$AAW?$AAr?$AAi?$AAt?$AAe?$AAF?$AAi?$AAl?$AAe?$AA?5?$AAf?$AAa?$AAi?$AAl?$AAe?$AAd?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC?$AAo?$AAd?$AAe?$AA?$DN?$AA0?$AAx?$AA?$CF?$AA0@
	call	DWORD PTR __imp__wprintf
	add	esp, 8
$LN9@wmain:

; 119  : 					}
; 120  : 				} ;

	jmp	SHORT $LN12@wmain
$LN11@wmain:

; 121  : 				 
; 122  : 				if( ReadFile(device, &outputBuffer, sizeof(outputBuffer), &counterBytes, NULL) )

	push	0
	lea	ecx, DWORD PTR _counterBytes$[ebp]
	push	ecx
	push	256					; 00000100H
	lea	edx, DWORD PTR _outputBuffer$[ebp]
	push	edx
	mov	eax, DWORD PTR _device$[ebp]
	push	eax
	call	DWORD PTR __imp__ReadFile@20
	test	eax, eax
	je	SHORT $LN8@wmain

; 123  : 				{
; 124  : 					printf("\nReadFile return %d bytes:\n%s", counterBytes, outputBuffer);

	lea	ecx, DWORD PTR _outputBuffer$[ebp]
	push	ecx
	mov	edx, DWORD PTR _counterBytes$[ebp]
	push	edx
	push	OFFSET ??_C@_0BO@HGGFGIPK@?6ReadFile?5return?5?$CFd?5bytes?3?6?$CFs?$AA@
	call	DWORD PTR __imp__printf
	add	esp, 12					; 0000000cH

; 125  : 				}
; 126  : 				else

	jmp	SHORT $LN7@wmain
$LN8@wmain:

; 127  : 				{
; 128  : 					_tprintf(_TEXT("\nReadFile failed. ErrorCode=0x%08X."), GetLastError());	

	call	DWORD PTR __imp__GetLastError@0
	push	eax
	push	OFFSET ??_C@_1EI@KGLDCLGB@?$AA?6?$AAR?$AAe?$AAa?$AAd?$AAF?$AAi?$AAl?$AAe?$AA?5?$AAf?$AAa?$AAi?$AAl?$AAe?$AAd?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC?$AAo?$AAd?$AAe?$AA?$DN?$AA0?$AAx?$AA?$CF?$AA0@
	call	DWORD PTR __imp__wprintf
	add	esp, 8
$LN7@wmain:

; 129  : 				}
; 130  : 				CloseHandle(device);

	mov	eax, DWORD PTR _device$[ebp]
	push	eax
	call	DWORD PTR __imp__CloseHandle@4
$LN21@wmain:

; 131  : 			}
; 132  : 		}
; 133  : 	}
; 134  : 
; 135  : 	if(statusBefore & SERVICE_STARTED)

	mov	ecx, DWORD PTR _statusBefore$[ebp]
	and	ecx, 2
	je	SHORT $LN6@wmain

; 136  : 	{
; 137  : 		if(ControlService(service, SERVICE_CONTROL_STOP, &serviceStatus))

	lea	edx, DWORD PTR _serviceStatus$[ebp]
	push	edx
	push	1
	mov	eax, DWORD PTR _service$[ebp]
	push	eax
	call	DWORD PTR __imp__ControlService@12
	test	eax, eax
	je	SHORT $LN5@wmain

; 138  : 		{
; 139  : 			_tprintf(_TEXT("\nService '%s' stopped"), serviceName);

	push	OFFSET _serviceName
	push	OFFSET ??_C@_1CM@MPDEBAGD@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAs?$AAt?$AAo?$AAp?$AAp?$AAe?$AAd?$AA?$AA@
	call	DWORD PTR __imp__wprintf
	add	esp, 8

; 140  : 		}
; 141  : 		else

	jmp	SHORT $LN6@wmain
$LN5@wmain:

; 142  : 		{
; 143  : 			lastError = GetLastError();

	call	DWORD PTR __imp__GetLastError@0
	mov	DWORD PTR _lastError$[ebp], eax

; 144  : 			_tprintf(_TEXT("\nCan't stop service '%s'. ErrorCode=0x%0X."),
; 145  : 						 serviceName, lastError);

	mov	ecx, DWORD PTR _lastError$[ebp]
	push	ecx
	push	OFFSET _serviceName
	push	OFFSET ??_C@_1FG@OPEJBFDE@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAs?$AAt?$AAo?$AAp?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo?$AAr?$AAC@
	call	DWORD PTR __imp__wprintf
	add	esp, 12					; 0000000cH
$LN6@wmain:

; 146  : 		}
; 147  : 	}
; 148  : 	if( (statusBefore & SERVICE_INSTALLED) && (SERVICE_STOPPED == serviceStatus.dwCurrentState) )

	mov	edx, DWORD PTR _statusBefore$[ebp]
	and	edx, 1
	je	SHORT $LN3@wmain
	cmp	DWORD PTR _serviceStatus$[ebp+4], 1
	jne	SHORT $LN3@wmain

; 149  : 	{
; 150  : 		if( DeleteService(service) )

	mov	eax, DWORD PTR _service$[ebp]
	push	eax
	call	DWORD PTR __imp__DeleteService@4
	test	eax, eax
	je	SHORT $LN2@wmain

; 151  : 		{
; 152  : 			_tprintf(_TEXT("\nService '%s' deleted"), serviceName);

	push	OFFSET _serviceName
	push	OFFSET ??_C@_1CM@BNAEJNDE@?$AA?6?$AAS?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?5?$AAd?$AAe?$AAl?$AAe?$AAt?$AAe?$AAd?$AA?$AA@
	call	DWORD PTR __imp__wprintf
	add	esp, 8

; 153  : 		}
; 154  : 		else

	jmp	SHORT $LN3@wmain
$LN2@wmain:

; 155  : 		{
; 156  : 			lastError = GetLastError();

	call	DWORD PTR __imp__GetLastError@0
	mov	DWORD PTR _lastError$[ebp], eax

; 157  : 			_tprintf(_TEXT("\nCan't delete service '%s'. ErrorCode=0x%0X."),
; 158  : 						 serviceName, lastError);

	mov	ecx, DWORD PTR _lastError$[ebp]
	push	ecx
	push	OFFSET _serviceName
	push	OFFSET ??_C@_1FK@KCMKJLAP@?$AA?6?$AAC?$AAa?$AAn?$AA?8?$AAt?$AA?5?$AAd?$AAe?$AAl?$AAe?$AAt?$AAe?$AA?5?$AAs?$AAe?$AAr?$AAv?$AAi?$AAc?$AAe?$AA?5?$AA?8?$AA?$CF?$AAs?$AA?8?$AA?4?$AA?5?$AAE?$AAr?$AAr?$AAo@
	call	DWORD PTR __imp__wprintf
	add	esp, 12					; 0000000cH
$LN3@wmain:

; 159  : 		}
; 160  : 	}
; 161  : 
; 162  : 	CloseServiceHandle(service);

	mov	edx, DWORD PTR _service$[ebp]
	push	edx
	call	DWORD PTR __imp__CloseServiceHandle@4

; 163  : 	CloseServiceHandle(scm);

	mov	eax, DWORD PTR _scm$[ebp]
	push	eax
	call	DWORD PTR __imp__CloseServiceHandle@4

; 164  : 	_tprintf(_TEXT("\nPress 'Enter' to exit\n"));

	push	OFFSET ??_C@_1DA@HBHLMCKP@?$AA?6?$AAP?$AAr?$AAe?$AAs?$AAs?$AA?5?$AA?8?$AAE?$AAn?$AAt?$AAe?$AAr?$AA?8?$AA?5?$AAt?$AAo?$AA?5?$AAe?$AAx?$AAi?$AAt?$AA?6?$AA?$AA@
	call	DWORD PTR __imp__wprintf
	add	esp, 4

; 165  : 	_gettchar();

	mov	ecx, DWORD PTR __imp___iob
	push	ecx
	call	_fgetwc
	add	esp, 4

; 166  : 	return lastError;

	mov	eax, DWORD PTR _lastError$[ebp]
$LN30@wmain:

; 167  : }

	mov	ecx, DWORD PTR __$ArrayPad$[ebp]
	xor	ecx, ebp
	call	@__security_check_cookie@4
	mov	esp, ebp
	pop	ebp
	ret	0
_wmain	ENDP
_TEXT	ENDS
END