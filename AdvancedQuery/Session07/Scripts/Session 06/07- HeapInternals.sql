--------------------------------------------------------------------
/*
SQL Server 2017 دوره آموزشی کوئری‌نویسی پیشرفته در 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebory 
*/
--------------------------------------------------------------------

USE WF;
GO

DROP TABLE IF EXISTS HeapTable;
GO

-- Heap ایجاد یک جدول از نوع
CREATE TABLE HeapTable
(
	ID INT,
	FirstName CHAR(3000),
	LastName CHAR(3000)
);
GO

-- بررسی ایندکس های جدول
SP_HELPINDEX HeapTable;
GO

/*
Heap مشاهده جداول
index_id = 0 (Heap)
index_id = 1 (Clustered)
index_id = 2 (NonClustered)
*/
SELECT
	OBJECT_NAME(OBJECT_ID),*
FROM sys.indexes
	WHERE index_id = 0;
GO

-- Heap مشاهده جداول
SELECT
	OBJECT_NAME(sys.tables.object_id)
FROM sys.indexes
JOIN sys.tables
	ON sys.indexes.object_ID = sys.tables.object_id
	WHERE sys.indexes.type = 0;
GO

-- بررسی صفحات جدول
DBCC IND('WF','HeapTable',1) WITH NO_INFOMSGS;
GO

--درج تعدادی رکورد تستی
INSERT INTO HeapTable(ID,FirstName,LastName)
	VALUES	(1,N'سهیلا', N'تقوی'),
			(2,N'احمد', N'شریفی'),
			(3,N'رضا', N'کرمی'),
			(4,N'پریسا', N'سعادت'),
			(5,N'سهیل', N'عباس‌پور');
GO

--بررسی صفحات جدول
DBCC IND('WF','HeapTable',1) WITH NO_INFOMSGS;
GO

/*
IAM کلیه آدرس صفحات در 
عدم وجود ارتباط مابین صفحات
*/
SELECT 
	*
FROM sys.dm_db_database_page_allocations
	(
		DB_ID('WF'), OBJECT_ID('HeapTable'),
		NULL, NULL, 'DETAILED'
	)
	WHERE page_type_desc = 'DATA_PAGE';
GO