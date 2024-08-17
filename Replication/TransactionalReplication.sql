--ساخت بانک اطلاعاتی برای بررسی فایل های مربوط به آن
--DBServer1,DBServer2,MyLaptop در این سناریو سه تا ماشین به نام 
/*
MyLaptop  : Publisher & Distributor
DBServer1 : Subscriber1
DBServer2 : Subscriber2
*/
GO
/*
SP_HelpServer , SP_AddServer , SP_DropServer بررسی دستور
 در حالت 32 بیتی و 64 بیتی Alias بررسی مفهوم 
*/
GO
/*
Agent ایجاد یک اکانت در تمامی سرورها برای استارت سرویس 
 را استارت کرده Agent و اعمال دسترسی اکانتی که سرویس  Distributor در سرور Share ایجاد یک فولدر 
 را استارت کرده استAgent دادن دسترسی لاگین به اکانتی که سرویس 
*/
GO
--------------------------------------------------------------------
--Publisher ساخت بانک اطلاعاتی مثال در سرور 
USE master
GO
IF DB_ID('dbTestDB2017_TrnRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_TrnRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_TrnRep
END
GO
CREATE DATABASE dbTestDB2017_TrnRep
GO
USE dbTestDB2017_TrnRep
GO
DROP TABLE IF EXISTS Employess
GO
CREATE TABLE Employess
(
	EmployeeID INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(10)
)
GO
INSERT Employess(FirstName,LastName) VALUES 
	(N'مسعود',N'طاهری'),
	(N'فرید',N'طاهری'),
	(N'سیاوش',N'گلچوبیان'),
	(N'محمد امین',N'مزیدی')
GO
SELECT * FROM Employess
GO
--ساخت یک ویو
DROP VIEW IF EXISTS  V_SelectAllEmployess
GO
CREATE VIEW V_SelectAllEmployess
AS
	SELECT FirstName,LastName FROM Employess
GO
SELECT * FROM V_SelectAllEmployess
GO
--------------------------------------------------------------------
--Subscriber1 ساخت بانک اطلاعاتی خالی مثال در سرور 
USE master
GO
IF DB_ID('dbTestDB2017_TrnRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_TrnRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_TrnRep
END
GO
CREATE DATABASE dbTestDB2017_TrnRep
GO
USE dbTestDB2017_TrnRep
GO
DROP TABLE IF EXISTS Employess
GO
DROP TABLE IF EXISTS Employess
GO
CREATE TABLE Employess
(
	EmployeeID INT PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(15)
)
GO
INSERT Employess(EmployeeID,FirstName,LastName) VALUES 
	(-1,N'احمد',N'Subscriber1')
GO
/*
ی وجود دارداشته باشد که در جدول مبدا هم موجود استID اگر 
خطا خواهیم داشت Replcation هنگام انجام عملیات 
*/
SELECT * FROM Employess
GO
--این کار را انجام دهیمObject Explorer باید از طریق  Replication برای تست عملیات 
GO
--------------------------------------------------------------------
--Subscriber2 ساخت بانک اطلاعاتی خالی مثال در سرور 
USE master
GO
IF DB_ID('dbTestDB2017_TrnRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_TrnRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_TrnRep
END
GO
CREATE DATABASE dbTestDB2017_TrnRep
GO
USE dbTestDB2017_TrnRep
GO
DROP TABLE IF EXISTS Employess
GO
DROP TABLE IF EXISTS Employess
GO
CREATE TABLE Employess
(
	EmployeeID INT PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(10)
)
GO
INSERT Employess(EmployeeID,FirstName,LastName) VALUES 
	(-1,N'احمد',N'Subscriber2')
GO
/*
ی وجود دارداشته باشد که در جدول مبدا هم موجود استID اگر 
خطا خواهیم داشت Replcation هنگام انجام عملیات 
*/
SELECT * FROM Employess
GO
--این کار را انجام دهیمObject Explorer باید از طریق  Replication برای تست عملیات 
GO
--------------------------------------------------------------------
--چند سناریو ساده 
/*
مراجعه به نرم افزار مانیتورینگ
ها از طریق نرم افزار مانیتورینگ Subscriber کردن Stop & Start
*/
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
/*
********************************************************************
********************************************************************
********************************************************************
********************************************************************
*/
/*
سناریو دوم
--Backup از طریق یک Subscriber2 کردن Initialize
*/
--------------------------------------------------------------------
/*
مواد لازم 
MyLaptop  : Publisher & Distributor
DBServer1 : Subscriber1
*/
--ایجاد بانک اطلاعاتی
USE master
GO
IF DB_ID('dbTestDB2017_TrnRep2')>0
BEGIN
	ALTER DATABASE dbTestDB2017_TrnRep2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_TrnRep2
END
GO
CREATE DATABASE dbTestDB2017_TrnRep2
GO
USE dbTestDB2017_TrnRep2
GO
DROP TABLE IF EXISTS Employess
GO
CREATE TABLE Employess
(
	EmployeeID INT IDENTITY PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(10)
)
GO
INSERT Employess(FirstName,LastName) VALUES 
	(N'مسعود',N'طاهری'),
	(N'فرید',N'طاهری'),
	(N'سیاوش',N'گلچوبیان'),
	(N'محمد امین',N'مزیدی')
GO
SELECT * FROM Employess
GO
--------------------------------------------------------------------
--اجرا شود Publisher این اسکریپت بر روی 
USE dbTestDB2017_TrnRep2
GO
--Publication بررسی تنظیمات مربوط به 
sp_helppublication
GO
-- Allow initialize from backup اعمال تنظیمات 
DECLARE @publication AS sysname
SET @publication = N'PubBackup' 
 
EXEC sp_changepublication 
  @publication = @publication, 
  @property = N'Allow_initialize_from_backup', 
  @value = 'True'
GO
--Publication مشاهده تنظیمات مربوط به 
--Allow initialize from backup
sp_helppublication
GO
--------------------------------------------------------------------
--اجرا شود Publisher این اسکریپت بر روی 
GO
--تهیه فول بکاپ و لاگ بکاپ از بانک اطلاعاتی
USE master
GO
BACKUP DATABASE dbTestDB2017_TrnRep2 TO Disk='C:\Temp\dbTestDB2017_TrnRep2_Full.bak'
	WITH COMPRESSION,FORMAT
GO
BACKUP LOG dbTestDB2017_TrnRep2 TO Disk='C:\Temp\dbTestDB2017_TrnRep2_Log.trn'
	WITH COMPRESSION,FORMAT
GO
RESTORE FILELISTONLY FROM Disk='C:\Temp\dbTestDB2017_TrnRep2_Log.trn'
GO
--------------------------------------------------------------------
--بازیابی شود Subscriber بکاپ نسخه پشتیبان بر روی 
USE master
GO
--Full Backup بازیابی 
RESTORE DATABASE dbTestDB2017_TrnRep2 FROM DISK = N'C:\Temp\dbTestDB2017_TrnRep2_Full.bak' WITH  
	MOVE N'dbTestDB2017_TrnRep2' TO N'C:\Temp\dbTestDB2017_TrnRep2.mdf',
	MOVE N'dbTestDB2017_TrnRep2_log' TO N'C:\Temp\dbTestDB2017_TrnRep2_log.ldf',
	NORECOVERY
GO
--Log Backup بازیابی 
RESTORE DATABASE dbTestDB2017_TrnRep2 FROM DISK = N'C:\Temp\dbTestDB2017_TrnRep2_Log.trn' WITH  
	RECOVERY
GO
--------------------------------------------------------------------
--Publisher با استفاده از ویزارد بر رویSubscription انجام تنظیمات مربوط به 
--اسنپ شات برداشته شود Initialize تیک مرحله آخر مربوط به 
GO
--------------------------------------------------------------------
--Replication بررسی صحت انجام عملیات مربوط به 
--مشاهده شود Subscriber انجام شده و در  Publisher این کار بر روی 
USE dbTestDB2017_TrnRep2
GO
--Publisher اجر بر روی 
UPDATE Employess SET FirstName=N'Masoud' WHERE EmployeeID=1
UPDATE Employess SET FirstName=N'Farid' WHERE EmployeeID=2
GO
--Subscriber مشاهده در 
GO