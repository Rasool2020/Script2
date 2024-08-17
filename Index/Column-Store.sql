SELECT top 2221
    t.NAME AS TableName,
    s.Name AS SchemaName,
    SUM(p.rows) AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB,
	'if not exists(Select 1 From sysindexes Where name=''IXMC_' + t.name + ''') ' + 
	'CREATE COLUMNSTORE INDEX [IXMC_' + t.name + '] ON [' + s.Name + '].[' + t.name + '] (' + 
	c.columnName + ') WITH (COMPRESSION_DELAY = 0)'
FROM sys.tables t
JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
--JOIN sys.columns c on i.object_id = c.object_id
Join (Select STRING_AGG(QUOTENAME(c.name), ',') columnName, object_id From sys.columns c 
	Where 1=1
	--And not c.name in ('registerdate', 'enteranceID', 'insertUserID', 'agregisterdate', '') 
	And not user_type_id in (34, 35, 167, 231, 165)
	Group By c.object_id) c on c.object_id=i.object_id
JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
JOIN sys.allocation_units a ON p.partition_id = a.container_id
LEFT JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE 1=1 --And t.NAME NOT LIKE 'dt%' --And t.is_ms_shipped = 0 
	AND i.OBJECT_ID > 255 
	--AND p.rows>=0 and p.rows<20000
	--And not t.name in ('__MigrationHistory', '__RefactorLog', 'AggregatedCounter', 'cdc_states', 'GetUserOrders2', 'tb1', 'tb2', 'TbFlightProvider_07_28', 'SqlServerVersions', 'Sp_SearchHotelsBasedOnRegionParam', 'TbHotelRoomCapacity_Back', 'TbHotelRoomCapacity_Backup', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '')
	And not t.name Like '%bak'
	And not t.name Like '%Params'
	And not t.name Like '%old'
	And not t.name Like 'sys%'
	And not t.name Like 'tmp%'
	And not s.Name in ('HangFire')
	--AND t.NAME>'customer'
	--AND t.NAME='IX_t107ProjectNumberPriority'
	--AND not i.object_id in (Select object_id from sys.indexes Where type_desc in ('NONCLUSTERED COLUMNSTORE','CLUSTERED COLUMNSTORE'))
GROUP BY t.Name, s.Name, c.columnName
Having SUM(p.rows)>0 And SUM(p.rows)<20000
ORDER BY t.Name
Go

