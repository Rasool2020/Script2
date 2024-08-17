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

-- تعداد سفارشات هر مشتری-کارمند
SELECT
	custid, empid,
	COUNT(orderid) AS Num
FROM Sales.OrderValues
	WHERE custid = 1
GROUP BY custid, empid
ORDER BY Num;
GO

/*
،اکنون می‌خواهیم بدانیم که مشتری 1 در هر لحظه با چه تعداد کارمند در ارتباط بوده است
:یعنی خروجی به‌صورت زیر باشد

custid   empid   orderdate    Num_Cust
------- ------- ------------ -----------
  1       6      2017-08-25      1
  1       4      2017-10-03      2
  1       4      2017-10-13      2
  1       1      2018-01-15      3
  1       1      2018-03-16      3
  1       3      2018-04-09      4


اما کوئری زیر به‌ازای هر ثبت‌سفارش، عملیات شمارش را انجام داده
،و اگر مشتری‌ای در تاریخ دیگر هم با کارمندی که قبلا شمارش شده
.ثبت‌سفارش داشته باشد آن را مجددا شمارش می‌کند
*/
SELECT
	custid, empid, orderdate,
	COUNT(orderid) OVER( PARTITION BY custid
						 ORDER BY orderdate ) AS Num_Cust
FROM Sales.OrderValues
	WHERE custid = 1;
GO

/*
،استفاده می‌کردیم DISTINCT برای رفع مشکل قبلا از
.نیستیم OVER در کنار بخش DISTINCT مجاز به استفاده از SQL Server اما در
*/
SELECT
	custid, empid, orderdate,
	COUNT(DISTINCT empid) OVER( PARTITION BY custid
								ORDER BY orderdate ) AS Distinct_Emp
FROM Sales.OrderValues
	WHERE custid = 1;
GO

-- راه‌حل پیشنهادی شما برای رفع مشکل بالا چیست؟
-- .استفاده می‌کنیم ROW_NUMBER ابتدا به‌ازای ترکیب هر مشتری-کارمند از
SELECT
	custid, empid, orderdate,
	ROW_NUMBER() OVER( PARTITION BY custid, empid
					   ORDER BY orderdate ) AS Distinct_Emp
FROM Sales.OrderValues
	WHERE custid = 1;
GO

-- .می‌شود NULL با استفاده از ترفند زیر مقادیر تکراری مشتری-کارمند
SELECT
	custid, empid, orderdate,
	CASE
		WHEN ROW_NUMBER() OVER( PARTITION BY custid, empid
								ORDER BY orderdate ) = 1
		THEN empid/*توضیح داده شود*/ END AS Distinct_Emp
FROM Sales.OrderValues
	WHERE custid = 1;
GO

/*
هدایت کرده و در بخش CTE اکنون کوئری بالا را به درون
.را با خیال راحت انجام می‌دهیم COUNT عملیات Outer Query
*/
WITH CTE
AS
(
	SELECT
	custid, empid, orderdate,
	CASE
		WHEN ROW_NUMBER() OVER( PARTITION BY custid, empid
								ORDER BY orderdate ) = 1
		THEN empid
	END AS Distinct_Emp
	FROM Sales.OrderValues
		WHERE custid = 1
)
SELECT
	custid, empid, orderdate,
	COUNT(Distinct_Emp) OVER( PARTITION BY custid
							  ORDER BY orderdate ) AS Num_Cust
FROM CTE;
GO

/*
ذخیره کرده SP شما می‌توانید کوئری زیر را در قالب یک
و با ایجاد پارامترهای موردنظر، در هر لحظه تشخیص دهید
.که مشتری موردنظرتان با چه تعداد کارمند در ارتباط بوده است 
*/
WITH CTE
AS
(
	SELECT
	custid, empid, orderdate,
	CASE
		WHEN ROW_NUMBER() OVER( PARTITION BY custid, empid
								ORDER BY orderdate ) = 1
		THEN empid END AS Distinct_Emp
	FROM Sales.OrderValues
)
SELECT
	custid, empid, orderdate,
	COUNT(Distinct_Emp) OVER( PARTITION BY custid
							  ORDER BY orderdate ) AS Num_Cust
FROM CTE;
GO