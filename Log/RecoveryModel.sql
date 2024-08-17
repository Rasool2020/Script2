--Recovery Model بررسی 
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
--بانک اطلاعاتی جاری و سایر بانک های اطلاعاتیRecovery Model مشاهده 
--بانک های اطلاعاتی سیستمیRecovery Model مشاهده 
SELECT 
	database_id,name,recovery_model_desc 
FROM SYS.databases
WHERE name='TestDB'
GO
-------------------------------
--چند کوئری مهم و کاربردی
GO
--Log File مشاهده وضعیت استفاده از 
DBCC SQLPERF('LOGSPACE')
GO
USE TestDB
GO
--مشاهده ظرفیت فایل های بانک اطلاعاتی
SP_HELPFILE
GO
SELECT 
	name,
	type_desc,
	physical_name,
	CAST((size*8.0/1024) AS DECIMAL(18,2))AS Size_MB,
	max_size
FROM SYS.database_files
GO
--log_reuse_wait مشاهده وضعیت 
SELECT 
	name ,
	recovery_model_desc ,
	log_reuse_wait_desc
FROM	sys.databases
WHERE	name = 'TestDB'
GO
--------------------------------------------------------------------
--Simple Recovery Model بررسی 
GO
--Simple به حالت Recovery Model تنظیم 
ALTER DATABASE TestDB SET RECOVERY SIMPLE
GO
--Recovery Model مشاهده وضعیت
SELECT 
	database_id,name,recovery_model_desc 
FROM SYS.databases
WHERE name='TestDB'
GO
--مشاهده اندازه فایل ها و
SP_HELPFILE
GO
--Log File مشاهده وضعیت استفاده از 
--چندین مرتبه اجرا شود
DBCC SQLPERF('LOGSPACE')
GO
--SQLQueryStress 10000, 100
INSERT TestTable(C2,C3) VALUES (N'T1',N'T11')
GO
--استفاده از کانترهای زیر
/*
MSSQLSERVER: Databases :Log File Size(KB)
MSSQLSERVER: Databases :Log File Used Size(KB)
MSSQLSERVER: Databases :Percent Log Used
*/
GO
-------------------------------
--Full Recovery Model بررسی 
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
--Recovery Model مشاهده وضعیت
SELECT 
	database_id,name,recovery_model_desc 
FROM SYS.databases
WHERE name='TestDB'
GO
--Full Backup شروع زنجیره لاگ با اولین 
BACKUP DATABASE TestDB TO DISK='C:\Temp\TestDB_Full.bak' WITH FORMAT
GO
--ایجاد یک جدول جدید
DROP TABLE IF EXISTS TestTable
GO
CREATE TABLE TestTable
(
	C1 INT IDENTITY PRIMARY KEY,
	C2 CHAR(4000),
	C3 NVARCHAR(4000)
)
GO
--مشاهده اندازه فایل ها و
SP_HELPFILE
GO
--Log File مشاهده وضعیت استفاده از 
--چندین مرتبه اجرا شود
DBCC SQLPERF('LOGSPACE')
GO
--SQLQueryStress 10000, 100
INSERT TestTable(C2,C3) VALUES (N'T1',N'T11')
GO
--استفاده از کانترهای زیر
/*
MSSQLSERVER: Databases :Log File Size(KB)
MSSQLSERVER: Databases :Log File Used Size(KB)
MSSQLSERVER: Databases :Percent Log Used
*/
GO
BACKUP LOG TestDB TO DISK='C:\Temp\TestDB_LOG.bak' WITH FORMAT
BACKUP LOG TestDB TO DISK='C:\Temp\TestDB_LOG.bak'
GO
-------------------------------