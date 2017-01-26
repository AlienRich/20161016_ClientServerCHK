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
	---,[MachineType]	>>>>������B������

---->>[ServerScan_20161021].[AllDevices_Assessment].[HardwareInventoryEx]
	---,[ComputerModel],ltrim(rtrim([IPAddress])) as IPAddress
	,(replace(replace(replace([IPAddress],';','/'),Char(10),'/'),Char(13),'/')) as IPAddress
	----	,ltrim(rtrim([ActiveNetworkAdapter])) as ActiveNetworkAdapter

FROM [ServerScan_20161021].[AllDevices_Assessment].[HardwareInventoryCore] HostnameAddOS left outer join 
	[ServerScan_20161021].[AllDevices_Assessment].[HardwareInventoryEx] CpuRamSN
	on HostnameAddOS.DeviceNumber = CpuRamSN.DeviceNumber

where [BIOsSerialNumber] is not NULL
;


  --inner join --->>���䳣�����~�|��ܡA�p�G�S���@�P��쪺����
  --left outer join	--->>���������ܡA���ޥk�䦳�S��
  --right outer join	--->>�k�������ܡA���ޥ��䦳�S��
 --full outer join	--->����������

---SQL �d�� ����Ÿ�
---where id like '%'+char(10)+'%'
---CHAR �i�Ω�N����r�Ŵ��J�r�Ŧꤤ�C�U����ܤF�@�Ǳ`�Ϊ�����r�šC
---������ ��
---Tab�G CHAR(9)
---����G CHAR(10)
---ENTER�G CHAR(13)