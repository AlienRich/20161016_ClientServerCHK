@echo off
SET CPPS1=.\_$$_ClientServer½LÂI_20161014.ps1

For /f "tokens=1-3 delims=/ " %%a in ('date /t') do (set Today=%%a%%b%%c)
For /f "tokens=2-3 delims=/: " %%a in ('time /t') do (set ATtime=%%a%%b)
echo %Today%_%ATtime%
set RunDATE=%mydate%
set RunTime=%ATtime%

mkdir .\_CSMBADMIN && copy %CPPS1% .\_CSMBADMIN\_$$_%RunDATE%_CSMBADMIN.ps1
mkdir .\_CSMBMGR && copy %CPPS1% .\_CSMBMGR\_$$_%RunDATE%_CSMBMGR.ps1
mkdir .\_DCAD-CSMBAdmin && copy %CPPS1% .\_DCAD-CSMBAdmin\_$$_%RunDATE%_DCAD-CSMBAdmin.ps1
mkdir .\_KGIBANK-CSMBMGR && copy %CPPS1% .\_KGIBANK-CSMBMGR\_$$_%RunDATE%_KGIBANK-CSMBMGR.ps1
mkdir .\_apmonitor && copy %CPPS1% .\_apmonitor\_$$_%RunDATE%_apmonitor.ps1
mkdir .\_APUSER && copy %CPPS1% .\_APUSER\_$$_%RunDATE%_APUSER.ps1
mkdir .\_SYSMGR && copy %CPPS1% .\_SYSMGR\_$$_%RunDATE%_SYSMGR.ps1

copy _@_* .\_CSMBADMIN
copy _@_* .\_CSMBMGR
copy _@_* .\_DCAD-CSMBAdmin
copy _@_* .\_KGIBANK-CSMBMGR
copy _@_* .\_apmonitor
copy _@_* .\_APUSER
copy _@_* .\_SYSMGR

copy PsInfo.exe .\_CSMBADMIN
copy PsInfo.exe .\_CSMBMGR
copy PsInfo.exe .\_DCAD-CSMBAdmin
copy PsInfo.exe .\_KGIBANK-CSMBMGR
copy PsInfo.exe .\_apmonitor
copy PsInfo.exe .\_APUSER
copy PsInfo.exe .\_SYSMGR

dir /s /-b _$$_%RunDATE%_*.ps1

PAUSE