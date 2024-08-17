ALTER DATABASE sepideh  
SET RECOVERY SIMPLE;  
GO  
-- Shrink the truncated log file to 1 MB.  
DBCC SHRINKFILE (dbTotalTPR84_Log, 1); 
SELECT name, database_id, log_reuse_wait, log_reuse_wait_desc FROM sys.databases