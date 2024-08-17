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
Query1
فهرست مجموع مبلغ کل سفارشات هر کارمند به‌همراه مجموع کل مبلغ همه سفارشات
*/
SELECT
	empid,
	SUM(val) AS Sum_Emp,
	SUM(SUM(val)) AS Sum_Emp -- غلط است
FROM Sales.OrderValues
GROUP BY empid;
GO

-- Query1 رفع مشکل
SELECT
	empid,
	SUM(val) AS Sum_Emp,
	(SELECT SUM(val) FROM Sales.OrderValues) AS Sum_All
FROM Sales.OrderValues
GROUP BY empid;
GO
--------------------------------------------------------------------

/*
Query2
فهرست مجموع مبلغ کل سفارشات هر کارمند
به‌همراه مجموع کل مبلغ همه سفارشات
همچنین محاسبه اختلاف و درصد مبلغ هر کارمند نسبت به مبلغ کل سفارشات
*/
SELECT
	empid,
	SUM(val) AS Sum_Emp, -- مجموع مبالغ هر کارمند
	(SELECT SUM(val) FROM Sales.OrderValues) AS Sum_All, -- مجموع مبالغ تمامی کارمندان
	SUM(val) - (SELECT SUM(val) FROM Sales.OrderValues) AS Diff, -- میزان اختلاف نسبت به مجموع کل
	SUM(val) / (SELECT SUM(val) FROM Sales.OrderValues) * 100 AS Prcnt -- میزان درصد نسبت به مجموع کل
FROM Sales.OrderValues
GROUP BY empid;
GO

/*
Query2 ساده‌سازی
All-at-once عدم اجرا‌ و خطا به‌دلیل مفهوم
*/
SELECT
	empid,
	SUM(val) AS Sum_Emp,
	(SELECT SUM(val) FROM Sales.OrderValues) AS Sum_All,
	Sum_Emp - (SELECT SUM(val) FROM Sales.OrderValues) AS Diff,
	Sum_Emp / (SELECT SUM(val) FROM Sales.OrderValues) * 100 AS Prcnt
FROM Sales.OrderValues
GROUP BY empid;
GO

/*
و بروز خطا Window Aggregate Function با استفاده از Query2 بازنویسی
*/
SELECT
	empid,
	SUM(val) AS Sum_Emp,
	SUM(val) OVER() AS Sum_All,
	SUM(val) - SUM(val) OVER() AS Diff,
	SUM(val) / SUM(val) OVER() * 100 AS Prcnt
FROM Sales.OrderValues
GROUP BY empid;
GO

/*
Query2-1
و به‌شکل درست Window Aggregate Function با استفاده از Query2 بازنویسی
*/
SELECT
	empid,
	SUM(val) AS Sum_Emp,
	SUM(SUM(val)) OVER() AS Sum_All,
	SUM(val) - SUM(SUM(val)) OVER() AS Diff,
	SUM(val) / SUM(SUM(val)) OVER() * 100 AS Prcnt
FROM Sales.OrderValues
GROUP BY empid;
GO

/*
Query2-1 ساده‌سازی
عدم اجرا‌ و خطا‌ 
*/
SELECT
	empid,
	SUM(val) AS Sum_Emp,
	SUM(Sum_Emp) OVER() AS Sum_All,
	SUM(val) - SUM(Sum_Emp) OVER() AS Diff,
	Sum_Emp / SUM(Sum_Emp) OVER() * 100 AS Prcnt
FROM Sales.OrderValues
GROUP BY empid;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی
.را به ساده‌ترین شکل ممکن بازنویسی کنید Query2-1
*/
WITH CTE
AS
(
	-- محاسبه مجموع مبالغ هر کارمند
	SELECT
		empid,
		SUM(val) AS Sum_Emp
	FROM Sales.OrderValues
	GROUP BY empid
)
SELECT
	empid,
	Sum_Emp AS Sum_Emp,
	SUM(Sum_Emp) OVER() AS Sum_All,
	Sum_Emp - SUM(Sum_Emp) OVER() AS Diff,
	Sum_Emp / SUM(Sum_Emp) OVER() * 100 AS Prcnt
FROM CTE;
GO