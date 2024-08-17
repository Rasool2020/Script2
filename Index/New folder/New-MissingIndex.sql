Select OBJECT_NAME(we.object_id)      AS table_name, COALESCE(we.name, SPACE(0)) indexName,
       -- 'ALTER INDEX ' + COALESCE(we.name, SPACE(0)) + ' ON ' + OBJECT_NAME(we.object_id) + ' DISABLE '     AS index_name,
       ps.partition_number,
       ps.row_count,
       CAST((ps.reserved_page_count * 8) / 1024. AS DECIMAL(12, 2)) AS size_in_mb,
       COALESCE(ius.user_seeks, 0)    AS user_seeks,
       COALESCE(ius.user_scans, 0)    AS user_scans,
       COALESCE(ius.user_lookups, 0)  AS user_lookups,
	   ius.user_updates AS UserUpdates,
       we.type_desc
from sys.indexes we
JOIN sys.dm_db_partition_stats ps
            ON we.object_id = ps.object_id
            AND we.index_id = ps.index_id
       LEFT JOIN sys.dm_db_index_usage_stats ius
            ON  ius.database_id = DB_ID()
            AND we.object_id = ius.
                OBJECT_ID
            AND we.index_id = ius.
                index_id
where 1=1
	--And name in ('IX_FinancialTransaction_operationType', 'IXM_t08project_t08customerStateID')
	And OBJECT_NAME(we.object_id)='t08Project'
Go
sp_helpindex [t08Project] 
