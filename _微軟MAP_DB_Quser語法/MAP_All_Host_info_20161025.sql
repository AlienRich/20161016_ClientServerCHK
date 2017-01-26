SELECT 

---->>[ServerScan_20161021].[AllDevices_Assessment].[HardwareInventoryCore]
	(replace(replace(replace(replace([ComputerName],'.kgibank.com',''),'.dcad.cosmosbank.com.tw',''),'.ccad.cosmosbank',''),'.kgibanktest.com','')) as HostName
	,[Domain/Workgroup] as DomainName
	,(replace([BIOsManufacturer],'Phoenix Technologies LTD','VMware')) as Manufacturer
	,[ComputerModel] as Model
	,(replace([BIOsSerialNumber],' ','')) as SerialNumber
	,([SystemMemory] / 1024) as TotalPhysicalMemory
	,[NumberOfLogicalProcessors] as CoreNum
	,[CurrentOperatingSystem] as WindowsVersion
	,[OsServicePack] as ServicePack
	---,[MachineType]	>>>>實體機、虛擬機

---->>[ServerScan_20161021].[AllDevices_Assessment].[HardwareInventoryEx]
	---,[ComputerModel],ltrim(rtrim([IPAddress])) as IPAddress
	,(replace(replace(replace([IPAddress],';','/'),Char(10),'/'),Char(13),'/')) as IPAddress
	----	,ltrim(rtrim([ActiveNetworkAdapter])) as ActiveNetworkAdapter

FROM [ServerScan_20161021].[AllDevices_Assessment].[HardwareInventoryCore] HostnameAddOS left outer join 
	[ServerScan_20161021].[AllDevices_Assessment].[HardwareInventoryEx] CpuRamSN
	on HostnameAddOS.DeviceNumber = CpuRamSN.DeviceNumber

where [BIOsSerialNumber] is not NULL
;


  --inner join --->>兩邊都有的才會顯示，如果沒有共同欄位的忽略
  --left outer join	--->>左邊全部顯示，不管右邊有沒有
  --right outer join	--->>右邊全部顯示，不管左邊有沒有
 --full outer join	--->兩邊全部顯示

---SQL 查詢 換行符號
---where id like '%'+char(10)+'%'
---CHAR 可用於將控制字符插入字符串中。下表顯示了一些常用的控制字符。
---控制鍵 值
---Tab： CHAR(9)
---換行： CHAR(10)
---ENTER： CHAR(13)