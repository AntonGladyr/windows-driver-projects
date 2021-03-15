#define DRIVER_NAMEW			L"FileDevIODemo"
#define DRIVER_NAMEA			"FileDevIODemo"
#define DEV_TYPE					FILE_DEVICE_UNKNOWN

#define IN_BUFFER_SIZE			0x100
#define OUT_BUFFER_SIZE			IN_BUFFER_SIZE

#if defined(_NTDDK_) || defined(_WDMDDK_)
	DECLARE_CONST_UNICODE_STRING(deviceName, L"\\Device\\"DRIVER_NAMEW);
	DECLARE_CONST_UNICODE_STRING(symbolicLinkName, L"\\??\\"DRIVER_NAMEW);
#else
	TCHAR	serviceName[]		= _TEXT(DRIVER_NAMEA);
	TCHAR	symbolicLinkName[]	= _TEXT("\\\\.\\")_TEXT(DRIVER_NAMEA);
	TCHAR	imageName[]			= _TEXT(DRIVER_NAMEA)_TEXT(".sys");
#endif
