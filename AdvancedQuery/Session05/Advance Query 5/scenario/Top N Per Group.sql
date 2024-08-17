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

-- WF با استفاده از
WITH CTE
AS
(
	SELECT
		custid, orderdate, orderid, empid,
		ROW_NUMBER() OVER( PARTITION BY custid 
						   ORDER BY orderdate DESC, orderid DESC ) AS Row_Num
	FROM Sales.Orders
)
SELECT
	custid, orderdate, orderid, empid
FROM CTE
	WHERE Row_Num <= 3
ORDER BY custid, Row_Num;
GO

-- OFFSET\FETCH با استفاده از
SELECT
	C.custid, Tmp.*
FROM Sales.Customers AS C
CROSS APPLY (SELECT
				orderdate, orderid, empid
			 FROM Sales.Orders AS O
				WHERE O.custid = C.custid
			 ORDER BY orderdate DESC, orderid DESC
			 OFFSET 0 ROWS FETCH FIRST 3 ROWS ONLY
			 ) AS Tmp
GO

-- TOP با استفاده از
SELECT
	C.custid, Tmp.*
FROM Sales.Customers AS C
CROSS APPLY (SELECT
				TOP 3 orderdate, orderid, empid
			 FROM Sales.Orders AS O
				WHERE O.custid = C.custid
			 ORDER BY orderdate DESC, orderid DESC
			 ) AS Tmp;
GO