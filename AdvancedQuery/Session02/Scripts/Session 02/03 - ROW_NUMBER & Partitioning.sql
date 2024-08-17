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

-- بر روی یک فیلد Partitioning
SELECT
	custid, orderid, val,
	ROW_NUMBER() OVER(PARTITION BY custid 
					  ORDER BY orderid) AS Row_Num
FROM Sales.OrderValues;
GO

-- بر روی بیش از یک فیلد Partitioning
SELECT
	custid, empid,orderid, val,
	ROW_NUMBER() OVER(PARTITION BY custid, empid
					  ORDER BY orderid) AS Row_Num
FROM Sales.OrderValues;
GO
--------------------------------------------------------------------

/*
.اجرای کوئری با خطا روبرو خواهد شد OVER در بخش ORDER BY به‌دلیل عدم وجود عبارت
*/
SELECT
	orderid, val,
	ROW_NUMBER() OVER(PARTITION BY empid) AS Row_Num
FROM Sales.OrderValues;
GO

/*
.اجرای کوئری با خطا روبرو خواهد شد OVER در بخش Framing به‌دلیل وجود
.نیستیم Framing ها مجاز به استفاده از Ranking Function در
*/
SELECT
	custid, empid,
	ROW_NUMBER() OVER(PARTITION BY empid 
					  ORDER BY orderid
					  ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Row_Num
FROM Sales.OrderValues;
GO