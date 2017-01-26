  SELECT 
	  ----,[ServerScan_20161021].[WinServer_Inventory].[MSClusterCluster].[Name] as ClustName
      [SystemName]
      ,[Node]
	  ,[DeviceID]
      ,[Adapter]
----  ,[AdapterId]
      ,[Address]
      ,[IPv4Addresses]
      ,[Network]
  FROM [ServerScan_20161021].[WinServer_Inventory].[MSClusterNetworkInterface] ClusterNetworkInterface left outer join
		[ServerScan_20161021].[WinServer_Inventory].[MSClusterCluster] ClusterName
		ON ClusterNetworkInterface.DeviceNumber = ClusterName.DeviceNumber