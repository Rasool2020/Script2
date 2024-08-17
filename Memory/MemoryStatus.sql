--SQL Server مشاهده قسمت های مختلف حافظه در 
DBCC MemoryStatus
GO
---------------------
--به ازای هر بانک اطلاعاتی Buffer Pool مشاهده فضای تخصیص داده شده در 
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
SELECT
	TYPE,
	SUM(virtual_memory_reserved_kb) AS [VM Reserved],
	SUM(virtual_memory_committed_kb) AS [VM Committed],
	SUM(awe_allocated_kb) AS [AWE Allocated],
	SUM(shared_memory_reserved_kb) AS [SM Reserved],
	SUM(shared_memory_committed_kb) AS [SM Committed],
	-- SUM(multi_pages_kb) AS [MultiPage Allocator],          /*Applies to: SQL Server 2008 (10.0.x) through SQL Server 2008 R2 (10.50.x).*/
	-- SUM(single_pages_kb) AS [SinlgePage Allocator],        /*Applies to: SQL Server 2008 (10.0.x) through SQL Server 2008 R2 (10.50.x).*/
	SUM(pages_kb) AS [Page Allocated]                      /*Applies to: SQL Server 2012 (11.x) and later.*/
FROM
sys.dm_os_memory_clerks
GROUP BY TYPE
Order By SUM(pages_kb) Desc