echo off
if "%1"=="" goto usage
sc stop $%~n1
sc delete $%~n1
goto TheEnd
:usage
@echo #####################################################################
@echo Usage: %~nx0 ^<ImageName.sys^>
@echo #####################################################################
:TheEnd
