USE master
GO
--buffer_pool_extension بررسی وضعیت 
SELECT * FROM sys.dm_os_buffer_pool_extension_configuration
GO
--buffer_pool_extension فعال کردن
ALTER SERVER CONFIGURATION
	SET BUFFER POOL EXTENSION ON (FILENAME='E:\Dump\BufferCache.bpe',SIZE=4GB)
GO
--buffer_pool_extension بررسی وضعیت 
SELECT * FROM sys.dm_os_buffer_pool_extension_configuration
GO
--بررسی فایل ایجاد شده در مسیر مورد نظر
GO
--buffer_pool_extension غیر فعال کردن
ALTER SERVER CONFIGURATION 
	SET BUFFER POOL EXTENSION  OFF
GO
--B. Returning the number of cached pages in the buffer pool extension file
SELECT 
	COUNT(*) AS cached_pages_count
FROM sys.dm_os_buffer_descriptors
WHERE is_in_bpool_extension = 1

-- Clean buffer pool + BPE
DBCC DROPCLEANBUFFERS
GO
-- Check pages in BP for the AdventureWorks2022 database
SELECT
       CASE is_in_bpool_extension
             WHEN 1 THEN 'SSD'
             ELSE 'RAM'
       END AS location,
       COUNT(*) AS nb_pages,
       COUNT(*) * 8 / 1024 AS size_in_mb,
       COUNT(*) * 100. /(SELECT COUNT(*) FROM sys.dm_os_buffer_descriptors) AS percent_
FROM sys.dm_os_buffer_descriptors
WHERE database_id = DB_ID('AdventureWorks2022')
GROUP BY is_in_bpool_extension
GO
------------------------------------
--buffer_pool_extension بررسی کانترهای مربوط به 
SELECT 
	*
FROM sys.sysperfinfo
WHERE counter_name LIKE 'Extension%'
GO
--اعمال بار کاری
USE AdventureWorks2022
GO
EXEC sp_MSforeachtable 'SELECT * FROM ?'
GO
SELECT 
	*
FROM sys.sysperfinfo
WHERE counter_name LIKE 'Extension%'
GO