--------------------------------------------------------------------
/*
Performance & Tuning in SQL Server 2017 دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
/*
Statistics بررسی روش های ایجاد 
*/
GO
USE master
GO
--بررسی جهت وجود بانک اطلاعاتی
IF DB_ID('NikAmoozDB2017')>0
BEGIN
	ALTER DATABASE NikAmoozDB2017 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2017
END
GO
--ایجاد بانک اطلاعاتی
CREATE DATABASE NikAmoozDB2017
GO
USE NikAmoozDB2017
GO
---------------------------------
USE NikAmoozDB2017
GO
--بررسی جهت وجود جدول و حذف آن
DROP TABLE IF EXISTS Person_Contact
GO
CREATE TABLE Person_Contact
(
	ID INT IDENTITY PRIMARY KEY	,
	FirstName NVARCHAR(60),
	LastName NVARCHAR(60),
	Phone NVARCHAR(15),
	Title NVARCHAR(15)
)
GO
--درج تعدادی رکورد در جدول
INSERT INTO Person_Contact (FirstName,LastName,Phone,Title) VALUES
	(N'John',N'Smith',N'425-555-1234',N'Mr'),
	(N'Erik',N'Andersen',N'425-555-1111',N'Mr'),
	(N'Erik',N'Andersen',N'425-555-3333',N'Mr'),
	(N'Jeff',N'Williams',N'425-555-0000',N'Dr'),
	(N'Larry',N'Zhang',N'425-555-2222',N'Mr')
GO
-----------------------------------------------
--به صورت خودکار Stats ایجاد یک 

--اجرای یک کوئری با شرط
SELECT * FROM Person_Contact 
	WHERE LastName = N'Andersen'
GO
--به صورت خودکار Stats ایجاد یک 
--های یک جدولStats استخراج لیست
SP_HELPSTATS N'Person_Contact', 'ALL'
GO
-----------------------------------------------
--توسط یک ایندکس Stats ایجاد یک 
--ایجاد یک ایندکس بر روی جدول
CREATE NONCLUSTERED INDEX Phone on Person_Contact(Phone)
GO
--توسط یک ایندکس Stats ایجاد یک 
--های یک جدولStats استخراج لیست
SP_HELPSTATS N'Person_Contact', 'ALL'
GO
-----------------------------------------------
--توسط کاربر Stats ایجاد یک 
--نمونه برداری تصادفی
CREATE STATISTICS FirstLast ON 
	Person_Contact(FirstName,LastName)
GO
--های یک جدولStats استخراج لیست
SP_HELPSTATS N'Person_Contact', 'ALL'
GO
--در نظر گرفتن کلیه رکوردهای جدول برای استخراج آمار پراکندگی
CREATE STATISTICS FirstLast1 ON 
	Person_Contact(FirstName,LastName) 
WITH FULLSCAN
GO