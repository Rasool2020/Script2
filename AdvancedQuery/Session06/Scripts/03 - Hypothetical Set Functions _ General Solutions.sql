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
می‌خواهیم در این‌جا به‌ازای یک مقدار فرضی برابر  
.را انجام دهیم DENSE_RANK و RANK با 1000.00 محاسبات
*/
SELECT
	custid, val AS Return_Flag
FROM Sales.OrderValues AS D
ORDER BY custid, val;
GO

/*
.یعنی در کوئری بالا مقدار فرضی به‌ازای هر مشتری برابر با مقادیر زیر خواهد بود

custid   Rnk    D_Rnk
-------  ----  ---------
  1       7		   7
  2       5		   5
  3       6		   6
  4       10	   10
  5       7		   7
  ...
*/

SELECT
	custid, Tmp.Rnk, Tmp.D_Rnk
FROM Sales.Customers AS C
CROSS APPLY (SELECT 
				RANK() OVER(ORDER BY val) AS Rnk,
				DENSE_RANK() OVER(ORDER BY val) AS D_Rnk,
				Return_Flag
			 FROM (SELECT val, 0 AS Return_Flag	FROM Sales.OrderValues AS Cust_Val
						WHERE Cust_Val.custid = C.custid

				   UNION ALL

				   SELECT 1000.00, 1
				   ) AS Const
			 ) AS Tmp
	WHERE Return_Flag = 1;
GO

/*
حال فرض کنید می‌خواهیم مثال را ساده‌سازی کنیم
مثلا برای مشتری 1

:تحلیل منطقی کوئری به‌صورت زیر است
.تحویل داده می‌شود CROSS APPLY مشتری 1 از کوئری بیرونی به
C.custid = 1

که در بخش Tmp داریم با نام Derived Table این‌جا یک
میان تمامی مقادیر UNION ALL آن عملیات FROM
:های مختلف هر مشتری با یک مقدار ثابت انجام می‌شود؛ یعنی داریمVal

SELECT
	val, 0 AS Return_Flag
FROM Sales.OrderValues AS Cust_Val
	WHERE Cust_Val.custid = 1 --P.custid


 val       Return_Flag
-------   -----------
814.50        0
878.00        0
330.00        0
845.80        0
471.20        0
933.50        0


SELECT 1000.00, 1

 val       Return_Flag
-------   -----------
1000.00       1

:خواهیم داشت UNION ALL که پس از 

SELECT
	val, 0 AS Return_Flag
FROM Sales.OrderValues AS Cust_Val
	WHERE Cust_Val.custid = 1 --P.custid

UNION ALL

SELECT 1000.00, 1

  val      Return_Flag
-------   -----------
 814.50       0
 878.00       0
 330.00       0
 845.80       0
 471.20       0
 933.50       0
 1000.00      1


:عملیات رنکینگ را روی نتایج بالا انجام می‌دهد؛ یعنی داریم Derived Table مربوط به SELECT سپس در ادامه

Rnk   D_Rnk    Return_Flag
---   -------  ------------
1       1          0
2       2          0
3       3          0
4       4          0
5       5          0
6       6          0
7       7          1

.این کار به‌ازای تک‌تک مشتریان انجام می‌شود
در پایان هم فقط رکوردهایی را در خروجی نمایش می‌دهیم
.آن برابر با 1 باشد؛ یعنی همان رتبه‌بندی برای مقدار فرضی Return_Flag که مقدار فیلد
*/

/*
با روش عمومی Ranking Order Set Function (Rank) مقایسه روش پیشنهادی برای
*/
SELECT
	C.custid,
	(SELECT COUNT(CASE WHEN val < 1000.00 THEN 1 END) + 1
	 FROM Sales.OrderValues AS OV
		WHERE C.custid = OV.custid) AS Rnk
FROM Sales.Customers AS C;
GO

SELECT
	custid, Tmp.Rnk, Tmp.D_Rnk
FROM Sales.Customers AS C
CROSS APPLY (SELECT 
				RANK() OVER(ORDER BY val) AS Rnk--,
				,DENSE_RANK() OVER(ORDER BY val) AS D_Rnk,
				Return_Flag
			 FROM (SELECT val, 0 AS Return_Flag	FROM Sales.OrderValues AS Cust_Val
						WHERE Cust_Val.custid = C.custid

				   UNION ALL

				   SELECT 1000.00, 1
				   ) AS Const
			 ) AS Tmp
	WHERE Return_Flag = 1;
GO
--------------------------------------------------------------------

/*
با روش عمومی Ranking Order Set Function (DENSE_Rank) مقایسه روش پیشنهادی برای
*/
SELECT
	C.custid,
	(SELECT COUNT(DISTINCT CASE WHEN val < 1000.00 THEN val END) + 1 
	 FROM Sales.OrderValues AS OV
		WHERE C.custid = OV.custid) AS D_Rnk
FROM Sales.Customers AS C
GO

SELECT
	custid, Tmp.Rnk, Tmp.D_Rnk
FROM Sales.Customers AS C
CROSS APPLY (SELECT 
				RANK() OVER(ORDER BY val) AS Rnk,
				DENSE_RANK() OVER(ORDER BY val) AS D_Rnk,
				Return_Flag
			 FROM (SELECT val, 0 AS Return_Flag	FROM Sales.OrderValues AS Cust_Val
						WHERE Cust_Val.custid = C.custid

				   UNION ALL

				   SELECT 1000.00, 1
				   ) AS Const
			 ) AS Tmp
	WHERE Return_Flag = 1;
GO

----------------------------------------------------------------------
-- PERCENT_RANK
----------------------------------------------------------------------

SELECT
	testid, pctrank
FROM Stats.Tests AS P
  CROSS APPLY (SELECT 
                 PERCENT_RANK() OVER(ORDER BY score) AS pctrank,
                 return_flag
               FROM (SELECT score, 0 AS return_flag
                     FROM Stats.Scores AS D
                     WHERE D.testid = P.testid
               
                     UNION ALL
               
                     SELECT 80, 1
					 ) AS U
				) AS A
	WHERE return_flag = 1;
GO

WITH C
AS
(
	SELECT
		testid,
		COUNT(CASE WHEN score < 80 THEN 1 END) + 1 AS rk,
		COUNT(*) + 1 AS nr
	FROM Stats.Scores
	GROUP BY testid
)
SELECT
	testid,
	1.0 * (rk - 1) / (nr - 1) AS pctrank
FROM C;
GO

----------------------------------------------------------------------
-- CUME_DIST
----------------------------------------------------------------------

SELECT
	testid, cumedist
FROM Stats.Tests AS P
CROSS APPLY (SELECT 
                 CUME_DIST() OVER(ORDER BY score) AS cumedist,
                 return_flag
             FROM (SELECT score, 0 AS return_flag
				   FROM Stats.Scores AS D
						WHERE D.testid = P.testid
               
                     UNION ALL
               
                     SELECT 80, 1
				  ) AS U
			) AS A
	WHERE return_flag = 1;
GO

WITH C
AS
(
	SELECT
		testid,
		COUNT(CASE WHEN score <= 80 THEN 1 END) + 1 AS np,
		COUNT(*) + 1 AS nr
	FROM Stats.Scores
	GROUP BY testid
)
SELECT
	testid,
	1.0 * np / nr AS cumedist
FROM C;
GO