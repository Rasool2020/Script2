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
!!!وجود ندارد SQL Server ای درSyntax برای پیاده‌سازی فیلترینگ چنین
*/
SELECT
	empid, ordermonth, qty,
	qty - AVG(qty) FILTER (WHERE ordermonth >= '2017-07-01')
				   OVER(PARTITION BY empid) AS diff
FROM Sales.EmpOrders;
GO

SELECT * FROM Sales.EmpOrders
	WHERE empid = 9
	AND ordermonth BETWEEN '2017-07-01' AND '2017-12-31';
GO

/*
:می‌خواهیم به‌ازای کارمند شماره 9 و در سال 2017 کوئری زیر را بنویسیم
نیم‌سال دوم همان سال qty هرماه نسبت به میانگین qty محاسبه اختلاف

empid   ordermonth   qty     Diff
-----   ----------  -----   ------
  9     2017-01-01   74      -13 
  9     2017-03-01   137      50	 
  9     2017-04-01   52      -35 
  9     2017-05-01   8       -79 
  9     2017-06-01   161      74	 
  9     2017-07-01   4       -83 
  9     2017-08-01   98       11	 
  9     2017-09-01   93       6	 
  9     2017-10-01   24      -63 
  9     2017-11-01   222     135 
  9     2017-12-01   82      -5	 

*/

-- در نیم‌سال دوم 2017 برای کارمند شماره 9 qty میانگین
SELECT
	AVG(qty)
FROM  Sales.EmpOrders
	WHERE empid = 9 
	AND ordermonth BETWEEN '2017-07-01' AND '2017-12-31';
GO -- AVG(qty): 87

-- Window Aggregate Function بدون استفاده از
WITH CTE
AS
(
	SELECT
		AVG(qty) AS Avg_Val
	FROM  Sales.EmpOrders
		WHERE empid = 9 
	AND ordermonth BETWEEN '2017-07-01' AND '2017-12-31'
)
SELECT
	empid, ordermonth, qty,
	qty - (SELECT Avg_Val FROM CTE) AS Diff
FROM Sales.EmpOrders
	WHERE empid = 9
	AND ordermonth BETWEEN '2017-01-01' AND '2017-12-31';
GO

-- Window Aggregate Function با استفاده از
SELECT
	empid, ordermonth, qty,
	qty - AVG(CASE
				WHEN ordermonth BETWEEN '2017-07-01' AND '2017-12-31'
				THEN qty
				ELSE NULL
			   END) OVER() AS Diff
FROM Sales.EmpOrders
	WHERE empid = 9
	AND ordermonth BETWEEN '2017-01-01' AND '2017-12-31';
GO
--------------------------------------------------------------------

/*
تمرین کلاسی
کوئری بالا را به‌گونه‌ای بازنویسی کنید که محاسبات
.به‌ازای کارمند 9 و متناسب با هر سال انجام شود

 empid   ordermonth   qty   Diff
-------  ----------   ---  ------
  9      2016-07-01   294   103
  9      2016-10-01   256   65
  9      2016-12-01   25    -166
  9      2017-01-01   74    -13
  9      2017-03-01   137   50
  9      2017-04-01   52    -35
  9      2017-05-01   8     -79
  9      2017-06-01   161   74
  9      2017-07-01   4     -83
  9      2017-08-01   98    11
  9      2017-09-01   93    6
  9      2017-10-01   24    -63
  9      2017-11-01   222   135
  9      2017-12-01   82    -5
  9      2018-01-01   237   NULL
  9      2018-02-01   297   NULL
  9      2018-03-01   317   NULL
  9      2018-04-01   289   NULL

*/

-- Window Aggregate Function با استفاده از
SELECT
	empid, ordermonth, qty,
	qty - AVG(CASE
				WHEN MONTH(ordermonth) > 6
				THEN qty
				ELSE NULL
			   END) OVER(PARTITION BY YEAR(ordermonth)) AS Diff
FROM Sales.EmpOrders
	WHERE empid = 9;
GO

-- Window Aggregate Function بدون استفاده از
WITH CTE
AS
(
	SELECT
		AVG(CASE
				WHEN MONTH(ordermonth) <= 6 
				THEN NULL ELSE qty END) AS Avg_Value,
		YEAR(ordermonth) AS Year_Ordermonth
	FROM Sales.EmpOrders
		WHERE empid = 9
	GROUP BY YEAR(ordermonth)
)
SELECT
	E.empid, E.ordermonth, E.qty,
	E.qty - (SELECT Avg_Value FROM CTE 
				WHERE CTE.Year_Ordermonth = YEAR(E.ordermonth)) AS Diff
FROM Sales.EmpOrders AS E
	WHERE E.empid = 9;
GO