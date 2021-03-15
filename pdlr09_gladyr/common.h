#define DRIVER_NAMEA		       	"SelfDefence"
#define DRIVER_NAMEW		       	L"SelfDefence"
#define DEV_TYPE					FILE_DEVICE_UNKNOWN

#define IOCTL_PROCESS_LOCK		CTL_CODE(DEV_TYPE, 0x800, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define IOCTL_PROCESS_UNLOCK	CTL_CODE(DEV_TYPE, 0x801, METHOD_BUFFERED, FILE_ANY_ACCESS)

#if defined(_NTDDK_) || defined(_WDMDDK_)
	DECLARE_CONST_UNICODE_STRING(deviceName, L"\\Device\\"DRIVER_NAMEW);
	DECLARE_CONST_UNICODE_STRING(symbolicLinkName, L"\\??\\"DRIVER_NAMEW);
#else
	TCHAR	serviceName[]		= _TEXT(DRIVER_NAMEA);
	TCHAR	symbolicLinkName[]	= _TEXT("\\\\.\\")_TEXT(DRIVER_NAMEA);
	TCHAR	imageName[]			= _TEXT(DRIVER_NAMEA)_TEXT(".sys");
#endif

