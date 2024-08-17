--------------------------------------------------------------------
--ساخت بانک اطلاعاتی برای بررسی فایل های مربوط به آن
--DBServer1,DBServer2,MyLaptop در این سناریو سه تا ماشین به نام 
/*
MyLaptop  
DBServer1 
DBServer2 
*/
GO
/*
SP_HelpServer , SP_AddServer , SP_DropServer بررسی دستور
 در حالت 32 بیتی و 64 بیتی Alias بررسی مفهوم 
*/
GO
--------------------------------------------------------------------
--Publisher ساخت بانک اطلاعاتی مثال در سرور 
USE master
GO
IF DB_ID('dbTestDB2017_PeerRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_PeerRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_PeerRep
END
GO
CREATE DATABASE dbTestDB2017_PeerRep
GO
USE dbTestDB2017_PeerRep
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
	(1,N'مسعود',N'طاهری'),
	(2,N'فرید',N'طاهری'),
	(3,N'سیاوش',N'گلچوبیان'),
	(4,N'محمد امین',N'مزیدی')
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
IF DB_ID('dbTestDB2017_PeerRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_PeerRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_PeerRep
END
GO
CREATE DATABASE dbTestDB2017_PeerRep
GO
USE dbTestDB2017_PeerRep
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
IF DB_ID('dbTestDB2017_PeerRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_PeerRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_PeerRep
END
GO
CREATE DATABASE dbTestDB2017_PeerRep
GO
USE dbTestDB2017_PeerRep
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
IF DB_ID('dbTestDB2017_PeerRep2')>0
BEGIN
	ALTER DATABASE dbTestDB2017_PeerRep2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_PeerRep2
END
GO
CREATE DATABASE dbTestDB2017_PeerRep2
GO
USE dbTestDB2017_PeerRep2
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
USE dbTestDB2017_PeerRep2
GO
--Publication بررسی تنظیمات مربوط به 
sp_helppublication
GO
-- Allow initialize from backup اعمال تنظیمات 
DECLARE @publication AS sysname
SET @publication = N'dbTestPublication2' 
 
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
BACKUP DATABASE dbTestDB2017_PeerRep2 TO Disk='C:\Temp\dbTestDB2017_PeerRep2_Full.bak'
	WITH COMPRESSION
GO
BACKUP LOG dbTestDB2017_PeerRep2 TO Disk='C:\Temp\dbTestDB2017_PeerRep2_Log.trn'
	WITH COMPRESSION
GO
RESTORE FILELISTONLY FROM Disk='C:\Temp\dbTestDB2017_PeerRep2_Log.trn'
GO
--------------------------------------------------------------------
--بازیابی شود Subscriber بکاپ نسخه پشتیبان بر روی 
USE master
GO
--Full Backup بازیابی 
RESTORE DATABASE dbTestDB2017_PeerRep2 FROM DISK = N'C:\Temp\dbTestDB2017_PeerRep2_Full.bak' WITH  
	MOVE N'dbTestDB2017_PeerRep2' TO N'C:\Temp\dbTestDB2017_PeerRep2.mdf',
	MOVE N'dbTestDB2017_PeerRep2_log' TO N'C:\Temp\dbTestDB2017_PeerRep2_log.ldf',
	NORECOVERY
GO
--Log Backup بازیابی 
RESTORE DATABASE dbTestDB2017_PeerRep2 FROM DISK = N'C:\Temp\dbTestDB2017_PeerRep2_Log.trn' WITH  
	RECOVERY
GO
--------------------------------------------------------------------
--Publisher با استفاده از ویزارد بر رویSubscription انجام تنظیمات مربوط به 
--اسنپ شات برداشته شود Initialize تیک مرحله آخر مربوط به 
GO
--------------------------------------------------------------------
--Replication بررسی صحت انجام عملیات مربوط به 
--مشاهده شود Subscriber انجام شده و در  Publisher این کار بر روی 
USE dbTestDB2017_PeerRep2
GO
--Publisher اجر بر روی 
UPDATE Employess SET FirstName=N'Masoud' WHERE EmployeeID=1
UPDATE Employess SET FirstName=N'Farid' WHERE EmployeeID=2
GO
--Subscriber مشاهده در 
GO


CREATE TABLE Employess2
(
	EmployeeID INT IDENTITY (1000,1) PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(10)
)


CREATE TABLE Employess2
(
	EmployeeID INT IDENTITY (3000,1) PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(10)
)

INSERT INTO Employess2(FirstName,LastName) VALUES ('B','B1')
SELECT * FROM Employess2

alter table Employess2 alter column  FirstName nvarchar(1000)

alter table Employess2 add   age int
sp_help Employess2













----------------------------------
--MASOUDTAHERI\sqlserver2017
USE dbTestDB2017_PeerRep
GO
SELECT * FROM Employess
GO

INSERT INTO Employess(EmployeeID,FirstName,LastName) VALUES (1,'A','A')

SP_HELPINDEX Employess

GO
SELECT * FROM Employess2
GO

INSERT INTO Employess2(FirstName,LastName) VALUES ('D','B')
SELECT * FROM Employess2

sp_help Employess2
----------------------------------
--DBSERVER1
USE dbTestDB2017_PeerRep
GO
SELECT * FROM Employess
GO
INSERT INTO Employess(EmployeeID,FirstName,LastName) VALUES (2,'B','B')
INSERT INTO Employess2(FirstName,LastName) VALUES ('B','B')
SELECT * FROM Employess2
sp_help Employess2


CREATE NONCLUSTERED COLUMNSTORE INDEX IX_NC ON Employess(EmployeeID,FirstName,LastName)


SP_HELPINDEX Employess

CREATE TABLE Employess2
(
	EmployeeID INT IDENTITY (2000,1) PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(10)
)
-------------------------------------
--DBSERVER2
USE dbTestDB2017_PeerRep
GO
SELECT * FROM Employess

GO
INSERT INTO Employess(EmployeeID,FirstName,LastName) VALUES (3,'C','C')
INSERT INTO Employess(EmployeeID,FirstName,LastName) VALUES (4,'D','D')


SP_HELPINDEX Employess

CREATE TABLE Employess2
(
	EmployeeID INT IDENTITY (3000,1) PRIMARY KEY,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(10)
)

INSERT INTO Employess2(FirstName,LastName) VALUES ('B','B1')
SELECT * FROM Employess2

alter table Employess2 alter column  FirstName nvarchar(1000)

alter table Employess2 add   age int
sp_help Employess2
