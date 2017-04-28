::::	forfiles /P C:\TEMP\20160623_ID-SCAN /s /m *_List-Local-User-Group.csv /c "cmd /c type @path >>C:\TEMP\20160623_ID-SCAN\原始資料篩選\_$$_ALL_List-Local-User-Group.csv"
:::		forfiles /P C:\TEMP /s /m *_List-Local-User-Group.csv /c "cmd /c type @path >>C:\TEMP\20160623_ID-SCAN\原始資料篩選\_$$_ALL_List-Local-User-Group_0629.csv"

set FilePath=%CD%
for /F "tokens=1,2,3 delims=/ " %%a IN ('date /t') do (set ScanDate=%%a%%b%%c)
for /F "tokens=1,2,3 delims=: " %%a IN ('time /t') do (set ScanTime=%%b%%c)


set FileName="*_MachineModel.txt"
set FileConvertName=%ScanDate%_MachineModel.csv
forfiles /P %FilePath% /s /m %FileName% /c "cmd /c type @path >>%FilePath%\%FileConvertName%"
set TMP-FileConvertName=%ScanDate%_MachineModel
powershell.exe "type %FilePath%\%FileConvertName% | sort -Unique | out-file %FilePath%\%TMP-FileConvertName%"
type %FilePath%\%TMP-FileConvertName% > %FilePath%\%FileConvertName%
del %TMP-FileConvertName%


set FileName1="*_NetWork.txt"
set FileConvertName1=%ScanDate%_NetWork.txt
forfiles /P %FilePath% /s /m %FileName1% /c "cmd /c type @path >>%FilePath%\%FileConvertName1%"
set TMP-FileConvertName1=%ScanDate%_NetWork
powershell.exe "type %FilePath%\%FileConvertName1% | sort -Unique | out-file %FilePath%\%TMP-FileConvertName1%"
type %FilePath%\%TMP-FileConvertName1% > %FilePath%\%FileConvertName1%
del %TMP-FileConvertName1%


set FileName2="*_ServiceName.txt"
set FileConvertName2=%ScanDate%_ServiceName.txt
forfiles /P %FilePath% /s /m %FileName2% /c "cmd /c type @path >>%FilePath%\%FileConvertName2%"
set TMP-FileConvertName2=%ScanDate%_ServiceName
powershell.exe "type %FilePath%\%FileConvertName2% | sort -Unique | out-file %FilePath%\%TMP-FileConvertName2%"
type %FilePath%\%TMP-FileConvertName2% > %FilePath%\%FileConvertName2%
del %TMP-FileConvertName2%


set FileName3="*_Software.txt"
set FileConvertName3=%ScanDate%_Software.txt
forfiles /P %FilePath% /s /m %FileName3% /c "cmd /c type @path >>%FilePath%\%FileConvertName3%"
set TMP-FileConvertName3=%ScanDate%_Software
powershell.exe "type %FilePath%\%FileConvertName3% | sort -Unique | out-file %FilePath%\%TMP-FileConvertName3%"
type %FilePath%\%TMP-FileConvertName3% > %FilePath%\%FileConvertName3%
del %TMP-FileConvertName3%


set FileName4="*_DiskInfo.csv"
set FileConvertName4=%ScanDate%_DiskInfo.csv
forfiles /P %FilePath% /s /m %FileName4% /c "cmd /c type @path >>%FilePath%\%FileConvertName4%"
set TMP-FileConvertName4=%ScanDate%_DiskInfo
powershell.exe "type %FilePath%\%FileConvertName4% | sort -Unique | out-file %FilePath%\%TMP-FileConvertName4%"
type %FilePath%\%TMP-FileConvertName4% > %FilePath%\%FileConvertName4%
del %TMP-FileConvertName4%


set FileName5="*_PSinfoSYSRpt.csv"
set FileConvertName5=%ScanDate%_PSinfoSYSRpt.csv
forfiles /P %FilePath% /s /m %FileName5% /c "cmd /c type @path >>%FilePath%\%FileConvertName5%"
set TMP-FileConvertName5=%ScanDate%_PSinfoSYSRpt
powershell.exe "type %FilePath%\%FileConvertName5% | sort -Unique | out-file %FilePath%\%TMP-FileConvertName5%"
type %FilePath%\%TMP-FileConvertName5% > %FilePath%\%FileConvertName5%
del %TMP-FileConvertName5%


set FileName6="*xx_IP-No-response.log"
set FileConvertName6=%ScanDate%_IP-No-response
forfiles /P %FilePath% /s /m %FileName6% /c "cmd /c type @path >>%FilePath%\%FileConvertName6%"
powershell.exe "type %FilePath%\%FileConvertName6% | sort -Unique | out-file %FilePath%\%FileConvertName6%.csv"
type %FilePath%\%FileConvertName6% | find "RPC_Err" > %ScanDate%_RPC_Err.csv
del %FilePath%\%FileConvertName6%


:::::::::::CLEAN SET::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set FileName=
set FileConvertName=
SET TMP-FileConvertName=
set FileNameMM=
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set FileName=Administrators-LocalGroupMembers.csv
set FileNameMM="*%FileName%"
set FileConvertName=%ScanDate%%FileName%
forfiles /P %FilePath% /s /m %FileNameMM% /c "cmd /c type @path >>%FilePath%\%FileConvertName%"
set TMP-FileConvertName=TMP-%FileConvertName%
powershell.exe "type %FilePath%\%FileConvertName% | sort -Unique | out-file %FilePath%\%TMP-FileConvertName%"
type %FilePath%\%TMP-FileConvertName% > %FilePath%\%FileConvertName%
del %TMP-FileConvertName%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


:::::::::::CLEAN SET::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set FileName=
set FileConvertName=
SET TMP-FileConvertName=
set FileNameMM=
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
set FileName=_List-Local-User-Group.csv
set FileNameMM="*%FileName%"
set FileConvertName=%ScanDate%%FileName%
forfiles /P %FilePath% /s /m %FileNameMM% /c "cmd /c type @path >>%FilePath%\%FileConvertName%"
set TMP-FileConvertName=TMP-%FileConvertName%
powershell.exe "type %FilePath%\%FileConvertName% | sort -Unique | out-file %FilePath%\%TMP-FileConvertName%"
type %FilePath%\%TMP-FileConvertName% > %FilePath%\%FileConvertName%
del %TMP-FileConvertName%
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::


PAUSE