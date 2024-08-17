--------------------------------------------------------------------
/*
(Window Function) دوره آموزشی کوئری‌نویسی پیشرفته
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebory 
*/
--------------------------------------------------------------------

USE NikamoozDB;
GO

-- Accept TRUE
-- .آن‌ها برابر با جنوب است Region فهرست مشتریان دارای سفارش که مقدار فیلد
SELECT
	C.CompanyName, C.Region
FROM Customers AS C
	WHERE EXISTS (SELECT 1 FROM Orders AS O
					WHERE O.CustomerID = C.CustomerID)
	AND Region = N'جنوب';
GO

-- .آن‌ها مخالف جنوب است Region فهرست مشتریان دارای سفارش که مقدار فیلد
SELECT
	C.CompanyName, C.Region
FROM Customers AS C
	WHERE EXISTS (SELECT 1 FROM Orders AS O
					WHERE O.CustomerID = C.CustomerID)
	AND Region <> N'جنوب';
GO

-- .ارزیابی می‌شود UNKNOWN درست نیست و NULL = NULL عبارت
SELECT
	C.CompanyName, C.Region
FROM Customers AS C
	WHERE EXISTS (SELECT 1 FROM Orders AS O
					WHERE O.CustomerID = C.CustomerID)
	AND Region = NULL;
GO

-- UNKNOWN بر روی مقادیر NOT عدم تاثیر
SELECT
	C.CompanyName, C.Region
FROM Customers AS C
	WHERE EXISTS (SELECT 1 FROM Orders AS O
					WHERE O.CustomerID = C.CustomerID)
	AND NOT (Region = NULL);
GO

-- .است NULL آن‌ها برابر با Region فهرست مشتریان دارای سفارش که مقدار فیلد
SELECT
	C.CompanyName, C.Region
FROM Customers AS C
	WHERE EXISTS (SELECT 1 FROM Orders AS O
					WHERE O.CustomerID = C.CustomerID)
	AND Region IS NULL;
GO

-- .نیست NULL آن‌ها برابر با Region فهرست مشتریان دارای سفارش که مقدار فیلد
SELECT
	C.CompanyName, C.Region
FROM Customers AS C
	WHERE EXISTS (SELECT 1 FROM Orders AS O
					WHERE O.CustomerID = C.CustomerID)
	AND Region IS NOT NULL;
GO
--------------------------------------------------------------------

-- Reject False
DROP TABLE IF EXISTS Chk_Constraint;
GO

CREATE TABLE Chk_Constraint
(
	ID        INT NOT NULL IDENTITY,
	Family    NVARCHAR(100),
	Score	  INT CONSTRAINT CHK_Positive CHECK(Score >= 0)
);
GO

-- TRUE پذیرش مقدار
INSERT INTO dbo.Chk_Constraint(Family, Score)  
	VALUES (N'سعیدی',100);
GO

-- NULL پذیرش مقدار
INSERT INTO dbo.Chk_Constraint(Family)  
	VALUES (N'پرتوی');
GO

-- FALSE عدم پذیرش مقدار
INSERT INTO dbo.Chk_Constraint(Family, Score)  
	VALUES (N'احمدی',-10);
GO

SELECT * FROM dbo.Chk_Constraint;
GO
--------------------------------------------------------------------

-- All-at-Once عملیات
SELECT
	OrderID,
	YEAR(OrderDate) AS OrderYear,
	OrderYear + 1 AS NextYear
FROM dbo.Orders;
GO