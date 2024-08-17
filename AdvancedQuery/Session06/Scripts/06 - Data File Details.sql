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

-- Data File بررسی جزئیات

-- بررسی جهت وجود دیتابیس و حذف آن 
DROP DATABASE IF EXISTS TestDataFile;
GO

-- ایجاد دیتابیس
CREATE DATABASE TestDataFile;
GO 

USE TestDataFile;
GO

-- Test01 مشاهده مشخصات دیتابیس
SELECT * FROM sys.sysfiles;
GO

EXEC SP_HELPFILE;
GO

DROP TABLE IF EXISTS Students;
GO

-- Students ایجاد جدول
CREATE TABLE Students
(
	FirstName NVARCHAR(100), 
	LastName NVARCHAR(100), 
	Age INT
);
GO

-- Students درج رکورد در جدول
INSERT INTO Students 
	VALUES	(N'علی', N'سعیدی', 25),
			(N'سمیرا', N'شایان', 22);
GO

-- Students مشاهده رکوردهای جدول
SELECT * FROM Students;
GO

SELECT
	OBJECT_NAME(OBJECT_ID),*
FROM SYS.indexes 
	WHERE OBJECT_ID = OBJECT_ID('Students');
GO

/*
Data File مشاهده جزئیات هر 
PageFID : Data FileID
PagePID : Page ID
*/
-- Students های تخصیص داده‌شده به جدولpage مشاهده
-- DBCC: DataBase Consistency Checker
DBCC IND ('TestDataFile', 'Students', 1);
GO

-- DBCC IND معادل 
SELECT 
	* 
FROM sys.dm_db_database_page_allocations
	(
		DB_ID('TestDataFile'), OBJECT_ID('Students'),
		NULL, NULL, 'DETAILED'
	);
GO

-- .ای قرار داردPageهر رکورد در چه 
SELECT 
	sys.fn_PhysLocFormatter (%%physloc%%) AS [Physical RID], * 
FROM Students;
GO

SELECT * FROM Students AS S 
	CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%) AS FPLC
ORDER BY FPLC.file_id, FPLC.page_id, FPLC.slot_id;
GO

-- students مشاهده محتوای جدول
DBCC TRACEON (3604);
DBCC PAGE ('TestDataFile', 1, ???, 3);
GO
--------------------------------------------------------------------

/*
Show Page Information

DBCC IND ( { 'dbname' | dbid }, { 'objname' | objid }, { nonclustered indid | 1 | 0 | -1 | -2 });
nonclustered indid = non-clustered Index ID 
1 = Clustered Index ID 
0 = Displays information in-row data pages and in-row IAM pages (from Heap) 
-1 = Displays information for all pages of all indexes including LOB (Large object binary) pages and row-overflow pages 
-2 = Displays information for all IAM pages
/*
1= data page
2= index page
3 and 4 = text pages
8 = GAM page
9 = SGAM page
10 = IAM page
11 = PFS page


DBCC PAGE ( {'dbname' | dbid}, filenum, pagenum [, printopt={0|1|2|3} ]);Printopt:
0 - print just the page header
1 - page header plus per-row hex dumps and a dump of the page slot array 
2 - page header plus whole page hex dump
3 - page header plus detailed per-row interpretation
*/