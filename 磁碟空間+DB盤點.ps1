$ServerDisk = Get-WmiObject -Class Win32_LogicalDisk -computername $env:ComputerName |
    Where-Object {$_.DriveType -ne 5} |
    Sort-Object -Property Name | 
    Select-Object SystemName,DeviceID,VolumeName,FileSystem,Description, `
        @{"Label"="DiskSize(GB)";"Expression"={"{0:N}" -f ($_.Size/1GB) -as [float]}}, `
        @{"Label"="FreeSpace(GB)";"Expression"={"{0:N}" -f ($_.FreeSpace/1GB) -as [float]}}, `
        @{"Label"="%Free";"Expression"={"{0:N}" -f ($_.FreeSpace/$_.Size*100) -as [float]}}

$ServerDisk  | Add-Member -MemberType NoteProperty -Name HostName -Value $env:ComputerName

$ServerDisk | select DeviceID | foreach { get-ChildItem -path $_:\ -recurse -include "*.TXT" | 
        Where { $_.GetType().Name -eq "FileInfo" } | sort-Object -property length -Descending | 
        Select-Object Name,  }
