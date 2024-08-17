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
	LAST_VALUE(val) OVER(ORDER BY orderdate, orderid) AS L_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	LAST_VALUE(val) OVER( ORDER BY orderdate, orderid
						  ROWS BETWEEN UNBOUNDED PRECEDING
								   AND CURRENT ROW ) AS L_Val
FROM Sales.OrderValues;
GO

-- در هر لحظه سطر جاری و 3 سطر بعد از آن
SELECT
	custid, orderdate, orderid, val,
	LAST_VALUE(val) OVER( ORDER BY orderdate, orderid
						  ROWS BETWEEN CURRENT ROW
								   AND 3 FOLLOWING ) AS F_Val
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
	LAST_VALUE(val) OVER( PARTITION BY custid
						  ORDER BY orderdate, orderid ) AS L_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	LAST_VALUE(val) OVER( PARTITION BY custid
						  ORDER BY orderdate, orderid
						  ROWS BETWEEN UNBOUNDED PRECEDING 
								   AND UNBOUNDED FOLLOWING ) AS L_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	LAST_VALUE(val) OVER( PARTITION BY custid
						  ORDER BY orderdate, orderid
						  ROWS BETWEEN CURRENT ROW 
								   AND 2 FOLLOWING ) AS L_Val
FROM Sales.OrderValues;
GO
--------------------------------------------------------------------
/*
تمرین کلاسی

کوئری‌ای بنویسید که  LAST_VALUE و FIRST_VALUE با استفاده از
.جلو هر سطر، اولین و آخرین مبلغ سفارش هر مشتری را نمایش دهد

custid    orderdate    orderid      val     F_Val     L_Val
-------  -----------  ---------  --------  --------  --------
  1       2017-08-25   10643      814.50    814.50    933.50
  1       2017-10-03   10692      878.00    814.50    933.50
  1       2017-10-13   10702      330.00    814.50    933.50
  1       2018-01-15   10835      845.80    814.50    933.50
  1       2018-03-16   10952      471.20    814.50    933.50
  1       2018-04-09   11011      933.50    814.50    933.50
  ...	 			  		     		   			 
  91      2016-12-05   10374      459.00    459.00    591.60
  91      2017-07-25   10611      808.00    459.00    591.60
  91      2017-12-23   10792      399.85    459.00    591.60
  91      2018-02-04   10870      160.00    459.00    591.60
  91      2018-02-25   10906      427.50    459.00    591.60
  91      2018-04-03   10998      686.00    459.00    591.60
  91      2018-04-23   11044      591.60    459.00    591.60

(830 rows affected)
*/
SELECT
	custid, orderdate, orderid, val,
	FIRST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate,orderid) AS F_Val,
	LAST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate,orderid
							ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS L_Val
FROM Sales.OrderValues;
GO

/*
در ادامه کوئری بالا را به‌گونه‌ای تغییر دهید
که جلو هر سطر اختلاف میان مبلغ جاری با 
.اولین و آخرین مبلغ سفارش هر مشتری محاسبه شود
*/
SELECT
	custid, orderdate, orderid, val,
	val - FIRST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid) AS Diff_F_Val,
	val - LAST_VALUE(val) OVER(PARTITION BY custid ORDER BY orderdate, orderid
								ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Diff_L_Val
FROM Sales.OrderValues;
GO
--------------------------------------------------------------------

-- !!!هیچ‌کدام از اسکریپت‌های زیر معتبر نیستند
SELECT
	custid, orderdate, orderid, val,
	LAST_VALUE(val) OVER() AS L_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	LAST_VALUE(val) OVER(PARTITION BY custid) AS L_Val
FROM Sales.OrderValues;
GO

SELECT
	custid, orderdate, orderid, val,
	LAST_VALUE(val) OVER( PARTITION BY custid
						  ROWS BETWEEN UNBOUNDED PRECEDING
								   AND CURRENT ROW ) AS L_Val
FROM Sales.OrderValues;
GO