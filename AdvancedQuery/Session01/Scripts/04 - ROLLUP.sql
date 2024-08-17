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

/*
ROLLUP ( <group_by_expression> [ ,...n ] ) 

ROLLUP (A,B,C):
(A,B,C)
(A,B)
(A)
() Grand Total

*/

USE NikamoozDB;
GO

-- گروه‌بندی تک سطحی
-- مشتریان و تعداد سفارشات آن‌ها و سرجمع نهایی به‌ازای گروه‌ها
SELECT
	CustomerID,
	COUNT(OrderID) AS Num
FROM Orders
GROUP BY CustomerID WITH ROLLUP;
GO

-- روش دیگر نوشتن کوئری بالا
SELECT
	CustomerID,
	COUNT(OrderID) AS Num
FROM Orders
GROUP BY ROLLUP (CustomerID);
GO

-- گروه‌بندی چند سطحی
-- تعداد سفارشات هر کارمند به‌تفکیک سال و ماه و سرجمع نهایی به‌ازای گروه‌ها
SELECT
	EmployeeID,
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE EmployeeID  IN (1,2)
GROUP BY ROLLUP(EmployeeID, YEAR(OrderDate), MONTH(OrderDate));
GO
--------------------------------------------------------------------

/*
GROUPING کاربرد
ROLLUP تشخیص سطرهای حاصل از
تشخیص فیلدهای غایب در گروه‌بندی
*/

-- گروه‌بندی تک سطحی
SELECT
	CustomerID,
	COUNT(OrderID) AS Num,
	GROUPING (CustomerID) AS GROUPING_CustomerID
FROM Orders
GROUP BY ROLLUP(CustomerID);
GO

-- گروه‌بندی چند سطحی
SELECT
	EmployeeID,
	YEAR(OrderDate) AS OrderYear,
	MONTH(OrderDate) AS OrderMonth,
	COUNT(OrderID) AS Num,
	GROUPING (EmployeeID) AS GROUPING_EmployeeID,
	GROUPING (YEAR(OrderDate)) AS GROUPING_Year,
	GROUPING (MONTH(OrderDate)) AS GROUPING_Month
FROM Orders
GROUP BY ROLLUP (EmployeeID, YEAR(OrderDate), MONTH(OrderDate));
GO