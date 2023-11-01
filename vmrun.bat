@echo off
setlocal enabledelayedexpansion

echo Usage: ./vulntarget.bat [dir_path] [show,add,delete,recovery] {snapshot}
echo.

set "vmrunPath=C:\\Program Files (x86)\\VMware\\VMware Workstation\\vmrun.exe"
set folder=%1
set mode=%2
set snapshot_name=%3
set i=0

for /R "%folder%" %%f in (*.vmx) do (
    set "array[!i!]=%%f"
    set /a i+=1
)
set /a i-=1

echo.
echo your vmx path:
for /L %%i in (0,1,%i%) do echo !array[%%i]!

if "%mode%"=="show" (
    echo.
    echo show snapshot
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" listSnapshots "!vmx!"
    )
)

if "%mode%"=="add" (
    echo.
    echo add snapshot
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" snapshot "!vmx!" "%snapshot_name%"
    )
)

if "%mode%"=="delete" (
    echo.
    echo delete snapshot
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" deleteSnapshot "!vmx!" "%snapshot_name%"
    )
)

if "%mode%"=="recovery" (
    echo.
    echo recovery snapshot
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" revertToSnapshot "!vmx!" "%snapshot_name%"
    )
)
