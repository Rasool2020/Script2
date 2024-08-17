ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = OFF
Go
ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED TEMPDB_METADATA = ON
Go
EXEC sys.sp_configure N'show advanced options', 1;
RECONFIGURE WITH OVERRIDE;
EXEC sys.sp_configure N'tempdb metadata memory-optimized', 1;
RECONFIGURE WITH OVERRIDE;
Go
SELECT SERVERPROPERTY('IsTempdbMetadataMemoryOptimized');	
Go
SELECT t.[object_id], t.name
FROM tempdb.sys.all_objects AS t 
JOIN tempdb.sys.memory_optimized_tables_internal_attributes AS i
ON t.[object_id] = i.[object_id];	