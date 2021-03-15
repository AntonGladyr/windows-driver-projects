#include <ipexport.h>

//http://en.wikipedia.org/wiki/IPv4_header
typedef struct IPHeader {
	UCHAR		iph_verlen;	// Version and length
	UCHAR		iph_tos;		// Type of service
	USHORT		iph_length;	// Total datagram length
	USHORT		iph_id;		// Identification
	USHORT		iph_offset;	// Flags, fragment offset
	UCHAR		iph_ttl;		// Time to live
// http://support.microsoft.com/kb/289892/ru
// Protocol	http://en.wikipedia.org/wiki/List_of_IP_protocol_numbers
	UCHAR		iph_protocol;	
	USHORT		iph_xsum;       // Header checksum
	IN_ADDR	iph_src;		// Source address
	IN_ADDR	iph_dest;		// Destination address
} IPHeader;

#define DRIVER_NAMEA		"ipackfltr"
#define DRIVER_NAMEW		L"ipackfltr"
#define DEV_TYPE				FILE_DEVICE_UNKNOWN

#define IOCTL_SET_FILTER		CTL_CODE(DEV_TYPE, 0x800, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define IOCTL_RESET_FILTER	CTL_CODE(DEV_TYPE, 0x801, METHOD_BUFFERED, FILE_ANY_ACCESS)

#if defined(_NTDDK_) || defined(_WDMDDK_)
	DECLARE_CONST_UNICODE_STRING(deviceName, L"\\Device\\"DRIVER_NAMEW);
	DECLARE_CONST_UNICODE_STRING(symbolicLinkName, L"\\??\\"DRIVER_NAMEW);
#else
	TCHAR	serviceName[]		= _TEXT(DRIVER_NAMEA);
	TCHAR	symbolicLinkName[]	= _TEXT("\\\\.\\")_TEXT(DRIVER_NAMEA);
	TCHAR	imageName[]			= _TEXT(DRIVER_NAMEA)_TEXT(".sys");
#endif
