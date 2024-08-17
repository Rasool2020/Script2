SELECT 
	OBJECT_SCHEMA_NAME(object_id) AS schema1
	,OBJECT_NAME(object_id) AS 'Temporal Table'
	,OBJECT_SCHEMA_NAME(history_table_id) AS schema2
	,OBJECT_NAME(history_table_id) AS 'History Table'
	,'Alter Table ' + OBJECT_SCHEMA_NAME(object_id) + '.' + OBJECT_NAME(object_id) + ' SET (SYSTEM_VERSIONING = OFF)'
	,'Truncate Table ' + OBJECT_SCHEMA_NAME(history_table_id) + '.' + OBJECT_NAME(history_table_id)
FROM sys.tables
WHERE temporal_type = 2