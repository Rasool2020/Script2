SELECT 
	OBJECT_NAME(ios.object_id) AS table_name
	,i.name AS index_name
	,ios.row_lock_count
	,ios.row_lock_wait_count
	,ios.row_lock_wait_in_ms
FROM sys.dm_db_index_operational_stats(DB_ID(),OBJECT_ID('Sales.SalesOrderDetail'),NULL,NULL) ios
JOIN sys.indexes i
ON i.object_id = ios.object_id
AND i.index_id = ios.index_id
ORDER BY ios.row_lock_wait_count DESC
GO
-----------------------
--Page Lock :هنگام دسترسی به ایندکس اگر تعدادی قفل به ازای صفحه ایجاد شود در این فیلد مشخص می شود
GO
SELECT 
	OBJECT_NAME(ios.object_id) AS table_name
	,i.name AS index_name
	,ios.page_lock_count
	,ios.page_lock_wait_count
	,ios.page_lock_wait_in_ms
	,ios.range_scan_count
FROM sys.dm_db_index_operational_stats(DB_ID(),OBJECT_ID('Sales.SalesOrderDetail'),NULL,NULL) ios
JOIN sys.indexes i
ON i.object_id = ios.object_id
AND i.index_id = ios.index_id
ORDER BY ios.range_scan_count DESC
GO
-----------------------
--Lock Escalation : صعود قفل
--Lock Granularity سطوح قفل گذاری
USE AdventureWorks2017
GO
--به روز کردن تعدادی رکورد
UPDATE Sales.SalesOrderDetail SET 
	ProductID = ProductID
WHERE ProductID <= 712
GO
SELECT 
	OBJECT_NAME(ios.object_id) AS table_name
	,i.name AS index_name
	,ios.index_lock_promotion_attempt_count
	,ios.index_lock_promotion_count
FROM sys.dm_db_index_operational_stats(DB_ID(),OBJECT_ID('Sales.SalesOrderDetail'),NULL,NULL) ios
JOIN sys.indexes i 
	ON i.object_id = ios.object_id AND i.index_id = ios.index_id
ORDER BY 
	ios.range_scan_count DESC
GO