@echo off
if "%1"=="" goto usage
sc create $%~n1 binPath= %~f1 type= kernel start= demand error= ignore DisplayName= "%~n1 driver display name"
sc start $%~n1
pause
goto TheEnd
:usage
@echo #####################################################################
@echo Usage: %~nx0 ^<ImageName.sys^>
@echo #####################################################################
:TheEnd
