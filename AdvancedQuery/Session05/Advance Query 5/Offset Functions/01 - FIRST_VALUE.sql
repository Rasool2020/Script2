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
Ordering

: توجه شود Framing در کوئری زیر به‌مقدار پیش‌فرض
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
*/
SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER(ORDER BY orderdate, orderid) AS F_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER( ORDER BY orderdate, orderid
						   ROWS BETWEEN UNBOUNDED PRECEDING
									AND CURRENT ROW ) AS F_Val
FROM Sales.OrderValues;
GO

-- در هر لحظه سطر جاری و 2 سطر قبل از آن
SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER( ORDER BY orderdate, orderid
						   ROWS 2 PRECEDING ) AS F_Val
FROM Sales.OrderValues;
GO
--------------------------------------------------------------------

/*
Ordering & Partitioning

: توجه شود Framing در کوئری زیر به‌مقدار پیش‌فرض
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
*/
SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER( PARTITION BY custid
						   ORDER BY orderdate, orderid ) AS F_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER( PARTITION BY custid
						   ORDER BY orderdate, orderid
						   ROWS BETWEEN CURRENT ROW
									AND 2 FOLLOWING ) AS F_Val
FROM Sales.OrderValues;
GO
--------------------------------------------------------------------

/*
نکته مهم
.نیست MAX یا MIN اولین و یا آخرین مقدار لزوما مقدار
*/
DROP TABLE IF EXISTS Test_First_Min;
GO

CREATE TABLE Test_First_Min
(
    Emp_ID VARCHAR(10),
    HireDate DATE NOT NULL,
    Salary INT NOT NULL
);
GO

INSERT INTO Test_First_Min
VALUES
    ('Emp1', '2018-01-01', 20000),
    ('Emp2', '2018-02-15', 19000),
    ('Emp3', '2018-03-12', 22000),
    ('Emp4', '2018-04-07', 25000),
    ('Emp5', '2018-05-26', 18500);
GO

SELECT * FROM Test_First_Min;
GO

SELECT
	Emp_ID, Salary, HireDate,
	First_VALUE(HireDate) OVER( ORDER BY Salary
								RANGE BETWEEN UNBOUNDED PRECEDING
										  AND UNBOUNDED FOLLOWING ) AS First_Val,
	Min(HireDate) OVER( ORDER BY Salary
						RANGE BETWEEN UNBOUNDED PRECEDING
								  AND UNBOUNDED FOLLOWING) AS Min_Val
FROM Test_First_Min;
GO
--------------------------------------------------------------------

-- !!!هیچ‌کدام از اسکریپت‌های زیر معتبر نیستند
SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER() AS F_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER(PARTITION BY custid) AS F_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER( PARTITION BY custid
						   ROWS BETWEEN UNBOUNDED PRECEDING
									AND CURRENT ROW ) AS F_Val
FROM Sales.OrderValues;
GO