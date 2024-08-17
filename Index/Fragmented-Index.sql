SELECT dbschemas.[name] as 'Schema',
dbtables.[name] as 'Table',
dbindexes.[name] as 'Index',
indexstats.avg_fragmentation_in_percent,
indexstats.page_count
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
JOIN sys.tables dbtables on dbtables.[object_id] = indexstats.[object_id]
JOIN sys.schemas dbschemas on dbtables.[schema_id] = dbschemas.[schema_id]
JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
AND indexstats.index_id = dbindexes.index_id
WHERE indexstats.database_id = DB_ID()
	--and dbtables.[name]='t00Notification'
	and indexstats.avg_fragmentation_in_percent>40
	And not dbindexes.[name] is null
ORDER BY indexstats.page_count desc 
Go
SELECT 'ALTER INDEX ' + dbindexes.[name] + ' ON ' + dbschemas.[name] + '.' + dbtables.[name] + ' REBUILD PARTITION=ALL WITH (STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=ON, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON)'
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstats
JOIN sys.tables dbtables on dbtables.[object_id]=indexstats.[object_id]
JOIN sys.schemas dbschemas on dbtables.[schema_id]=dbschemas.[schema_id]
JOIN sys.indexes AS dbindexes ON dbindexes.[object_id]=indexstats.[object_id]
AND indexstats.index_id=dbindexes.index_id
WHERE indexstats.database_id=DB_ID()
	--and dbtables.[name]='t00Notification'
	And indexstats.avg_fragmentation_in_percent>20
	And not dbindexes.[name] is null
ORDER BY indexstats.page_count Desc 