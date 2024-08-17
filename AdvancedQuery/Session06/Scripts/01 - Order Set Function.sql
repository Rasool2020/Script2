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

/*
بیشترین مبلغ به‌ازای هر مشتری

 custid   MaxValue
-------- ----------
   1      933.50
   2      514.40
   3      2082.00
   4      4441.25
   5      3815.25
   ...
*/
-- Query 1
SELECT
	custid,
	MAX(val) AS MaxValue
FROM Sales.OrderValues
GROUP BY custid;
GO

/*
orderdate, orderid آخرین مبلغ به‌ازای هر مشتری و بر اساس ترتیب ترکیبی از

 custid   LastOrderVal
-------- --------------
  1         933.50
  2         514.40
  3         660.00
  4         491.50
  5         1835.70
...
.پیاده‌سازی نشده است SQL Server ای هنوز در‌Syntax چنین
*/
-- Query 2
SELECT
	custid,
	LAST_VALUE(val) WITHIN GROUP(ORDER BY orderdate, orderid) AS LastOrderVal
FROM Sales.OrderValues
GROUP BY custid;
GO

/*
.‌به‌ازای هر یک از سطرهای پارتیشن تکرار می‌شود Window Function محاسبات
*/
SELECT
	DISTINCT custid,
	LAST_VALUE(val) OVER( PARTITION BY custid
						  ORDER BY orderdate, orderid
						  ROWS BETWEEN UNBOUNDED PRECEDING
								   AND UNBOUNDED FOLLOWING ) AS LastOrderVal
FROM Sales.OrderValues;
GO

-- .می‌توان به روش زیر هم عمل کرد Query 2 برای رسیدن به نتایج
WITH CTE
AS
(
	SELECT
		custid,
		LAST_VALUE(val) OVER( PARTITION BY custid
							  ORDER BY orderdate, orderid
							  ROWS BETWEEN UNBOUNDED PRECEDING
									   AND UNBOUNDED FOLLOWING ) AS LastOrderVal,
		ROW_NUMBER() OVER( PARTITION BY custid 
						   ORDER BY orderdate, orderid ) AS Row_Num
	FROM Sales.OrderValues
)
SELECT
	custid, LastOrderVal
FROM CTE
	WHERE Row_Num = 1;
GO