DBCC UPDATEUSAGE(0)
Go
SELECT distinct
    t.NAME AS TableName,
    p.rows AS RowCounts
FROM 
    sys.tables t with(nolock)
 JOIN      
    sys.indexes i  with(nolock) ON t.OBJECT_ID = i.object_id
 JOIN 
    sys.partitions p  with(nolock) ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
 JOIN 
    sys.allocation_units a  with(nolock) ON p.partition_id = a.container_id
 LEFT JOIN 
    sys.schemas s  with(nolock) ON t.schema_id = s.schema_id
WHERE 
    t.NAME NOT LIKE 'dt%' 
    AND t.is_ms_shipped = 0
    AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows,a.total_pages
ORDER BY 
     p.rows desc,t.Name

