sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'max server memory', 32768;   -- for 32 GB
GO  
RECONFIGURE;  
GO
Select is_memory_optimized,*
from sys.tables
where is_memory_optimized=1
Go
Select *
from t00ProcessActiveBranch
Go
;WITH src AS
(
	SELECT
		database_id, db_buffer_pages = COUNT_BIG(*)
		FROM sys.dm_os_buffer_descriptors
		GROUP BY database_id
)
SELECT
	[db_name] = CASE [database_id] WHEN 32767
		THEN 'Resource DB'
		ELSE DB_NAME([database_id]) END,
	db_buffer_pages,
	db_buffer_MB = CAST(db_buffer_pages / 128.0 AS DECIMAL(6,2))
FROM src
ORDER BY db_buffer_MB DESC;
GO


