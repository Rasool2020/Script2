--DBCC UPDATEUSAGE(0)
Go
SELECT --top 20
'Drop Index if Exists ' + QUOTENAME(s.name) + '.' + QUOTENAME(o.name) + '.' + QUOTENAME(i.name)
, o.name AS ObjectName
, i.name AS IndexName
, (dm_ius.user_seeks*2 + dm_ius.user_scans) / (dm_ius.user_updates+0.001) Score
, dm_ius.user_seeks AS UserSeek
, dm_ius.user_scans AS UserScans
, dm_ius.user_lookups AS UserLookups
, dm_ius.user_updates AS UserUpdates
, p.TableRows
, dm_ius.last_user_scan
, dm_ius.last_user_seek
, dm_ius.last_user_update
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
AND i.is_primary_key = 0
And p.TableRows > 3000
--AND i.type_desc = 'nonclustered'
--AND i.is_unique_constraint = 0
--And dm_ius.user_seeks=0
--And i.name in ('IXM_TbTourismInvoice_Price')
--And NOT i.name Like 'IXCD%'
--And NOT i.name Like 'IXC%'
--And (i.name Like 'IXM%' Or i.name Like 'IXMP%' Or i.name Like 'IXC%')
--And Not i.name Like 'IXCD%' And Not i.name Like 'IXMCD%'
--And o.name = 'AspNetUsers'
--And o.name Like '%Capa%'
And NOT o.name IS NULL
And NOT i.name IS NULL
Order By (dm_ius.user_seeks*2 + dm_ius.user_scans) / (dm_ius.user_updates+0.01), p.TableRows desc,last_user_update
Go
Drop Index if Exists [financial].[TbTourismInvoice].[IXM_TbTourismInvoice_Price]