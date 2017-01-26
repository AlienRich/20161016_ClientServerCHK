SELECT [ServerName]
      ,[DbName]
      ,[Fileid]
      ,[Name]
      ,[Filename]
---   ,[Filegroup]
      ,[Size]
---   ,[Maxsize]
---   ,[Growth]
---   ,[Usage]
---	  ,[CreateDatetime]
	  ,(replace(replace(replace([IPAddress],';','/'),Char(10),'/'),Char(13),'/')) as IPAddress
  FROM [ServerScan_20161021].[SqlServer_Inventory].[DataBaseFileGroup] DBFile left outer join 
	[ServerScan_20161021].[AllDevices_Assessment].[HardwareInventoryEx] CpuRamSN
	ON DBFile.DeviceNumber = CpuRamSN.DeviceNumber
  where DbName not like 'master' and DbName not like 'model' and DbName not like 'msdb' and DbName not like 'tempdb'
