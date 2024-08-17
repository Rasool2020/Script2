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

CUME_DIST() عملکرد تابع

X(np) : تعداد رکوردهایی که در پارتیشن موردنظر مقدارشان با رکورد جاری برابر و یا از آن کوچکتر است

Y(nr): تعداد کل رکوردهای پارتیشن موردنظر

CUME_DIST() = X/Y

*/

SELECT * FROM Stats.Scores
ORDER BY score;
GO

-- Ordering
SELECT
	testid, studentid, score,
	CUME_DIST() OVER(ORDER BY score) AS Cum_Val
FROM Stats.Scores;
GO
--------------------------------------------------------------------

-- Ordering & Partitioning
SELECT
	testid, studentid, score,
	CUME_DIST() OVER( PARTITION BY testid
					  ORDER BY score ) AS Cum_Val
FROM Stats.Scores;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

.توزیع تجمعی هر کارمند براساس تعداد ثبت سفارشات
Table: Sales.Orders

empid   Orders_Num         Cum_Val
-----  ------------  -------------------
  5        42         0.111111111111111
  9        43         0.222222222222222
  6        67         0.333333333333333
  7        72         0.444444444444444
  2        96         0.555555555555556
  8        104        0.666666666666667
  1        123        0.777777777777778
  3        127        0.888888888888889
  4        156        1

(9 rows affected)
*/

SELECT
	empid,
	COUNT(orderid) AS Num
FROM Sales.Orders
GROUP BY empid;
GO

SELECT
	empid,
	COUNT(orderid) AS Orders_Num,
	CUME_DIST() OVER(ORDER BY COUNT(orderid)) AS Cum_Val
FROM Sales.Orders
GROUP BY empid;
GO
--------------------------------------------------------------------

-- !!!هیچ‌کدام از اسکریپت‌های زیر معتبر نیستند
SELECT
	testid, studentid, score,
	CUME_DIST() OVER( ORDER BY score
					  ROWS UNBOUNDED PRECEDING ) AS cumedist
FROM Stats.Scores;
GO

SELECT
	testid, studentid, score,
	CUME_DIST() OVER(PARTITION BY testid) AS cumedist
FROM Stats.Scores;
GO