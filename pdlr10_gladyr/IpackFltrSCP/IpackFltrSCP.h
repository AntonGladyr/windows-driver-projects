#include <windef.h>
#include <winbase.h>
#include <wincon.h>
#include <winsvc.h>
#include <devioctl.h>
#include <stdio.h>
#include <tchar.h>
#include <Winsock2.h>
#include "../common.h"

#define SERVICE_NOT_INSTALLED	0x00
#define SERVICE_INSTALLED		0x01	
#define SERVICE_STARTED			0x02
//#define SERVICE_RUNNING 		0x04 winsvc.h
#define SERVICE_OPENED			0x08
