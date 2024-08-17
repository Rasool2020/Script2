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

USE WF;
GO

DROP TABLE IF EXISTS Sales.Duplicates_Orders;
GO

SELECT * INTO Sales.Duplicates_Orders FROM Sales.Orders
UNION ALL
SELECT * FROM Sales.Orders
UNION ALL
SELECT * FROM Sales.Orders;
GO

SELECT * FROM Sales.Duplicates_Orders
ORDER BY orderid;
GO

-- ها orderid رتبه‌دهی به‌مقادیر هر گروه از
SELECT
	orderid,
	ROW_NUMBER() OVER( PARTITION BY orderid
                       ORDER BY (SELECT NULL) ) AS Num
FROM Sales.Duplicates_Orders;
GO

-- Sales.Duplicates_Orders حذف مقادیر تکراری از جدول
WITH CTE
AS
(
	SELECT
		orderid,
		ROW_NUMBER() OVER( PARTITION BY orderid
						   ORDER BY (SELECT NULL) ) AS Num
	FROM Sales.Duplicates_Orders
)
DELETE FROM CTE
	WHERE Num > 1;
GO
--------------------------------------------------------------------

/*
مراحل حذف از جداولی با تعداد زیاد رکورد

1) انتقال یک رکورد به‌ازای هر یک از رکوردهای تکراری به جدول جدید
2) کردن جدول قدیمی DROP
3) تغییر نام جدول جدید به جدول قدیمی
4) ایجاد آبجکت‌های وابسته به جدول جدید
*/

-- گام اول
DROP TABLE IF EXISTS Sales.OrdersTmp;
GO

WITH CTE
AS
(
  SELECT
	*,
	ROW_NUMBER() OVER( PARTITION BY orderid
                       ORDER BY (SELECT NULL) ) AS Num
  FROM Sales.Duplicates_Orders
)
SELECT
	orderid, custid, empid, orderdate, requireddate, shippeddate, 
	shipperid, freight, shipname, shipaddress, shipcity, shipregion, 
	shippostalcode, shipcountry
INTO Sales.OrdersTmp FROM CTE
	WHERE Num = 1;
GO

-- گام دوم
DROP TABLE Sales.Duplicates_Orders;
GO

-- گام سوم
EXEC sp_rename 'Sales.OrdersTmp', 'Duplicates_Orders';
GO

-- گام چهارم
-- Recreate Indexes, Constraints, Triggers, ...