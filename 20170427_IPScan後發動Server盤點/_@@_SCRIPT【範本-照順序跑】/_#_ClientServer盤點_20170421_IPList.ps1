####	此JOB為對IP-List列舉的IP做掃描
####	此JOB為對IP-List列舉的IP做掃描

#####################################################################################################################
#####################################################################################################################

#####  wmic /output:d:\XXXXX.txt product get name,version,Vendor
#####  wmic /output:.\_check_$Hostname_Software.txt product get name,version,Vendor
Function Get-RemoteProgram {
    [CmdletBinding(SupportsShouldProcess=$true)]
    param(
        [Parameter(ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
        [string[]]
            $ComputerName = $env:COMPUTERNAME,
        [Parameter(Position=0)]
        [string[]]$Property 
    )

    begin {
        $RegistryLocation = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\',
                            'SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'
        $HashProperty = @{}
        $SelectProperty = @('ProgramName','ComputerName')
        if ($Property) {
            $SelectProperty += $Property
        }
    }
    process {
        foreach ($Computer in $ComputerName) {
            $RegBase = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine,$Computer)
            foreach ($CurrentReg in $RegistryLocation) {
                if ($RegBase) {
                    $CurrentRegKey = $RegBase.OpenSubKey($CurrentReg)
                    if ($CurrentRegKey) {
                        $CurrentRegKey.GetSubKeyNames() | ForEach-Object {
                            if ($Property) {
                                foreach ($CurrentProperty in $Property) {
                                    $HashProperty.$CurrentProperty = ($RegBase.OpenSubKey("$CurrentReg$_")).GetValue($CurrentProperty)
                                }
                            }
                            $HashProperty.ComputerName = $Computer
                            $HashProperty.ProgramName = ($DisplayName = ($RegBase.OpenSubKey("$CurrentReg$_")).GetValue('DisplayName'))
                            if ($DisplayName) {
$NoRemove= ($RegBase.OpenSubKey("$CurrentReg$_")).GetValue('NoRemove')
$UninstallStr = ($RegBase.OpenSubKey("$CurrentReg$_")).GetValue('UninstallString')
$SysCom= ($RegBase.OpenSubKey("$CurrentReg$_")).GetValue('SystemComponent')
$RegParentKey=""
$RegParentKey = ($RegBase.OpenSubKey("$CurrentReg$_")).GetValue('ParentKeyName')
$Publisher = ($RegBase.OpenSubKey("$CurrentReg$_")).GetValue('Publisher')
write-host $DisplayName
		 		 		 		 $Show=1
		 		 		 		 if($SysCom -eq 1 ) { $Show=0 }
		 		 		 		 if($UninstallStr -eq "") { $Show=0 }
		 		 		 		 if($SysCom -eq 1 ) { $Show=0 }
		 		 		 		 if($RegParentKey) {$Show=0}
		 		 		 		 if($DisplayName -match "\W*kb\d{5,8}\W*")
		 		 		 		 {
		 		 		 		 		 if( $Publisher -match "\W*microsoft\W*")
		 		 		 		 		 {
		 		 		 		 		 		 Write-host '----------------------------bingo'+ $DisplayName
		 		 		 		 		 		 $Show=0
		 		 		 		 		 }
		 		 		 		 		 write-host 
		 		 		 		 }
		 		 		 		 if($Show)
		 		 		 		 {
write-host $Show
write-host $DisplayName
Write-host "		 NoRemove=$($NoRemote)"
Write-host "		 Uninsta=$($UninstallStr)"
Write-host "		 SysCom=$($sysCom)"
write-host "		 ParentKey=$($ParentKey)"
		                                 New-Object -TypeName PSCustomObject -Property $HashProperty |
		                                Select-Object -Property $SelectProperty
		 		 		 		 }
                            } 
                        }
                    }
                }
            }
        }
    }
}
#####################################################################################################################

$LoginID = "Domain\UserID"

$SubNetFileName = $LoginID.Replace("\",".")	##置換特殊符號
#######網段IP列表#######
$SubNetList = ".\_@_ScanIPList.txt"

#######使用帳號#######
$CredMonitoradm = Get-Credential -Credential $LoginID
#####################################################################################################################
#####################################################################################################################
	#################
	# 此部份產生表頭
	#################

	###	欄位名稱與ServerList相同
	$TitleInfo="Scan-IP,HOST_NAME,DOMAIN_NAME,Manufacturer,SERVER_MODEL,SERIAL_NO,MEMORY_TOTAL,PROCESSOR_NO,OS,ServicePack,IPAddress"
	$TitleInfo | out-file .\__MachineModel.txt -append -encoding utf8

	$ServiceTitle = "Scan-IP,HOST_NAME,SERIAL_NO,Type,DisplayName,ServiceState,StartAccount,ExecPath"
	$ServiceTitle | out-file .\__ServiceName.txt -append -encoding utf8

	##	雜訊過多，必要再使用	$PsinfoSoftwareTitle = "Scan-IP;Type;SoftwareName"
	##	雜訊過多，必要再使用	$PsinfoSoftwareTitle | out-file .\__PsinfoSoftware.txt -append -encoding utf8
	$SoftwareTitle = "Scan-IP,HOST_NAME,SERIAL_NO,Type,SoftwareName"
	$SoftwareTitle | out-file .\__Software.txt -append -encoding utf8

	$NetworkTitle = "Scan-IP,HOST_NAME,SERIAL_NO,Type,網卡IP,網卡資訊"
	$NetworkTitle | out-file .\__NetWork.txt -append -encoding utf8

	$PSinfoSYSTitle = "Scan-IP,Uptime,Kernel-Version,Kernel-Version-1,ProductType,ProductVersion,ServicePack,KernelBuildNumber,Registered-Organization,Registered-Owner,IE-Version,SystemRoot,Processors,ProcessorSpeed,ProcessorType,PhysicalMemory,VideoDriver,DISKInfo,Type,Format,Label,Size,Free,Free%,DISKInfo,Type,Format,Label,Size,Free,Free%,DISKInfo,Type,Format,Label,Size,Free,Free%,DISKInfo,Type,Format,Label,Size,Free,Free%,DISKInfo,Type,Format,Label,Size,Free,Free%,DISKInfo,Type,Format,Label,Size,Free,Free%,DISKInfo,Type,Format,Label,Size,Free,Free%"
	$PSinfoSYSTitle | out-file .\__PSinfoSYSRpt.csv -append -encoding utf8


$SubNet = Get-Content -Path $SubNetList | Foreach-Object { $SubNet = $_

 $IP = "NoMsg"
 $IP = $SubNet
 $ScanIP = "NoMsg"
 $ScanIP = "$IP"
 $host.ui.RawUI.WindowTitle = “USE-ID:::$LoginID:::【IPList】Connection：$ScanIP”
 
	if (test-connection $ScanIP -Quiet -Count 3) {
	 write-host "IP：$ScanIP,此IP存在。" -ForegroundColor GREEN
	 "IP：$ScanIP,此IP存在。" | Out-File -Append -FilePath .\__IP-No-response.log
	 }
	 else
	 {
	 write-host "$ScanIP,NoResponse,無法Ping..." -ForegroundColor GREEN
	 "$ScanIP,NoResponse,無法Ping..." | Out-File -Append -FilePath .\__IP-No-response.log
	 }

		 if (Test-PATH "\\$ScanIP\c$") 
		{
		### 使用PSinfo.exe撈取資訊，針對RPC伺服器無法使用server
		$PSinfoSYS = "NoMsg"
		$PSinfoSYS = .\psinfo.exe -d -c \\$ScanIP | out-file .\__PSinfoSYSRpt.csv -append -encoding utf8

		#################
		# Software＜使用PSinfo.exe，針對RPC伺服器無法使用server＞
		#################
		##	雜訊過多，必要再使用	$PsinfoEXEOutput = "NoMsg"
		##	雜訊過多，必要再使用	$item = "NoMsg"
		##	雜訊過多，必要再使用	$PsinfoEXEOutput = .\psinfo.exe -s Applications \\$ScanIP | Findstr.exe /IV "(KB" | sort
		##	雜訊過多，必要再使用		foreach ($item in $PsinfoEXEOutput) 
		##	雜訊過多，必要再使用		{
		##	雜訊過多，必要再使用		$PsinfoSoftwareMSG = "NoMsg"
		##	雜訊過多，必要再使用		$PsinfoSoftwareMSG= $ScanIP + ";Software;" + $item
		##	雜訊過多，必要再使用		$PsinfoSoftwareMSG | out-file .\__PsinfoSoftware.txt -append  -encoding utf8
		##	雜訊過多，必要再使用		write-host $ScanIP：軟體項目：$item
		##	雜訊過多，必要再使用		}

		#######################
		# Local-Group & Member	--->不須走WMI、RPC
		#######################
		$adsi = "NoMsg"
		$SRVUGList = "NoMsg"
		$groups = "NoMsg"
		$ScanIPHostname = "NoMsg"
		$LocalAccount = "NoMsg"
		$adsi = [ADSI]"WinNT://$ScanIP"
		$SRVUGList = $adsi.Children | where {$_.SchemaClassName -eq 'user'} | 
		Foreach-Object {
			$groups = $_.Groups() | Foreach-Object {$_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null)}
			$_ | Select-Object @{n='Local-ID';e={$_.Name}},@{n='Local-Groups';e={$groups -join ';'}}
			}
		$ScanIPHostnameTitle ="ScanIP"+","+"HostName"
		$ScanIPHostname = $ScanIP+","+$ServerHostname
		$SRVUGList | add-member -Name $ScanIPHostnameTitle -Value $ScanIPHostname -MemberType NoteProperty
		$SRVUGList | Export-Csv -NoTypeInformation -Append -Encoding UTF8 -Path .\__List-Local-User-Group.csv
		
		####----此部分以wmi來撈-----------------------------------
		###遇到AD會撈很久卡住_停用		$LocalAccount = Get-WmiObject -Class Win32_UserAccount -Filter  "LocalAccount='True'" -comp $IP -Credential $CredMonitoradm | select PSComputerName,@{n='Local-ID';e={$_.Name}},Caption,Status,PasswordExpires,Disabled,Lockout,Description
		###遇到AD會撈很久卡住_停用		$LocalAccount | add-member -Name $ScanIPHostnameTitle -Value $ScanIPHostname -MemberType NoteProperty
		###遇到AD會撈很久卡住_停用		$LocalAccount | Export-Csv -NoTypeInformation -Append -Encoding UTF8 -Path .\$SubNet.xx_List-Local-User-Msg.csv
		
		####----此部分以_@_Get-LocalGroupMembers_0921.ps1來撈，只撈ADMINISTRATORS群組
		####	$GetLocalGroupMembers = .\_@_Get-LocalGroupMembers_0921.ps1 $ScanIP
		
		#######################
		# 查詢該台SERVER的排程	--->不須走WMI、RPC
		#######################
		$GetScheduledTask = "NoMsg"
		$GetScheduledTask =.\_@_Get-ScheduledTask.ps1 -ComputerName $ScanIP | where {$_.Path -notlike '*\Microsoft\*'} | select ComputerName,Name,Author,Enabled,LastRunTime,NextRunTime,Trigger,Description,Path
		$GetScheduledTask | Add-Member -MemberType NoteProperty -Name ScanIP -Value "$ScanIP"
		$GetScheduledTask | Export-Csv -NoTypeInformation -Encoding UTF8 -Append -Path .\__GetScheduledTask.csv
		schtasks /query /v /fo csv /s $ScanIP >> .\__CMDSchTasks.csv

	 #################以下開始依賴WMI、RPC-PORT
	 #################
	 # Machine Model
	 #################
	 ######---> 此段測試是否有RPC伺服器無法使用錯誤，若有錯誤($errorvar)直接跳到最後。
	 $ComputerSystem = "NoMsg"
	 $ComputerSystem = Get-WmiObject -ComputerName $ScanIP -credential $CredMonitoradm -Class Win32_ComputerSystem -errorvariable errorvar
	 if (-not $errorvar)
		{
		 ### Server HostName
		 $ServerHostname = "NoMsg"
		 $ServerHostname = $ComputerSystem.Name
		 ### Server DomainName
		 $ServerDomainName = "NoMsg"
		 $ServerDomainName = $ComputerSystem.Domain
		 ### Server廠牌
		 $Manufacturer = "NoMsg"
		 $Manufacturer = ($ComputerSystem.Manufacturer).Replace(",","")	##刪除VMware, Inc.的逗點
		 ### Server型號
		 $Model = "NoMsg"
		 $Model = ($ComputerSystem.Model).Replace(",",".")	###清除逗點
		 ### Server SerialNumber
		 $ServerSerialNumberNoFix = "NoMsg"
		 $ServerSerialNumber =  "NoMsg"
		 $ServerSerialNumberNoFix = (Get-WmiObject win32_bios -ComputerName $ScanIP -credential $CredMonitoradm).SerialNumber
		 $ServerSerialNumber = $ServerSerialNumberNoFix.Replace(" ","")		###清除序號中的空格
		 ### Server實體記憶體大小
		 $TotalPhysicalMemoryNofix = "NoMsg"
		 $TotalPhysicalMemory = "NoMsg"
		 $TotalPhysicalMemoryNofix = $ComputerSystem.TotalPhysicalMemory / 1GB
		 $TotalPhysicalMemory = '{0:n1}' -f $TotalPhysicalMemoryNofix	###小數1位之後的四捨五入
		 ### Server核心數
		 $Core = "NoMsg"
		 $Core = Get-WmiObject -Class Win32_Processor -ComputerName $ScanIP -credential $CredMonitoradm | select DeviceID,NumberOfCores
		 $CoreNum = "NoMsg"
		 $CoreNum = $Core[0].NumberOfCores + $Core[1].NumberOfCores + $Core[2].NumberOfCores + $Core[3].NumberOfCores + $Core[4].NumberOfCores + $Core[5].NumberOfCores + $Core[6].NumberOfCores + $Core[7].NumberOfCores
		 ### Server OS information
		 $ServerOSVer = "NoMsg"
		 $ServerOSVer = Get-WmiObject -ComputerName $ScanIP -credential $CredMonitoradm -Class Win32_OperatingSystem
			## Server OS Ver
			$WindowsVersion = "NoMsg"
			$WindowsVersion = ($ServerOSVer.caption).Replace(" ","")	###清除逗點
			## Server OS service-pack
			$ServicePack = "NoMsg"
			$ServicePack = $ServerOSVer.CSDVersion
		### Server IP
		$NET = "NoMsg"
		$NET = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -ComputerName $ScanIP -credential $CredMonitoradm -errorvariable errorvar -filter "ipenabled = $true" | select PSComputerName,MACAddress,Description,IPAddress
			$NetIP1 = "NoMsg"
			$NetIP2 = "NoMsg"
			$NetIP3 = "NoMsg"
			$NetIP4 = "NoMsg"
			$NetIP1 = $net[0].IPAddress[0]
			$NetIP2 = $net[1].IPAddress[0]
			$NetIP3 = $net[2].IPAddress[0]
			$NetIP4 = $net[3].IPAddress[0]
		$ServerIPv4 = "NoMsg"
		$ServerIPv4 = $NetIP1 + "/" +$NetIP2 + "/" + $NetIP3 + "/"+$NetIP4
		
		### 組合資訊
		$ComputerSystemMsg1 = "NoMsg"
		$ComputerSystemMsg2 = "NoMsg"
		$ComputerSystemMsgALL = "NoMsg"
		$ComputerSystemMsg1 = $ScanIP + "," + $ServerHostname + "," + $ServerDomainName + "," + $Manufacturer + "," + $Model + "," + $ServerSerialNumber + "," + $TotalPhysicalMemory + "," + $CoreNum
		$ComputerSystemMsg2 = $WindowsVersion + "," + $ServicePack + "," + $ServerIPv4
		$ComputerSystemMsgALL= $ComputerSystemMsg1 + "," + $ComputerSystemMsg2
		$ComputerSystemMsgALL | out-file .\__MachineModel.txt -append -encoding utf8

	 #################
	 # Disk-info
	 #################
		$Diskinfo = "NoMsg"
		$Diskinfo = (Get-WmiObject -Class Win32_LogicalDisk -computername $ScanIP -credential $CredMonitoradm |
			Where-Object {$_.DriveType -ne 5} |Where-Object {$_.DriveType -ne 4} | Sort-Object -Property Name | 
			Select-Object SystemName,DeviceID,VolumeName,FileSystem,Description,
				@{"Label"="DiskSize(GB)";"Expression"={"{0:N}" -f ($_.Size/1GB) -as [float]}},
				@{"Label"="FreeSpace(GB)";"Expression"={"{0:N}" -f ($_.FreeSpace/1GB) -as [float]}},
				@{"Label"="%_Free";"Expression"={"{0:N}" -f ($_.FreeSpace/$_.Size*100) -as [float]}})
			$Diskinfo | Add-Member -MemberType NoteProperty -Name SerialNumber -Value "$ServerSerialNumber"
			$Diskinfo | Add-Member -MemberType NoteProperty -Name ScanIP -Value "$ScanIP"
			$Diskinfo | Export-Csv -NoTypeInformation -Encoding UTF8 -Append -Path .\__DiskInfo.csv

		#################
		# Service
		#################
		$ServiceObject = "NoMsg"
		$ServiceObject = Get-WmiObject -ComputerName $ScanIP -credential $CredMonitoradm -Class Win32_service
		$ServiceItem = "NoMsg"
			foreach ($ServiceItem in $ServiceObject) 
		 		{
				$ServiceMSG = "NoMsg"
		 		$ServiceMSG = $ScanIP + "," + $ServerHostname + "," + $ServerSerialNumber + ",Service," + $ServiceItem.DisplayName + "," + $ServiceItem.state + "," + $ServiceItem.StartName + "," + $ServiceItem.PathName
		 		$ServiceMSG | out-file ".\__ServiceName.txt"  -append  -encoding utf8
		 		}

		#################
		# Software
		#################
		$GetSoftware = "NoMsg"
		$GetSoftware = Get-RemoteProgram -ComputerName $ScanIP
		$softArr = @()
		$GetSoftwareitem = "NoMsg"
		foreach ($GetSoftwareitem in $GetSoftware) 
		 	{
		 	if($softArr -Contains $GetSoftwareitem.ProgramName)
				{
				write-host "duplicate $($GetSoftwareitem.ProgramName)"
		 		}
		 		else
		 		{
		 		$softArr+=$GetSoftwareitem.ProgramName
				$GetSoftwareMsg = "NoMsg"
		 		$GetSoftwareMsg = $ScanIP + "," + $ServerHostname + "," + $ServerSerialNumber + ",Software," + $GetSoftwareitem.ProgramName
		 		$GetSoftwareMsg | out-file .\__Software.txt -append  -encoding utf8
		 		}
		 	}

		#################
		# Network
		#################
		$netadapter = "NoMsg"
		$netadapter = get-wmiobject -class win32_networkadapterconfiguration -computername $ScanIP -credential $CredMonitoradm -errorvariable errorvar -filter "ipenabled = $true"
		$netitem = "NoMsg"
		foreach ($netitem in $netadapter)
			{
			$PSComputerName = "NoMsg"
			$PSComputerName = $netitem | select PSComputerName
			$message = "NoMsg"
			$message = $ScanIP + "," + $ServerHostname + "," + $ServerSerialNumber + ",Network," + $netitem.ipaddress + "," + $netitem.description
			$message | out-file ".\__NetWork.txt"  -append -encoding utf8
			}

		 #################
		 ## 清除全部參數
		 #################
			$ComputerSystem = "NoMsg"
			$ServerHostname = "NoMsg"
			$ServerDomainName = "NoMsg"
			$Manufacturer = "NoMsg"
			$Model = "NoMsg"
			$ServerSerialNumber = "NoMsg"
			$TotalPhysicalMemory = "NoMsg"
			$Core = "NoMsg"
			$CoreNum = "NoMsg"
			$ServerOSVer = "NoMsg"
			$WindowsVersion = "NoMsg"
			$ServicePack = "NoMsg"
			$NET = "NoMsg"
			$NetIP1 = "NoMsg"
			$NetIP2 = "NoMsg"
			$NetIP3 = "NoMsg"
			$NetIP4 = "NoMsg"
			$ServerIPv4 = "NoMsg"
			$ComputerSystemMsg1 = "NoMsg"
			$ComputerSystemMsg2 = "NoMsg"
			$ComputerSystemMsgALL = "NoMsg"
			$ComputerSystemMsgALL = "NoMsg"
			$PSinfoSYS = "NoMsg"
			$PSinfoSYS = "NoMsg"
			$Diskinfo = "NoMsg"
			$ServiceObject = "NoMsg"
			$ServiceItem = "NoMsg"
			$PsinfoEXEOutput = "NoMsg"
			$item = "NoMsg"
			$PsinfoSoftwareMSG = "NoMsg"
			$softArr = "NoMsg"
			$GetSoftwareitem = "NoMsg"
			$GetSoftware = "NoMsg"
			$GetSoftwareMsg = "NoMsg"
			$netadapter = "NoMsg"
			$netitem = "NoMsg"
			$PSComputerName = "NoMsg"
			$message = "NoMsg"
			#######################
			$ScanIP = "NoMsg" ### 此行務必放最後
		}
		else
		{
		write-host "$ScanIP,RPC_Err,可連入C，但無法撈取WMI資料!!!" -ForegroundColor CYAN
		"$ScanIP,RPC_Err,可連入C，但無法撈取WMI資料!!!" | Out-File -Append -FilePath ".\__IP-No-response.log"
		$ScanIP = "NoMsg"
		}

	}
	else
	{
	write-host "$ScanIP,NoPath,無此IP、非微軟系統。或帳號：$LoginID 無權限！C無法連入！！" -ForegroundColor Yellow
	"$ScanIP,NoPath,無此IP、非微軟系統。或帳號：$LoginID 無權限！C無法連入！！" | Out-File -Append -FilePath ".\__IP-No-response.log"
	$ScanIP = "NoMsg"
	}
##NoTestPing }
##NoTestPing  else
##NoTestPing  {
##NoTestPing	write-host "$ScanIP 無法Ping...HAHAHAHA~~"  -ForegroundColor GREEN
##NoTestPing	"$ScanIP 無法Ping...HAHAHAHA~~" | Out-File -Append -FilePath ".\__IP-No-response.log"
##NoTestPing  }
}

#####################################################################################################################
#####################################################################################################################
#####################################################################################################################
<#----/
#####################################################################################################################
#####################################
IP列表
10.86.1.0/24
10.86.11.0/24
10.87.1.0/24
10.87.11.0/24
10.87.254.0/24
172.18.1.0/24
172.18.11.0/24
172.18.12.0/24
172.18.14.0/24
172.18.253.0/25
172.18.254.0/24
172.18.255.0/24
172.16.253.0/24
172.16.254.0/24
172.16.255.0/25
172.16.2.0/24
172.19.1.0/24
172.17.0.0/17
172.24.0.0/17
172.25.0.0/19
----/#>