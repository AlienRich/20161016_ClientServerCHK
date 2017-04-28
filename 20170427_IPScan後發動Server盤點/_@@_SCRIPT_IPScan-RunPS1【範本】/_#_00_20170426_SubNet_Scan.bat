del /s /q .\_@@_KGIBANK-IP.txt
del /s /q .\_@@_Scan_IP_Ranges.txt
del /s /q .\IPList_ALL_Branch.txt

::::	擷取所在路徑
for /f "tokens=1,2,3 delims=@" %%p in ('forfiles /p .\ /s /m *.@ /C "cmd /c echo @path"') DO (SET RunPath=%%p%%r)

::::	使用IP-SCAN將網段內的PC掃出
for /F %%i IN (.\_#_IP-Range.txt) do (.\AdvancedIPScannerPortable\advanced_ip_scanner_console.exe /r:%%i /f:.\_@@@@_%%i_Scan_IP_Ranges.txt)
copy .\_@@@@_*_Scan_IP_Ranges.txt .\_@@_Scan_IP_Ranges.txt

::::	過濾狀態"alive"與"KGIBANK"
TYPE .\_@@_Scan_IP_Ranges.txt | find "alive" >>.\_@@_KGIBANK-IP.txt

::::	篩選出IP
for /F "usebackq tokens=1,2,3,4,5 delims= " %%I IN (.\_@@_KGIBANK-IP.txt) do echo %%M>>.\_@@_Scan_IP_Ranges-BugIP.txt

::::	隔離有問題IP-->_@@_Scan_IP_Ranges.txt
TYPE .\_@@_Scan_IP_Ranges-BugIP.txt | find /V "172.18.254.122" | find /V "10.86.11.41" | find /V "172.17.100.82" | sort >>.\_@@_Scan_IP_Ranges.txt

::::	建立各分行資料夾
for /F "usebackq tokens=1,2,3 delims=.-" %%i IN (.\_#_IP-Range.txt) do mkdir .\BranchIP\%%i.%%j.%%k

::::	將各分行的IP丟入各分行資料夾
for /F "usebackq tokens=1,2,3,4 delims=. " %%i IN (.\_@@_Scan_IP_Ranges.txt) do echo %%i.%%j.%%k.%%l>>.\BranchIP\%%i.%%j.%%k\_@_ScanIPList.txt

::::	複製PS1到各資料夾內
for /f %%a in ('dir /b .\BranchIP') do robocopy %CD%\_@@_ScriptDir %CD%\BranchIP\%%a /r:3 /w:0

::::	產生執行批次檔runPS.bat
::::	產生執行批次檔runPS.bat
for /f %%a in ('dir /b /a:d %CD%\BranchIP') do (
	echo cd %CD%\BranchIP\%%a>%CD%\BranchIP\%%a\runPS.bat
	type %CD%\_#_RunPsTMP.txt>>%CD%\BranchIP\%%a\runPS.bat
	start %CD%\BranchIP\%%a\runPS.bat
	TIMEOUT 600
	echo cd %CD%\BranchIP\%%a>%CD%\BranchIP\%%a\_#_ClientServer盤點_20170421_IPList.ps1
	type %CD%\_#_ClientServer盤點_20170421_IPList.ps1.txt>>%CD%\BranchIP\%%a\_#_ClientServer盤點_20170421_IPList.ps1
	start powershell "%CD%\BranchIP\%%a\_#_ClientServer盤點_20170421_IPList.ps1"
	)





::::	for /f %a in ('dir /b .\BranchIP') do echo cd\>.\BranchIP\%a\runPS.bat
::::	for /f %a in ('dir /b .\BranchIP') do echo cd C:\TEMP\IPIP\BranchIP\%a>>.\BranchIP\%a\runPS.bat
::::	for /f %a in ('dir /b .\BranchIP') do echo POWERSHELL.exe "C:\TEMP\IPIP\BranchIP\%a\04_CHK_IE_VER_Query_iexplore.exe_FileVer.ps1">>.\BranchIP\%a\runPS.bat
::::	for /f %a in ('dir /b .\BranchIP') do start .\BranchIP\%a\runPS.bat
::::	for /f %a in ('dir /b .\BranchIP') do start .\BranchIP\%a\runPS.bat