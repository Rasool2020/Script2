--ساخت بانک اطلاعاتی برای بررسی فایل های مربوط به آن
--DBServer1,DBServer2,MyLaptop در این سناریو سه تا ماشین به نام 
/*
MyLaptop  : Publisher
DBServer1 : Distributor
DBServer2 : Subscriber
*/
/*
Agent ایجاد یک اکانت در تمامی سرورها برای استارت سرویس 
 را استارت کرده Agent و اعمال دسترسی اکانتی که سرویس  Distributor در سرور Share ایجاد یک فولدر 
 را استارت کرده استAgent دادن دسترسی لاگین به اکانتی که سرویس 
 
*/
--------------------------------------------------------------------
--Publisher ساخت بانک اطلاعاتی مثال در سرور 
USE master
GO
IF DB_ID('dbTestDB2017_SnapshotRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_SnapshotRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_SnapshotRep
END
GO
CREATE DATABASE dbTestDB2017_SnapshotRep
GO
USE dbTestDB2017_SnapshotRep
GO
--------------------------------------------------------------------
--Publisher درج اطلاعات در 
USE dbTestDB2017_SnapshotRep
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
--------------------------------------------------------------------
--Subscriber ساخت بانک اطلاعاتی خالی مثال در سرور 
USE master
GO
IF DB_ID('dbTestDB2017_Subscriber')>0
BEGIN
	ALTER DATABASE dbTestDB2017_Subscriber SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_Subscriber
END
GO
CREATE DATABASE dbTestDB2017_Subscriber
GO
USE dbTestDB2017_Subscriber
GO
SP_HELPFILE
GO
--------------------------------------------------------------------
