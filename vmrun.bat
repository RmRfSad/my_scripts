@echo off
setlocal enabledelayedexpansion

echo.
echo Usage: ./vulntarget.bat [dir_path] [show,add,delete,recovery,start,suspend,stop] {snapshot}

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
echo Your vmx path:
for /L %%i in (0,1,%i%) do echo !array[%%i]!

if "%mode%"=="show" (
    echo.
    echo Show snapshot:
    echo.
    for /L %%i in (0,1,%i%) do (
        echo !array[%%i]!
        set vmx=!array[%%i]!
        "!vmrunPath!" listSnapshots "!vmx!"
        echo.
    )
)

if "%mode%"=="add" (
    echo.
    echo Add snapshot
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" snapshot "!vmx!" "%snapshot_name%"
    )
    echo Add snapshot end..
)

if "%mode%"=="delete" (
    echo.
    echo Delete snapshot
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" deleteSnapshot "!vmx!" "%snapshot_name%"
    )
    echo Delete snapshot end..
)

if "%mode%"=="recovery" (
    echo.
    echo Recovery snapshot
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" revertToSnapshot "!vmx!" "%snapshot_name%"
    )
    echo Recovery snapshot end..
)

if "%mode%"=="start" (
    echo.
    echo Start vmx
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" -T ws start "!vmx!"
    )
    echo Start vmx end..
)

if "%mode%"=="suspend" (
    echo.
    echo Suspend vmx
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" -T ws suspend "!vmx!"
    )
    echo Suspend vmx end..
)

if "%mode%"=="stop" (
    echo.
    echo Stop vmx
    for /L %%i in (0,1,%i%) do (
        set vmx=!array[%%i]!
        "!vmrunPath!" -T ws stop "!vmx!"
    )
    echo Stop vmx end..
)

echo.