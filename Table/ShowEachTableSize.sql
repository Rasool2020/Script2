DBCC UPDATEUSAGE(0)
Go
SELECT Top 30
	'ALTER INDEX ALL ON '+ s.Name + '.' + t.NAME + ' REBUILD WITH (FILLFACTOR = 100, SORT_IN_TEMPDB = ON, STATISTICS_NORECOMPUTE = ON);',
    s.Name AS SchemaName,
	t.NAME AS TableName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB
FROM sys.tables t
JOIN sys.indexes i ON t.OBJECT_ID = i.object_id
JOIN sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
JOIN sys.allocation_units a ON p.partition_id = a.container_id
LEFT JOIN sys.schemas s ON t.schema_id = s.schema_id
WHERE t.NAME NOT LIKE 'dt%' AND t.is_ms_shipped = 0 AND i.OBJECT_ID > 255 
	--And not t.NAME  in ('t00Date','t00Region','t00RegionParent','t33Setting','','','','','')
GROUP BY t.Name, s.Name, p.Rows
--ORDER BY p.rows desc
ORDER BY SUM(a.total_pages) desc,t.Name