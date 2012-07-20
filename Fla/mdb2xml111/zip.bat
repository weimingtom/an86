cd %~dp0
%~d0
set file=data.zip
dir /a "%file%">nul 2>nul
if %errorlevel% equ 0 (
	del data.zip
)

WinRAR a -DF data.zip *.xml
