@echo off
if "%1"=="" goto usage
set key=HKLM\SYSTEM\CurrentControlSet\Services\$%~n1
reg add %key%
reg add %key% /v Type /t REG_DWORD /d 1
reg add %key% /v Start /t REG_DWORD /d 3
reg add %key% /v ErrorControl /t REG_DWORD /d 0
reg add %key% /v ImagePath /t REG_EXPAND_SZ /d \??\%~f1
reg add %key% /v DisplayName /t REG_SZ /d "%~n1 driver display name"
goto TheEnd
:usage
@echo #####################################################################
@echo Usage: %~nx0 ^<ImageName.sys^>
@echo #####################################################################
:TheEnd