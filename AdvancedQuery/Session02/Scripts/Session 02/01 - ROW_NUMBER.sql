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

SELECT
	*,
	ROW_NUMBER() OVER(ORDER BY orderid) AS Num
FROM Sales.OrderValues;
GO

SELECT
	orderid, val,
	ROW_NUMBER() OVER(ORDER BY orderid) AS Row_Num
FROM Sales.OrderValues;
GO

/*
تمرین کلاسی
ها بازنویسی کنید؟ Window Function آیا می‌توانید کوئری بالا را بدون استفاده از
*/
-- JOIN
SELECT
	O1.orderid,
	O1.val,
	COUNT(O1.orderid) AS Row_Num
FROM Sales.OrderValues AS O1
JOIN Sales.OrderValues AS O2
	ON O1.orderid >= O2.orderid
GROUP BY O1.orderid, O1.val
ORDER BY O1.orderid;
GO

-- Subquery
SELECT
	O1.orderid,
	O1.val,
	(SELECT COUNT(O2.orderid) FROM Sales.OrderValues AS O2
		WHERE O1.orderid >= O2.orderid) AS Row_Num
FROM Sales.OrderValues AS O1;
GO
--------------------------------------------------------------------

-- بر روی بیش از یک فیلد Ordering
SELECT
	orderid, custid, empid, val,
	ROW_NUMBER() OVER(ORDER BY custid DESC, empid) AS Row_Num
FROM Sales.OrderValues;
GO
--------------------------------------------------------------------

-- اضافی ORDER BY تاثیر

/*
.معادل با یکدیگر هستند Query2 و Query1
اضافی تاثیری بر روی نتایج نهایی ندارد اما ORDER BY
.اضافی توجه شود Sort اجرایی هر دو کوئری و اپراتور Plan به
*/
-- Query1
SELECT
	orderid, orderdate, val,
	ROW_NUMBER() OVER(ORDER BY orderdate) AS Row_Num
FROM Sales.OrderValues;
GO

-- Query2
SELECT
	orderid, orderdate, val,
	ROW_NUMBER() OVER(ORDER BY orderdate) AS Row_Num
FROM Sales.OrderValues
ORDER BY orderid;
GO

/*
Window Function اضافی بر روی عملکرد ORDER BY
.تاثیرگذار نیست اما نمایش نتایج را به هم می‌ریزد
*/
SELECT
	orderid, val,
	ROW_NUMBER() OVER(ORDER BY orderid) AS Row_Num
FROM Sales.OrderValues;
GO

SELECT
	orderid, val,
	ROW_NUMBER() OVER(ORDER BY orderid) AS Row_Num
FROM Sales.OrderValues
ORDER BY val DESC;
GO
--------------------------------------------------------------------

-- OVER از بخش ORDER BY مربوط به عبارت Cost حذف

DROP TABLE IF EXISTS Test_Cost;
GO

CREATE TABLE Test_Cost
(
	ID INT IDENTITY,
	Family NVARCHAR(100)
);
GO

SET NOCOUNT ON;
GO

INSERT INTO Test_Cost
	VALUES (N'بهرامی'),(N'سعادت'),(N'پویا'),(N'اکبری'),(N'شجاعیان');
GO 1000

SELECT * FROM Test_Cost;
GO

-- .دیده می‌شود Sort در پلن کوئری اپراتور
SELECT
	*, ROW_NUMBER() OVER(ORDER BY Family) AS Row_Num
FROM Test_Cost;
GO

-- .دیده نخواهد شد Sort در پلن کوئری اپراتور
SELECT
	*, ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS Row_Num
FROM Test_Cost;
GO

-- .دیده نخواهد شد Sort در پلن کوئری اپراتور
SELECT
	*, ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS Row_Num
FROM Test_Cost;
GO

-- .دیده نخواهد شد Sort در پلن کوئری اپراتور
SELECT
	*, ROW_NUMBER() OVER(ORDER BY (SELECT 100)) AS Row_Num
FROM Test_Cost;
GO

-- OVER در بخش ORDER BY کوئری غیرمجاز به‌دلیل عدم وجود
SELECT
	*, ROW_NUMBER() OVER() AS Row_Num
FROM Test_Cost;
GO

-- OVER از بخش ORDER BY عدم استفاده از مقادیر ثابت در جلو عبارت
SELECT
	orderid, orderdate, val,
	ROW_NUMBER() OVER(ORDER BY NULL) AS Row_Num
FROM Sales.OrderValues;
GO
--------------------------------------------------------------------

DROP TABLE IF EXISTS T1;
GO

CREATE TABLE T1
(
	Col1 CHAR(1) NOT NULL
);
GO

INSERT INTO T1
	VALUES ('A'),('B'),('C'),('D'),('E'),('F');
GO

SELECT * FROM T1;
GO

-- به‌نظر شما خروجی کوئری زیر چه خواهد بود؟
SELECT
	Col1
FROM T1
	WHERE Col1 > 'B'
	AND ROW_NUMBER() OVER(ORDER BY Col1) <= 3;
GO

-- WHERE ها در بخش WF عدم استفاده از
SELECT
	orderid, orderdate, val,
	ROW_NUMBER() OVER(ORDER BY orderdate) AS Row_Num
FROM Sales.OrderValues
	WHERE Row_Num > 100
ORDER BY Row_Num;
GO

-- WHERE ها در بخش WF عدم استفاده از
SELECT
	orderid, orderdate, val,
	ROW_NUMBER() OVER(ORDER BY orderdate) AS Row_Num
FROM Sales.OrderValues
	WHERE ROW_NUMBER() OVER(ORDER BY orderdate) > 100
ORDER BY Row_Num;
GO

-- CTE دور زدن محدودیت با استفاده از
WITH CTE
AS
(
	SELECT
		orderid, orderdate, val,
		ROW_NUMBER() OVER(ORDER BY orderdate) AS Row_Num
	FROM Sales.OrderValues
)
SELECT * FROM CTE
	WHERE Row_Num > 100;
GO

-- Derived Table دور زدن محدودیت با استفاده از
SELECT * FROM
(
	SELECT
		orderid, orderdate, val,
		ROW_NUMBER() OVER(ORDER BY orderdate) AS Row_Num
	FROM Sales.OrderValues
) AS Tmp
	WHERE Tmp.Row_Num > 100;
GO
--------------------------------------------------------------------

SELECT * FROM HR.Employees;
GO

-- ???
SELECT
	DISTINCT country,
	ROW_NUMBER() OVER(ORDER BY country) AS rownum
FROM HR.Employees;
GO

/*
تمرین کلاسی

اگر بخواهیم خروجی کوئری بالا به‌صورت زیر باشد
.چگونه باید آن را بازنویسی کنیم

 country   Row_Num
--------  --------
  UK         1
  USA        2

(2 rows affected)
*/

-- CTE
WITH CTE
AS
(
	SELECT
		DISTINCT country
	FROM HR.Employees
)
SELECT
	country,
	ROW_NUMBER() OVER(ORDER BY country) AS Row_Num
FROM CTE;
GO

-- Derived Table
SELECT
	Tmp.country,
	ROW_NUMBER() OVER(ORDER BY Tmp.country) AS Row_Num
FROM
(
	SELECT
		DISTINCT country
	FROM HR.Employees
) AS Tmp;
GO