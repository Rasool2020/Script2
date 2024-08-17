Select OBJECT_SCHEMA_NAME(o.object_id) SchemaName, o.name as ObjName, r.name as ReferencedObj
from sys.sql_dependencies d
join sys.objects o on o.object_id=d.object_id
join sys.objects r on r.object_id=d.referenced_major_id
where d.class=1
AND r.name = 'TbPassenger'