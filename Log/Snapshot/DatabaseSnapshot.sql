---------------------------------------------------------------------
/*
SQL Server 2017 در High Availability دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
USE Northwind
GO
--مشاهده فایل های مربوط به بانک اطلاعاتی
SP_HELPFILE
GO
SELECT name,physical_name FROM SYS.database_files
GO
--------------------------------------------------------------------
USE master
GO
--از بانک اطلاعاتی SnapShot ایجاد یک 
CREATE DATABASE Snapshot_Northwind 
ON
(
	NAME=Northwind,
	FILENAME='C:\DUMP\NEW_Northwind_1392.SS'
)AS SNAPSHOT OF Northwind
GO
--NTFS بررسی فایل ایجاد شده در 
--------------------------------------------------------------------
--Database Snapshot بررسی نمونه ای از محدودیت های 
USE MASTER
GO
EXEC sp_detach_db 'Northwind'
EXEC sp_detach_db 'Snapshot_Northwind'
GO
DROP DATABASE Northwind 
--DROP DATABASE Snapshot_Northwind 
GO
BACKUP DATABASE Snapshot_Northwind
	TO DISK='C:\DUMP\DUMP\Snapshot_Northwind.BAK' 
WITH FORMAT,COMPRESSION
GO
--------------------------------------------------------------------
USE Northwind 
GO
--تغییر ساختار یکی از فیلدهای جداول
SP_HELP Customers
ALTER TABLE  Customers ALTER COLUMN CompanyName NVARCHAR(150)
GO
---------------------می گیریم Snapshot سال 1394 تمام شده و ما یک 
CREATE DATABASE Northwind_1394
ON
(
	NAME=Northwind,
	FILENAME='C:\DUMP\Northwind_1394.SS'
)AS SNAPSHOT OF Northwind
GO
--------------------------------------------------------------------
----------------------تغییرات سال 1395  
USE Northwind
GO
SELECT * FROM Customers
UPDATE Customers SET CompanyName+='1395*'
SELECT * FROM Customers
GO
--Object Explorer با استفاده از Snapshotواکشی داده های موجود در 
GO
--می گیریم Snapshot پایان سال 1395 ما یک 
CREATE DATABASE Northwind_1395
ON
(
	NAME=Northwind,
	FILENAME='C:\DUMP\Northwind_1395.SS'
)AS SNAPSHOT OF Northwind
GO
--------------------------------------------------------------------
----------------------تغییرات سال 1396  
USE Northwind
GO
SELECT * FROM Customers
UPDATE Customers SET CompanyName+='1396*'
SELECT * FROM Customers
GO
--Object Explorer با استفاده از Snapshotواکشی داده های موجود در 
GO
--می گیریم Snapshot پایان سال 1396 ما یک 
CREATE DATABASE Northwind_1396
ON
(
	NAME=Northwind,
	FILENAME='C:\DUMP\Northwind_1396.SS'
)AS SNAPSHOT OF Northwind
GO
--------------------------------------------------------------------
----------------------تغییرات سال 1397  
USE Northwind
GO
SELECT * FROM Customers
UPDATE Customers SET CompanyName+='1397*'
SELECT * FROM Customers
GO
--Object Explorer با استفاده از Snapshotواکشی داده های موجود در 
GO
--می گیریم Snapshot پایان سال 1397 ما یک 
CREATE DATABASE Northwind_1397
ON
(
	NAME=Northwind,
	FILENAME='C:\DUMP\Northwind_1397.SS'
)AS SNAPSHOT OF Northwind
GO
--------------------------------------------------------------------
--بررسی تغییرات در سال های مختلف

--آخرین وضعیت در بانک اطلاعاتی اصلی
SELECT * FROM Northwind..Customers WHERE CustomerID='Alfki'
GO
--وضعیت رکوردهای در سال های مختلف
SELECT '1394',* FROM Northwind_1394..Customers WHERE CustomerID='Alfki'
SELECT '1395',* FROM Northwind_1395..Customers WHERE CustomerID='Alfki'
SELECT '1396',* FROM Northwind_1396..Customers WHERE CustomerID='Alfki'
SELECT '1397',* FROM Northwind_1397..Customers WHERE CustomerID='Alfki'
GO
--------------------------------------------------------------------
--Database Snapshot کردن بانک اطلاعاتی اصلی از روی Restore 
USE MASTER
GO
--Restore شروع عملیات
RESTORE DATABASE Northwind 
	FROM DATABASE_SNAPSHOT ='Northwind_1394'
GO
--ها Database Snapshot حذف 
DROP DATABASE Northwind_1395
DROP DATABASE Northwind_1396
DROP DATABASE Northwind_1397
GO
--Restore شروع عملیات
RESTORE DATABASE Northwind 
	FROM DATABASE_SNAPSHOT ='Northwind_1394'
GO
SELECT * FROM Northwind.dbo.Customers
GO
--------------------------------------------------------------------
USE master
GO
IF DB_ID('NikAmoozDB')>0
BEGIN
	ALTER DATABASE NikAmoozDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB
END
GO
--ایجاد بانک اطلاعاتی با یک فایل گروه
CREATE DATABASE NikAmoozDB
GO
--اضافه شدن یک فایل گروه جدید به بانک اطلاعاتی
ALTER DATABASE NikAmoozDB
	ADD FILEGROUP FG1
GO
ALTER DATABASE NikAmoozDB
	ADD FILEGROUP FG2
GO
--اضافه شدن یک دیتا فایل به فایل گروه جدید
ALTER DATABASE NikAmoozDB ADD FILE
	(
		name='Data_F1' , 
		FILENAME='C:\Temp\Data_F1.ndf'
	) TO FILEGROUP FG1
GO
ALTER DATABASE NikAmoozDB ADD FILE
	(
		name='Data_F2' , 
		FILENAME='C:\Temp\Data_F2.ndf'
	) TO FILEGROUP FG2
GO
USE NikAmoozDB
GO
DROP TABLE IF EXISTS Student1 
DROP TABLE IF EXISTS Student2
GO
CREATE TABLE Student1 
(
	ID INT IDENTITY PRIMARY KEY,
	FullName NVARCHAR(100)
) ON FG1
GO
CREATE TABLE Student2
(
	ID INT IDENTITY PRIMARY KEY,
	FullName NVARCHAR(100)
) ON FG1
GO
INSERT INTO Student1 
	SELECT 'A'
GO 100
INSERT INTO Student2
	SELECT 'A'
GO 100
GO
SP_HELPFILE
GO
CREATE DATABASE Snapshot_NikAmoozDB 
ON
(
	NAME=NikAmoozDB,
	FILENAME='C:\DUMP\NikAmoozDB.SS'
),
(
	NAME=Data_F1,
	FILENAME='C:\DUMP\Data_F1.SS'
),
(
	NAME=Data_F2,
	FILENAME='C:\DUMP\Data_F2.SS'
)AS SNAPSHOT OF NikAmoozDB 
GO
DROP TABLE Student1
GO
SELECT * FROM NikAmoozDB..Student1
SELECT * FROM Snapshot_NikAmoozDB..Student1
GO
USE master
GO
RESTORE DATABASE NikAmoozDB 
	FROM DATABASE_SNAPSHOT ='Snapshot_NikAmoozDB' 
GO
SELECT * FROM NikAmoozDB..Student1
SELECT * FROM Snapshot_NikAmoozDB..Student1
GO