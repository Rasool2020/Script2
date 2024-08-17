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

--------------------------------------------------------------------
-- RANK
--------------------------------------------------------------------
SELECT
	custid, val,
	RANK() OVER(PARTITION BY custid ORDER BY val) AS Rnk
FROM Sales.OrderValues;
GO

/*
Oeder Set Function & Rank
.و برای هر مشتری به‌صورت زیر خواهد شد Val رتبه مقدار فرضی 1000 به‌ازای

 custid    Hypothetical_Rank
--------  -------------------
  1              7
  2              5
  3              6
  4              10
  5              7
  6              8
  7              6
  8              3
  9              9
  10             7
  ...	 
*/

/*
برای رسیدن به نتایج بالا نمی‌توان از این
.استفاده کرد SQL Server مدل کوئری‌نویسی در
*/
DECLARE @Val AS NUMERIC(12,2) = 1000.00;
SELECT
	custid,
	RANK(@Val) WITHIN GROUP(ORDER BY val) AS Rnk -- SQL SERVER عدم پشتیبانی در
FROM Sales.OrderValues
GROUP BY custid;
GO

-- SQL server معادل کوئری بالا در
DECLARE @Val AS NUMERIC(12,2) = 1000.00;
SELECT 
	custid,
	COUNT(CASE WHEN val < @Val THEN 1 END) + 1 AS Rnk -- ??? +1
FROM Sales.OrderValues
GROUP BY custid;
GO

--------------------------------------------------------------------
-- DENSE_RANK
--------------------------------------------------------------------
-- .مشتری شماره 9 توجه کنید DENSE_RANK به‌مقدار
SELECT
	custid, val,
	DENSE_RANK() OVER(PARTITION BY custid ORDER BY val) AS D_Rnk
FROM Sales.OrderValues;
GO

/*
Oeder Set Function & DENSE_RANK
.و برای هر مشتری به‌صورت زیر خواهد شد Val رتبه مقدار فرضی 1000 به‌ازای

custid    D_Rnk
-------  -------
  1         7
  2         5
  3         6
  4         10
  5         7
  6         8
  7         6
  8         3
  9         8
  10        7
  ...    
*/

/*
برای رسیدن به نتایج بالا نمی‌توان از این
.استفاده کرد SQL Server مدل کوئری‌نویسی در
*/
DECLARE @Val AS NUMERIC(12, 2) = 1000.00;
SELECT
	custid,
	DENSE_RANK(@Val) WITHIN GROUP(ORDER BY val) AS D_Rnk -- SQL SERVER عدم پشتیبانی در
FROM Sales.OrderValues
GROUP BY custid;
GO

-- SQL Server معادل کوئری بالا در
DECLARE @Val AS NUMERIC(12,2) = 1000.00;
SELECT
	custid,
	COUNT(DISTINCT CASE WHEN val < @Val THEN val END) + 1 AS D_Rnk
FROM Sales.OrderValues
GROUP BY custid;
GO

--------------------------------------------------------------------
-- PERCENT_RANK
--------------------------------------------------------------------
SELECT
	testid, score,
	PERCENT_RANK() OVER(PARTITION BY testid ORDER BY score) AS Prcnt_Val
FROM Stats.Scores;
GO

/*
Oeder Set Function & PERCENT_RANK
.مقدار فرضی 80 به‌ازای هر درس به‌صورت زیر خواهد شد PERCENT_RANK

  testid    Prcnt_Val
---------- -----------
 Test ABC     0.555       
 Test XYZ     0.500       
*/

/*
برای رسیدن به نتایج بالا نمی‌توان از این
.استفاده کرد SQL Server مدل کوئری‌نویسی در
*/
DECLARE @Score AS TINYINT = 80;
SELECT
	testid,
	PERCENT_RANK(@Score) WITHIN GROUP(ORDER BY score) AS Prcnt_Val-- SQL SERVER عدم پشتیبانی در
FROM Stats.Scores
GROUP BY testid;
GO

-- SQL Server معادل کوئری بالا در
DECLARE @Score AS TINYINT = 80;
WITH CTE
AS
(
	SELECT
		testid,
		COUNT(CASE WHEN score < @Score THEN 1 END) + 1 AS rk,
		COUNT(*) + 1 AS nr -- ???
	FROM Stats.Scores
	GROUP BY testid
)
SELECT
	testid,
	1.0 * (rk - 1) / (nr - 1) AS Prcnt_Val
FROM CTE;
GO

--------------------------------------------------------------------
-- CUME_DIST
--------------------------------------------------------------------
SELECT
	testid,score,
	CUME_DIST() OVER(PARTITION BY testid ORDER BY score) AS Cum_Val
FROM Stats.Scores;
GO

/*
Oeder Set Function & CUME_DIST
.مقدار فرضی 80 به‌ازای هر درس به‌صورت زیر خواهد شد CUME_DIST

  testid     Cum_Val
---------- ------------
 Test ABC     0.800
 Test XYZ     0.727
*/

/*
برای رسیدن به نتایج بالا نمی‌توان از این
.استفاده کرد SQL Server مدل کوئری‌نویسی در
*/
DECLARE @Score AS TINYINT = 80;
SELECT
	testid,
	CUME_DIST(@Score) WITHIN GROUP(ORDER BY score) AS Cum_Val-- SQL SERVER عدم پشتیبانی در
FROM Stats.Scores
GROUP BY testid;
GO

-- SQL Server معادل کوئری بالا در
DECLARE @Score AS TINYINT = 80;

WITH CTE
AS
(
	SELECT
		testid,
		COUNT(CASE WHEN score <= @Score THEN 1 END) + 1 AS np,
		COUNT(*) + 1 AS nr
	FROM Stats.Scores
	GROUP BY testid
)
SELECT
	testid,
	1.0 * np / nr AS Cum_Val
FROM CTE;
GO

/*
نکته مهم
Oeder Set Function به‌صورت CUME_DIST و PERCENT_RANK در شبیه‌سازی
.مقدار فرضی هم باید در محاسبات تعداد رکوردهای هر پارتیشن در نظر گرفته شود
*/