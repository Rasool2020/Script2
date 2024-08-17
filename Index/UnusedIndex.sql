SELECT sqlserver_start_time FROM sys.dm_os_sys_info
Go
SELECT TOP 55
o.name AS ObjectName
, i.name AS IndexName
, i.index_id AS IndexID
, dm_ius.user_seeks + dm_ius.user_scans + dm_ius.user_lookups / (dm_ius.user_updates+0.1)
, dm_ius.user_seeks AS UserSeek
, dm_ius.user_scans AS UserScans
, dm_ius.user_lookups AS UserLookups
, dm_ius.user_updates AS UserUpdates
, p.TableRows
, 'DROP INDEX ' + QUOTENAME(i.name)
+ ' ON ' + QUOTENAME(s.name) + '.'
+ QUOTENAME(OBJECT_NAME(dm_ius.OBJECT_ID)) AS 'Drop Statement'
FROM sys.dm_db_index_usage_stats dm_ius
JOIN sys.indexes i ON i.index_id = dm_ius.index_id 
AND dm_ius.OBJECT_ID = i.OBJECT_ID
JOIN sys.objects o ON dm_ius.OBJECT_ID = o.OBJECT_ID
JOIN sys.schemas s ON o.schema_id = s.schema_id
JOIN (SELECT SUM(p.rows) TableRows, p.index_id, p.OBJECT_ID
FROM sys.partitions p GROUP BY p.index_id, p.OBJECT_ID) p
ON p.index_id = dm_ius.index_id AND dm_ius.OBJECT_ID = p.OBJECT_ID
WHERE OBJECTPROPERTY(dm_ius.OBJECT_ID,'IsUserTable') = 1
AND dm_ius.database_id = DB_ID()
AND i.type_desc = 'nonclustered'
AND i.is_primary_key = 0
AND i.is_unique_constraint = 0
And dm_ius.user_updates > 0
And p.TableRows > 13000
--And i.name in ('IX_DetailedAccountRef', 'IX_FlightRef' , 'IX_TourismInvoice_FlightRef', 'IX_HotelBookingRef', 'IX_CreatedByUserRef', 'IX_HotelBookingRoomRef', 'IX_HotelBookingRef' ,'IX_EntityRef')
--And i.name like 'IXM%'
--And p.TableRows > 100000
--And dm_ius.user_updates>10000
ORDER BY (dm_ius.user_seeks + dm_ius.user_scans + dm_ius.user_lookups) ASC, dm_ius.user_updates desc
GO
SELECT TOP 25
o.name AS ObjectName
, i.name AS IndexName
, i.index_id AS IndexID
, dm_ius.user_seeks + dm_ius.user_scans + dm_ius.user_lookups totalSeeks
, (cast(dm_ius.user_seeks as money) + dm_ius.user_scans + dm_ius.user_lookups) / (dm_ius.user_updates + 0.1)
, dm_ius.user_seeks AS UserSeek
, dm_ius.user_scans AS UserScans
, dm_ius.user_lookups AS UserLookups
, dm_ius.user_updates AS UserUpdates
, p.TableRows
, 'DROP INDEX ' + QUOTENAME(i.name)
+ ' ON ' + QUOTENAME(s.name) + '.'
+ QUOTENAME(OBJECT_NAME(dm_ius.OBJECT_ID)) AS 'Drop Statement'
FROM sys.dm_db_index_usage_stats dm_ius
JOIN sys.indexes i ON i.index_id = dm_ius.index_id 
AND dm_ius.OBJECT_ID = i.OBJECT_ID
JOIN sys.objects o ON dm_ius.OBJECT_ID = o.OBJECT_ID
JOIN sys.schemas s ON o.schema_id = s.schema_id
JOIN (SELECT SUM(p.rows) TableRows, p.index_id, p.OBJECT_ID
FROM sys.partitions p GROUP BY p.index_id, p.OBJECT_ID) p
ON p.index_id = dm_ius.index_id AND dm_ius.OBJECT_ID = p.OBJECT_ID
WHERE OBJECTPROPERTY(dm_ius.OBJECT_ID,'IsUserTable') = 1
AND dm_ius.database_id = DB_ID()
AND i.type_desc = 'nonclustered'
AND i.is_primary_key = 0
AND i.is_unique_constraint = 0
--And i.name like 'IXM%'
And p.TableRows > 7000
--ORDER BY (dm_ius.user_seeks + dm_ius.user_scans + dm_ius.user_lookups) ASC
Order By (cast(dm_ius.user_seeks as money) + dm_ius.user_scans + dm_ius.user_lookups) / (dm_ius.user_updates + 0.1)
Go
SELECT
    objects.name AS Table_name,
    indexes.name AS Index_name,
    dm_db_index_usage_stats.user_seeks,
    dm_db_index_usage_stats.user_scans,
	dm_db_index_usage_stats.user_lookups,
    dm_db_index_usage_stats.user_updates,
	'DROP INDEX ' + QUOTENAME(indexes.name)
+ ' ON ' + QUOTENAME(object_schema_name(objects.object_id)) + '.'
+ QUOTENAME(OBJECT_NAME(dm_db_index_usage_stats.OBJECT_ID)) AS 'drop statement'
FROM
    sys.dm_db_index_usage_stats
    JOIN sys.objects ON dm_db_index_usage_stats.OBJECT_ID = objects.OBJECT_ID
    JOIN sys.indexes ON indexes.index_id = dm_db_index_usage_stats.index_id AND dm_db_index_usage_stats.OBJECT_ID = indexes.OBJECT_ID
WHERE
	1=1
	And NOT indexes.name Like 'PK%'
    --AND dm_db_index_usage_stats.user_lookups <> 0
	AND dm_db_index_usage_stats.user_seeks = 0
    AND dm_db_index_usage_stats.user_scans = 0
ORDER BY
    dm_db_index_usage_stats.user_updates DESC
Go



