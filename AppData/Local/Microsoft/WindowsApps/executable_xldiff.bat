@ECHO OFF
:: https://www.xltrail.com/blog/git-diff-spreadsheetcompare
:: git diff driver args: path old-file old-hex old-mode new-file new-hex new-mode

set "oldfile=%~2"
set "newfile=%~5"
set "oldfile=%oldfile:/=\%"
set "newfile=%newfile:/=\%"

set "cmpfile=%TEMP%\xldiff_%RANDOM%_%RANDOM%.txt"
> "%cmpfile%" ECHO %oldfile%
>> "%cmpfile%" ECHO %newfile%

set "SSC="
for %%P in (
    "C:\Program Files\Microsoft Office\root\Office16\DCF\SPREADSHEETCOMPARE.EXE"
    "C:\Program Files (x86)\Microsoft Office\root\Office16\DCF\SPREADSHEETCOMPARE.EXE"
    "C:\Program Files\Microsoft Office\Office16\DCF\SPREADSHEETCOMPARE.EXE"
    "C:\Program Files (x86)\Microsoft Office\Office16\DCF\SPREADSHEETCOMPARE.EXE"
    "C:\Program Files\Microsoft Office\Office15\DCF\SPREADSHEETCOMPARE.EXE"
    "C:\Program Files (x86)\Microsoft Office\Office15\DCF\SPREADSHEETCOMPARE.EXE"
) do (
    if not defined SSC if exist %%P set "SSC=%%~P"
)

if not defined SSC (
    ECHO xldiff: could not find SPREADSHEETCOMPARE.EXE 1>&2
    del "%cmpfile%" >nul 2>&1
    exit /b 1
)

set "APPVLP="
for %%P in (
    "C:\Program Files\Microsoft Office\root\client\AppVLP.exe"
    "C:\Program Files (x86)\Microsoft Office\root\client\AppVLP.exe"
) do (
    if not defined APPVLP if exist %%P set "APPVLP=%%~P"
)

if defined APPVLP (
    start "xldiff" /WAIT /B "%APPVLP%" "%SSC%" "%cmpfile%"
) else (
    start "xldiff" /WAIT /B "%SSC%" "%cmpfile%"
)

del "%cmpfile%" >nul 2>&1
exit /b 0
