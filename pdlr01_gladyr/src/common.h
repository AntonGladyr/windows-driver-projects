#define DRIVER_NAME		"SimpleLegacyDrv"

#if !defined(_NTDDK_) && !defined(_WDMDDK_)
	TCHAR	serviceName[]	= _TEXT(DRIVER_NAME);
	TCHAR	imageName[]		= _TEXT(DRIVER_NAME)_TEXT(".sys");
#endif