--------------------------------------------------------------------
/*
SQL Server 2017 در High Availability دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
--File Group تهیه بکاپ از 

--مثال دوم 
--می خواهیم بازیابی انجام دهیم به ازای فایل گروهی خاص 
--از بانک اطلاعاتی اصلی یک نسخه جدید ریستور کنید
--و یک فایل گروه خاص را بازیابی کنید 
--توجه داشته باشید که به فایل گروه های ریدآنلای نیاز داریم
GO
USE master
GO
IF DB_ID('TestFileGroup')>0
BEGIN
	ALTER DATABASE TestFileGroup SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE TestFileGroup
END
GO
IF DB_ID('TestFileGroup_New')>0
BEGIN
	ALTER DATABASE TestFileGroup_New SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE TestFileGroup_New
END
GO
--ایجاد بانک اطلاعاتی
CREATE DATABASE TestFileGroup
ON PRIMARY 
	( NAME = N'TestFileGroup', FILENAME = N'C:\Temp\TestFileGroup.mdf'), 
 FILEGROUP FG2010 
	( NAME = N'FG2010', FILENAME = N'C:\Temp\FG2010.ndf'), 
 FILEGROUP FG2011 
	( NAME = N'FG2011', FILENAME = N'C:\Temp\FG2011.ndf'), 
 FILEGROUP FG2012 
	( NAME = N'FG2012', FILENAME = N'C:\Temp\FG2012.ndf'), 
 FILEGROUP FG2013 
	( NAME = N'FG2013', FILENAME = N'C:\Temp\FG2013.ndf'), 
 FILEGROUP FG2014 
	( NAME = N'FG2014', FILENAME = N'C:\Temp\FG2014.ndf')
 LOG ON 
	( NAME = N'TestFileGroup_log', FILENAME = N'C:\Temp\FGRestoreTEST_log.ldf')
GO
-----------------------------------
--ایجاد جداول مربوط به بانک اطلاعاتی
USE TestFileGroup;
GO
CREATE TABLE PRIMARY_TABLE (ID INT,NAME CHAR(4)) ON [PRIMARY];
CREATE TABLE FG2010_TABLE (ID INT,NAME CHAR(4)) ON FG2010;
CREATE TABLE FG2011_TABLE (ID INT,NAME CHAR(4)) ON FG2011;
CREATE TABLE FG2012_TABLE (ID INT,NAME CHAR(4)) ON FG2012;
CREATE TABLE FG2013_TABLE (ID INT,NAME CHAR(4)) ON FG2013;
CREATE TABLE FG2014_TABLE (ID INT,NAME CHAR(4)) ON FG2014;
GO
--بررسی دیتا فایل و فایل گروه های مربوط به بانک اطلاعاتی
SP_HELPFILE
GO
SP_HELPFILEGROUP
SELECT * FROM SYS.filegroups
GO
-----------------------------------
--درج داده تستی در جداول
GO
USE TestFileGroup;
GO
INSERT INTO PRIMARY_TABLE
	SELECT 1, 'TEST'
GO 100

INSERT INTO FG2010_TABLE
	SELECT 1, 'TEST'
GO 100

INSERT INTO FG2011_TABLE
	SELECT 1, 'TEST'
GO 100

INSERT INTO FG2012_TABLE
	SELECT 1, 'TEST'
GO 100

INSERT INTO FG2013_TABLE
	SELECT 1, 'TEST'
GO 100

INSERT INTO FG2014_TABLE
	SELECT 1, 'TEST'
GO 100
-----------------------------------
--کردن فایل گروه ها ReadOnly
ALTER DATABASE TestFileGroup MODIFY FILEGROUP FG2010 READ_ONLY;
ALTER DATABASE TestFileGroup MODIFY FILEGROUP FG2011 READ_ONLY;
ALTER DATABASE TestFileGroup MODIFY FILEGROUP FG2012 READ_ONLY;
ALTER DATABASE TestFileGroup MODIFY FILEGROUP FG2013 READ_ONLY;
GO
--بودن فایل گروه ReadOnly بررسی 
SELECT 
	name,is_read_only 
FROM SYS.filegroups
GO
-----------------------------------
--تهیه فول بکاپ
USE master
GO
BACKUP DATABASE TestFileGroup TO DISK = N'C:\Temp\TestFileGroup_Full.bak'
	WITH FORMAT,COMPRESSION
GO
--بازیابی بانک اطلاعاتی با نامی دیگر
RESTORE DATABASE TestFileGroup_New FROM DISK = N'C:\Temp\TestFileGroup_Full.bak' WITH
	MOVE 'TestFileGroup' TO 'C:\Temp\TestFileGroup_New.mdf',
	MOVE 'FG2010' TO 'C:\Temp\FG2010_Dev.ndf',
	MOVE 'FG2011' TO 'C:\Temp\FG2011_Dev.ndf',
	MOVE 'FG2012' TO 'C:\Temp\FG2012_Dev.ndf',
	MOVE 'FG2013' TO 'C:\Temp\FG2013_Dev.ndf',
	MOVE 'FG2014' TO 'C:\Temp\FG2014_Dev.ndf',
	MOVE 'TestFileGroup_log' TO 'C:\Temp\TestFileGroup_New_log.ldf',
	RECOVERY,STATS=1;
GO
USE TestFileGroup_New
GO
--بودن فایل گروه ReadOnly بررسی 
SELECT 
	name,is_read_only 
FROM SYS.filegroups
GO
USE master
GO
--تهیه بکاپ از فایل گروه های بانک اطلاعاتی اصلی
--Full Backup from FileGroup
BACKUP DATABASE TestFileGroup
   FILEGROUP = 'PRIMARY'
   TO DISK = 'C:\Temp\TestFileGroup_PRIMARY.bak'
   WITH FORMAT,COMPRESSION
GO
BACKUP DATABASE TestFileGroup
   FILEGROUP = 'FG2010'
   TO DISK = 'C:\Temp\TestFileGroup_FG2010.bak'
   WITH FORMAT,COMPRESSION
GO
BACKUP DATABASE TestFileGroup
   FILEGROUP = 'FG2011'
   TO DISK = 'C:\Temp\TestFileGroup_FG2011.bak'
   WITH FORMAT,COMPRESSION
GO
BACKUP DATABASE TestFileGroup
   FILEGROUP = 'FG2012'
   TO DISK = 'C:\Temp\TestFileGroup_FG2012.bak'
   WITH FORMAT,COMPRESSION
GO
BACKUP DATABASE TestFileGroup
   FILEGROUP = 'FG2013'
   TO DISK = 'C:\Temp\TestFileGroup_G2013.bak'
   WITH FORMAT,COMPRESSION
GO
BACKUP DATABASE TestFileGroup
   FILEGROUP = 'FG2014'
   TO DISK = 'C:\Temp\TestFileGroup_FG2014.bak'
   WITH FORMAT,COMPRESSION
GO
-----------------------------------
--Primary,FG2014 تغییر داده های فایل گروه های 
--در بانک اطلاعاتی اصلی
USE TestFileGroup;
GO
INSERT INTO [PRIMARY_TABLE]
SELECT 1, 'TEST'
GO 100

TRUNCATE TABLE [FG2014_TABLE];
GO
-----------------------------------
--Primary,FG2014 از فایل گروه هایDifferential Backup تهیه 
--از بانک اطلاعاتی اصلی
BACKUP DATABASE TestFileGroup
   FILEGROUP = 'PRIMARY'
   TO DISK = 'C:\Temp\TestFileGroup_PRIMARYDIFF.bak'
   WITH DIFFERENTIAL,FORMAT,COMPRESSION
GO
BACKUP DATABASE TestFileGroup
   FILEGROUP = 'FG2014'
   TO DISK = 'C:\Temp\TestFileGroup_FG2014DIFF.bak'
   WITH DIFFERENTIAL,FORMAT,COMPRESSION
GO
-----------------------------------
--Primary,FG2014 تغییر مجدد داده های فایل گروه های 
USE TestFileGroup;
GO
INSERT INTO [PRIMARY_TABLE]
SELECT 1, 'TEST'
GO 100

INSERT INTO [FG2014_TABLE]
SELECT 1, 'NEW'
GO 300
-----------------------------------
--تهیه لاگ بکاپ از بانک اطلاعاتی
USE [master];
GO
BACKUP LOG TestFileGroup TO DISK = 'C:\Temp\TestFileGroup_LogBackup.trn'
	WITH FORMAT,COMPRESSION
GO
--Tail Log Backup
--بازیابی نمی شود
--وضعیت بانک را توجه کنید
BACKUP LOG TestFileGroup_New
TO DISK = 'C:\Temp\TestFileGroup_New_TailLogBackup.trn'
WITH NORECOVERY,FORMAT,COMPRESSION
GO
-----------------------------------
--بازیابی بکاپ  فایل گروه های خواندنی و نوشتنی بر روی 
--بانک اطلاعاتی دوم
--Restore primary filegroup
RESTORE DATABASE TestFileGroup_New
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'C:\Temp\TestFileGroup_PRIMARY.bak'
   WITH NORECOVERY;
GO
--Restore FG2014 filegroup 
RESTORE DATABASE TestFileGroup_New
   FILEGROUP = 'FG2014'
   FROM DISK = 'C:\Temp\TestFileGroup_FG2014.bak'
   WITH NORECOVERY;
GO
-----------------------------------
--بازیابی بکاپ  دیفرنشیال، فایل گروه های خواندنی و نوشتنی بر روی 
--بانک اطلاعاتی دوم
--Then the differential backups:-

--Restore PRIMARY differential backup
RESTORE DATABASE TestFileGroup_New
   FILEGROUP = 'PRIMARY'
   FROM DISK = 'C:\Temp\TestFileGroup_PRIMARYDIFF.bak'
   WITH NORECOVERY;
GO
--Restore FG2014 differential backup
RESTORE DATABASE TestFileGroup_New
   FILEGROUP = 'FG2014'
   FROM DISK = 'C:\Temp\TestFileGroup_FG2014DIFF.bak'
   WITH NORECOVERY;
GO
-----------------------------------
--بازیابی بکاپ  لاگ ، بر روی 
--بانک اطلاعاتی دوم

--Then the transaction log backup:

RESTORE LOG TestFileGroup_New
FROM DISK = 'C:\Temp\TestFileGroup_LogBackup.trn'
WITH NORECOVERY;
GO
RESTORE DATABASE TestFileGroup_New WITH RECOVERY;
GO
-----------------------------------
--بررسی وضعیت دیتا

USE TestFileGroup_New;
GO

SELECT COUNT(*) AS [PRIMARY_TABLE]
FROM [PRIMARY_TABLE];

SELECT COUNT(*) AS [FG2010_TABLE]
FROM [FG2010_TABLE];

SELECT COUNT(*) AS [FG2011_TABLE]
FROM [FG2011_TABLE];

SELECT COUNT(*) AS [FG2012_TABLE]
FROM [FG2012_TABLE];

SELECT COUNT(*) AS [FG2013_TABLE]
FROM [FG2013_TABLE];

SELECT COUNT(*) AS [FG2014_TABLE]
FROM [FG2014_TABLE];

SELECT TOP (1) *
FROM [FG2014_TABLE];
GO
