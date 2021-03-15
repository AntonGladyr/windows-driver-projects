#define DRIVER_NAMEA		       	"pciconfigviewer"
#define DRIVER_NAMEW		       	L"pciconfigviewer"
#define DEV_TYPE					FILE_DEVICE_UNKNOWN

#define IOCTL_GET_PCI_COMMON_HEADER	CTL_CODE(DEV_TYPE, 0x800, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define IOCTL_FIND_PCI_DEVICE			CTL_CODE(DEV_TYPE, 0x801, METHOD_BUFFERED, FILE_ANY_ACCESS)
#define IOCTL_GET_PCI_CLASS_CODE		CTL_CODE(DEV_TYPE, 0x802, METHOD_BUFFERED, FILE_ANY_ACCESS)

#define PCI_MAX_BRIDGE_NUMBER	255
#define PCI_MAX_DEVICES			32
#define PCI_MAX_FUNCTION		8

typedef struct _PCI_SLOT_NUMBER_EXT {
	union
	{
		struct
		{
			ULONG	Reserved1		: 2;
			ULONG	RegisterNumber	: 6;
			ULONG	FunctionNumber	: 3;
			ULONG	DeviceNumber	: 5;
			ULONG	BusNumber		: 8;
			ULONG	Reserved2		: 7;		
			ULONG	TestBit			: 1;
		} bits;
        		ULONG	AsULONG;
	} u;        		
} PCI_SLOT_NUMBER_EXT, *PPCI_SLOT_NUMBER_EXT;

C_ASSERT(sizeof(PCI_SLOT_NUMBER_EXT) == sizeof(ULONG));

#if defined(_NTDDK_) || defined(_WDMDDK_)
	DECLARE_CONST_UNICODE_STRING(deviceName, L"\\Device\\"DRIVER_NAMEW);
	DECLARE_CONST_UNICODE_STRING(symbolicLinkName, L"\\??\\"DRIVER_NAMEW);
#else
	TCHAR	serviceName[]		= _TEXT(DRIVER_NAMEA);
	TCHAR	symbolicLinkName[]	= _TEXT("\\\\.\\")_TEXT(DRIVER_NAMEA);
	TCHAR	imageName[]			= _TEXT(DRIVER_NAMEA)_TEXT(".sys");
#endif

