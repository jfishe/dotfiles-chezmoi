@echo off
setlocal EnableExtensions
rem -- Run SumatraPDF.exe installed by: winget install --id SumatraPDF.SumatraPDF --
rem # uninstall key: SumatraPDF #
rem Locates the exe via the uninstall key, then the usual install dirs, and forwards
rem every argument to it. No PowerShell involved, and the viewer is launched detached,
rem so it is cheap to call straight from Vim and never blocks the editor:
rem     :!SumatraPDF "%"
rem Detaching also keeps Sumatra's console logging out of Vim's message area; the exit
rem code reports the launch, not Sumatra's own exit code.
rem Copy to %LOCALAPPDATA%\Microsoft\WindowsApps to put SumatraPDF on PATH.

set "SUMATRA="

call :FromKey "HKCU\Software\Microsoft\Windows\CurrentVersion\Uninstall\SumatraPDF"
if not defined SUMATRA call :FromKey "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\SumatraPDF"
if not defined SUMATRA call :FromKey "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\SumatraPDF"

if not defined SUMATRA call :TryExe "%LOCALAPPDATA%\SumatraPDF\SumatraPDF.exe"
if not defined SUMATRA call :TryExe "%ProgramFiles%\SumatraPDF\SumatraPDF.exe"
if not defined SUMATRA call :TryExe "%ProgramFiles(x86)%\SumatraPDF\SumatraPDF.exe"

if not defined SUMATRA goto :NotFound

rem The empty "" is start's window title, so the next quoted token stays the program.
start "" "%SUMATRA%" %*
exit /b %ERRORLEVEL%

:NotFound
>&2 echo SumatraPDF.exe not found. Install it with: winget install --id SumatraPDF.SumatraPDF
exit /b 1

rem -- Read one uninstall key: InstallLocation first, then DisplayIcon --
:FromKey
for /f "tokens=2,*" %%A in ('reg query %1 /v InstallLocation 2^>nul') do call :TryExe "%%B\SumatraPDF.exe"
if defined SUMATRA goto :eof
for /f "tokens=2,*" %%A in ('reg query %1 /v DisplayIcon 2^>nul') do call :TryIcon "%%B"
goto :eof

rem -- DisplayIcon may carry a ",<index>" suffix --
:TryIcon
for /f "tokens=1 delims=," %%I in ("%~1") do call :TryExe "%%~I"
goto :eof

:TryExe
if defined SUMATRA goto :eof
if exist "%~1" set "SUMATRA=%~1"
goto :eof
