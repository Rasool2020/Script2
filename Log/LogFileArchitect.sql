--بررسی معماری منطقی و فیزیکی لاگ فایل 
GO
--ایجاد یک بانک اطلاعاتی جدید
USE master
GO
IF DB_ID('TestDB')>0
BEGIN
	ALTER DATABASE TestDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE TestDB
END
GO
CREATE DATABASE TestDB
GO
USE TestDB
GO
--ایجاد یک جدول جدید
DROP TABLE IF EXISTS TestTable
GO
CREATE TABLE TestTable
(
	C1 INT IDENTITY PRIMARY KEY,
	C2 NVARCHAR(10),
	C3 NVARCHAR(10)
)
GO
INSERT TestTable(C2,C3) VALUES (N'T1',N'T11')
GO
-------------------------------
--مشاهده معماری منطقی
GO
--هاVLF مشاهده
--معماری منطقی لاگ فایل
DBCC LOGINFO
GO
/*
Status	:
	There are 2 possible values 0 and 2. 
	2 means that the VLF cannot be reused and 
	0 means that it is ready for re-use.
Parity	:
	There are 2 possible values 64 and 128.
CreateLSN	:
	This is the LSN when the VLF was created. 
	If the createLSN is 0, it means it was created 
	when the physical transaction log file was created.
*/
--SQL SERVER 2017 اضافه شده در 
SELECT 
	* 
FROM sys.dm_db_log_info(DEFAULT)
GO
SELECT TOP 1 
	DB_NAME(database_id) AS "Database Name",file_id,
	vlf_size_mb,vlf_sequence_number, 
	vlf_active, vlf_status
FROM sys.dm_db_log_info(DEFAULT)
ORDER BY vlf_sequence_number desc
GO
--آنها بیش از 100 عدد استVLF مشاهده بانک اطلاعاتی هایی که تعداد
--Log Fragmentation
SELECT 
	NAME,COUNT(l.database_id) as 'VLF_Count' 
FROM sys.databases s
CROSS APPLY sys.dm_db_log_info(s.database_id) l
GROUP BY NAME
HAVING COUNT(l.database_id)> 100
GO
-------------------------------
USE master
GO
--مشاهده درایوهای موجود در سیستم عامل سرور
XP_FIXEDDRIVES
GO
--SQL SERVER 2017 امکان استفاده در
SELECT * FROM sys.dm_os_enumerate_fixed_drives;
GO
-------------------------------
--برای تنظیم اندازه لاگ فایل Best Practice بررسی یک 
USE master
GO
IF DB_ID('TestDB')>0
BEGIN
	ALTER DATABASE TestDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE TestDB
END
GO
--64MB ساخت بانک اطلاعاتی با اندازه پیش فرض و تنظیم رشد
CREATE DATABASE TestDB
 ON  PRIMARY 
( 
	NAME = N'TestDB',
	FILENAME = N'C:\Temp\TestDB.mdf' ,
	SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB 
)
LOG ON 
( 
	NAME = N'TestDB_log',
	FILENAME = N'C:\Temp\TestDB_log.ldf' ,
	SIZE = 8192KB , MAXSIZE = 2048GB, FILEGROWTH = 65536KB 
)
GO
USE TestDB
GO
--بررسی اندازه فایل ها و نحوه رشد آنها
SP_HELPFILE
GO
--ها VLF مشاهده تعداد
-- 4=ها در هنگام ایجاد VLF تعداد 
SELECT 
	* 
FROM sys.dm_db_log_info(DEFAULT)
GO
--ساخت جداول بزرگ برای افزایش حجم بانک اطلاعاتی
DROP TABLE IF EXISTS TestTable
GO
CREATE TABLE TestTable
(
	C1 INT IDENTITY PRIMARY KEY,
	C2 CHAR(4000),
	C3 CHAR(4000)
)
GO
--ها کنترل شودVLF حدود 7 الی 8 بار اجرا و هر بار تعداد 
INSERT TestTable(C2,C3) VALUES (NULL,NULL)
GO 1000
--ها VLF مشاهده تعداد
SELECT 
	* 
FROM sys.dm_db_log_info(DEFAULT)
GO
/*
لاگ فایل پیش فرض تنظیم شده سیستم Initial Size , File Growth چون 
می شود و این موضوع باعث بوجود آمدن مشکل VLF مجبور به ساخت 
باعث کاهش کارایی می شودHA می شود که برای سناریوهای Log Fragmentation
راه حل رفع مشکل در ادامه
*/
USE master
GO
IF DB_ID('TestDB')>0
BEGIN
	ALTER DATABASE TestDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE TestDB
END
GO
--ساخت بانک اطلاعاتی و تنظیم اعداد مناسب برای لاگ فایل 
CREATE DATABASE TestDB
 ON  PRIMARY 
( 
	NAME = N'TestDB',
	FILENAME = N'C:\Temp\TestDB.mdf' ,
	SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB 
)
LOG ON 
( 
	NAME = N'TestDB_log',
	FILENAME = N'C:\Temp\TestDB_log.ldf' ,
	SIZE = 1GB , MAXSIZE = 2048GB, FILEGROWTH = 1GB 
)
GO
USE TestDB
GO
--بررسی اندازه فایل ها و نحوه رشد آنها
SP_HELPFILE
GO
--ها VLF مشاهده تعداد
-- 8=ها در هنگام ایجاد VLF تعداد 
SELECT 
	* 
FROM sys.dm_db_log_info(DEFAULT)
GO
--ساخت جداول بزرگ برای افزایش حجم بانک اطلاعاتی
DROP TABLE IF EXISTS TestTable
GO
CREATE TABLE TestTable
(
	C1 INT IDENTITY PRIMARY KEY,
	C2 CHAR(4000),
	C3 CHAR(4000)
)
GO
--ها کنترل شودVLF حدود 7 الی 8 بار اجرا و هر بار تعداد 
INSERT TestTable(C2,C3) VALUES (NULL,NULL)
GO 1000
--ها VLF مشاهده تعداد
SELECT 
	* 
FROM sys.dm_db_log_info(DEFAULT)
GO
/*
< 64MB there will be 4 new VLFs (each 1/4 of growth size)
64MB to 1GB there will be 8 new VLFs (each 1/8 of growth size)
> 1GB there will be 16 new VLFs (each 1/16 of growth size)
*/
-------------------------------
--مشاهده معماری فیزیکی
ALTER DATABASE TestDB SET RECOVERY SIMPLE
GO
CHECKPOINT
GO
--مشاهده محتوای لاگ رکوردها
SELECT * FROM SYS.fn_dblog(NULL,NULL)
GO
--ایجاد یک رکورد جدید
INSERT TestTable(C2,C3) VALUES (N'T2',N'T22')
GO
--مشاهده محتوای لاگ رکوردها
--Online Log File
SELECT * FROM SYS.fn_dblog(NULL,NULL)
GO
-------------------------------
--ایجاد یک رکورد جدید
INSERT TestTable(C2,C3) VALUES (N'T3',N'T33')
GO
--رکورد کجا درج شده است
SELECT
	[Transaction ID], [Current LSN], [Transaction Name], 
	[Operation],  [Context],[AllocUnitName],[Begin Time],
	[End Time], [Transaction SID],[Num Elements] ,
	[RowLog Contents 0],[RowLog Contents 1],
	[RowLog Contents 2],[RowLog Contents 3]
FROM fn_dblog (NULL, NULL)
 WHERE [Transaction ID] IN 
	(
		SELECT 
			[Transaction ID] 
		FROM fn_dblog (null,null) 
		WHERE [Transaction Name] = 'INSERT'
	)
GO
-------------------------------
--مشاهده لاگ رکوردهای موجود در یک لاگ بکاپ
--دارای 68 پارامتر می باشد
SELECT  * FROM fn_dump_dblog
(
	NULL,NULL,'DISK',1,'C:\Temp1\TestDB_log.trn'
	,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
	,NULL,NULL,NULL,NULL,   NULL,NULL,NULL,NULL,NULL,NULL
	,NULL,NULL,NULL,NULL,   NULL,NULL,NULL,NULL,NULL,NULL
	,NULL,NULL,NULL,NULL,   NULL,NULL,NULL,NULL,NULL,NULL
	,NULL,NULL,NULL,NULL,   NULL,NULL,NULL,NULL,NULL,NULL
	,NULL,NULL,NULL,NULL,   NULL,NULL,NULL,NULL,NULL,NULL
	,NULL,NULL,NULL,NULL
)
GO
-------------------------------
