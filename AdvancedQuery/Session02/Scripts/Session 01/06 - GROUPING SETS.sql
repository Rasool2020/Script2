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

-- تمامی سفارشات درخواست‌شده از مشتری 1 یا 2 به‌تفکیک هر کارمند-مشتری
SELECT 
	EmployeeID,
	CustomerID,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY EmployeeID, CustomerID;
GO

-- تمامی سفارشات مشتری 1 یا 2 به‌تفکیک هر سال
SELECT
	CustomerID, 
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1
	OR CustomerID = 2
GROUP BY CustomerID, YEAR(OrderDate);
GO

-- تمامی سفارشات ثبت‌شده توسط کارمندان با مشتری 1 یا 2 و به تفکیک هر سال
SELECT
	EmployeeID, 
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY EmployeeID, YEAR(OrderDate);
GO

-- Set Operator تجمیع کوئری‌های بالا با استفاده از
-- اول Query
SELECT
	EmployeeID,
	CustomerID,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY EmployeeID, CustomerID
UNION ALL
-- دوم Query
SELECT
	CustomerID, 
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1
	OR CustomerID = 2
GROUP BY CustomerID, YEAR(OrderDate)
UNION ALL
-- سوم Query
SELECT
	EmployeeID, 
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY EmployeeID, YEAR(OrderDate);
GO
--------------------------------------------------------------------

/*
GROUPING SETS
*/ 

-- GROUPING SETS معادل تمامی کوئری‌های بالا با استفاده از
SELECT 	
	EmployeeID,
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID=1 
	OR CustomerID=2
GROUP BY GROUPING SETS 
	(
		(EmployeeID, CustomerID),
		(EmployeeID, YEAR(OrderDate)),
		(CustomerID, YEAR(OrderDate))
	);
GO
/*
:تذکر مهم
(Aggregate Columns) آمده‌اند به‌جز SELECT تمامی فیلدهایی که جلو
شرکت داشته باشند GROUPING SETS می‌بایست به‌نوعی در ترکیب
*/
GO
--------------------------------------------------------------------

-- GROUPING SETS مرتب‌سازی سفارشی رکوردها هنگام استفاده از 
SELECT 	
	EmployeeID,
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY GROUPING SETS 
	(
		(EmployeeID,CustomerID),
		(EmployeeID, YEAR(OrderDate)),
		(CustomerID, YEAR(OrderDate))
	)
ORDER BY
	CASE
		WHEN YEAR(OrderDate) IS NULL THEN 1
		WHEN EmployeeID IS NULL THEN 2
		WHEN CustomerID IS NULL THEN 3
	END
GO
--------------------------------------------------------------------

/*
Grouping_ID
با استفاده از این تابع می توان فهمید که گروه‌بندی به‌ازای
.کدامیک از ستون ها انجام شده و چه فیلدی در نتیجه‌ی ‌نهایی غایب است

-- ارزش بیتی

GROUPING_ID(EmployeeID, CustomerID, YEAR(OrderDate))
				2^2		   2^1			 2^0
*/

SELECT 	
	EmployeeID,
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	GROUPING_ID(EmployeeID, CustomerID, YEAR(OrderDate)) AS GROUPING_ID_Field
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY GROUPING SETS 
	(
		(EmployeeID, CustomerID),
		(EmployeeID, YEAR(OrderDate)),
		(CustomerID, YEAR(OrderDate))
	);
GO

-- CASE مرتب‌سازی بهتر کوئری بالا با استفاده از
SELECT 	
	EmployeeID,
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num,
	CASE GROUPING_ID(EmployeeID, CustomerID, YEAR(OrderDate))
		WHEN 4 THEN N'مشتری و سال'
		WHEN 2 THEN N'کارمند و سال'
		WHEN 1 THEN N'کارمند و مشتری'
	END AS N'گروه بندی بر اساس'
FROM Orders
	WHERE CustomerID=1 
	OR CustomerID=2
GROUP BY GROUPING SETS 
	(
		(EmployeeID, CustomerID),
		(EmployeeID, YEAR(OrderDate)),
		(CustomerID, YEAR(OrderDate))
	);
GO
--------------------------------------------------------------------

SELECT 	
	EmployeeID,
	CustomerID,
	YEAR(OrderDate) AS OrderYear,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID = 1 
	OR CustomerID = 2
GROUP BY GROUPING SETS 
	(
		CUBE(EmployeeID, CustomerID),
		YEAR(OrderDate)
	);
GO
--------------------------------------------------------------------

/*
.هر دو کوئری زیر معادل یکدیگر هستند
*/
SELECT
	City, Region,
	COUNT(City) AS Num
FROM Employees
	WHERE City = N'تهران'
GROUP BY GROUPING SETS
	(
		ROLLUP (City, Region),
		CUBE(City, Region)
	);
GO

SELECT
	City, Region,
	COUNT(City) AS Num
FROM Employees
	WHERE City = N'تهران'
GROUP BY ROLLUP (City, Region)
UNION ALL
SELECT
	City, Region,
	COUNT(City) AS Num
FROM Employees
	WHERE City = N'تهران'
GROUP BY CUBE (City, Region);
GO