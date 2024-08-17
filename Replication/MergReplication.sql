--ساخت بانک اطلاعاتی برای بررسی فایل های مربوط به آن
--DBServer1,DBServer2,MyLaptop در این سناریو سه تا ماشین به نام 
/*
MyLaptop  
DBServer1 
DBServer2 
*/
GO
--------------------------------------------------------------------
--Publisher ساخت بانک اطلاعاتی مثال در سرور 
USE master
GO
IF DB_ID('dbTestDB2017_MergeRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_MergeRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_MergeRep
END
GO
CREATE DATABASE dbTestDB2017_MergeRep
GO
USE dbTestDB2017_MergeRep
GO
DROP TABLE IF EXISTS Employess
GO
CREATE TABLE Employess
(
	EmployeeID INT,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(15)
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
IF DB_ID('dbTestDB2017_MergeRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_MergeRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_MergeRep
END
GO
CREATE DATABASE dbTestDB2017_MergeRep
GO
/*
USE dbTestDB2017_MergeRep
GO
DROP TABLE IF EXISTS Employess
GO
DROP TABLE IF EXISTS Employess
GO
CREATE TABLE Employess
(
	EmployeeID INT ,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(15)
)
GO
*/
--------------------------------------------------------------------
--Subscriber2 ساخت بانک اطلاعاتی خالی مثال در سرور 
USE master
GO
IF DB_ID('dbTestDB2017_MergeRep')>0
BEGIN
	ALTER DATABASE dbTestDB2017_MergeRep SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE dbTestDB2017_MergeRep
END
GO
CREATE DATABASE dbTestDB2017_MergeRep
GO
/*
USE dbTestDB2017_MergeRep
GO
DROP TABLE IF EXISTS Employess
GO
DROP TABLE IF EXISTS Employess
GO
CREATE TABLE Employess
(
	EmployeeID INT ,
	FirstName NVARCHAR(10),
	LastName NVARCHAR(15)
)
GO
*/
--------------------------------------------------------------------
--و پیکربندی آن Publisher مراجعه به 
GO
--و تحلیل فیلد و تریگر اضافه شده Publisher بررسی جدول در
GO
--------------------------------------------------------------------
--Subscriber1 اجرا در 
INSERT Employess(EmployeeID,FirstName,LastName) VALUES 
	(5,N'S1',N'S1')
GO
SELECT * FROM Employess
GO
--------------------------------------------------------------------

--------------------------------------------------------------------