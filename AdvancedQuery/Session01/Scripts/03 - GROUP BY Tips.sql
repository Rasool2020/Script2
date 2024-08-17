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

/*
SELECT
    < select_list >   
FROM <table_source>
[ WHERE <search_condition> ]   
[ <GROUP BY> { column-expression  
			    | ROLLUP ( <group_by_expression> [ ,...n ] )  
			    | CUBE ( <group_by_expression> [ ,...n ] )  
			    | GROUPING SETS ( <grouping_set> [ ,...n ] ) ]
[ HAVING < search_condition > ] 
*/

USE NikamoozDB;
GO

-- .شرکت داشته باشند GROUP BY استفاده می‌شوند می‌بایست حتما در SELECT  فیلدهایی که در بخش
SELECT
	EmployeeID, CustomerID
FROM Orders
GROUP BY EmployeeID;--, CustomerID
GO
--------------------------------------------------------------------

-- .ظاهر نشده‌اند، استفاده کرد SELECT می‌توان از فیلدهایی که در بخش GROUP BY  در بخش
SELECT
	EmployeeID
FROM Orders
GROUP BY EmployeeID, CustomerID;
GO
--------------------------------------------------------------------

-- .شرکت کنند ORDER BY شرکت نکرده‌اند نمی‌توانند در بخش GROUP BY  فیلدهایی که در
SELECT
	EmployeeID
FROM Orders
GROUP BY EmployeeID, CustomerID
ORDER BY OrderID;
GO
--------------------------------------------------------------------

-- ???
SELECT * FROM Sales.Customers
GROUP BY *;
GO

-- راه‌کار کوئری بالا
SELECT DISTINCT * FROM Sales.Customers;
GO

--------------------------------------------------------------------

-- .نیامده باشد SELECT شرکت داده شود اما در بخش WHERE  یک فیلد می‌تواند در بخش
SELECT
	EmployeeID,
	COUNT(OrderID) AS Num
FROM Orders
	WHERE CustomerID < 50
GROUP BY EmployeeID;
GO
--------------------------------------------------------------------

-- .نیامده باشد SELECT شرکت داده شود اما در بخش HAVING  یک فیلد می‌تواند در بخش
SELECT
	EmployeeID,
	CustomerID
FROM Orders
GROUP BY EmployeeID, CustomerID
	HAVING COUNT(OrderID) > 5;
GO
--------------------------------------------------------------------

-- .غلط است
SELECT
	EmployeeID,
	CustomerID
FROM Orders
	HAVING COUNT(OrderID) > 5;
GO
--------------------------------------------------------------------

-- .استفاده از یک فیلد در دو نقش مجاز می‌باشد
SELECT
	City,
	COUNT(City) AS Num
FROM Customers
GROUP BY City;
GO
--------------------------------------------------------------------

-- Allowed
SELECT
	City + ' ' + State
FROM Employees
GROUP BY City, State;
GO

SELECT
	City + ' ' + State
FROM Employees
GROUP BY City + ' ' + State; 
GO

SELECT
	City + ' ' + State + ' * '
FROM Employees
GROUP BY City, State;
GO
--------------------------------------------------------------------

-- Not Allowed
SELECT
	City, State
FROM Employees
GROUP BY City + State;
GO

SELECT
	City + ' * ' + State
FROM Employees
GROUP BY City + State;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

تفاوت میان کوئری‌های زیر در چیست؟
*/

-- Query 1
SELECT 
	EmployeeID, COUNT(*) AS NumOrders
FROM Orders
	WHERE OrderDate < '20160506'
GROUP BY EmployeeID;
GO

-- Query 2
SELECT 
	EmployeeID, COUNT(*) AS NumOrders
FROM Orders
GROUP BY EmployeeID
	HAVING MAX(OrderDate) < '20160506';
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

کوئری‌ای بنویسید که در خروجی، فهرست مشتریانی را نمایش دهد که
.حداقل در یکی از تاریخ‌ها بیش از یک بار درخواست سفارش داده باشند

CustomerID
-----------
   10
   32
   39
   40
   47
   71

(6 rows affected)
*/
SELECT
	DISTINCT CustomerID
FROM Orders
GROUP BY CustomerID, OrderDate
	HAVING COUNT(OrderID) > 1;
GO
--------------------------------------------------------------------

/*
تمرین کلاسی

.اطلاعات مربوط به مشتریان ثبت شده است Customers در جدول
.از طرفی می‌دانیم که از هر شهر چندین مشتری داریم
کوئری‌ای بنویسید که مشخص کند به‌ازای تمامی مشتریان هر شهر
.تعداد کل سفارشات، مقدار بیشنه و کمینه سفارشات چقدر بوده است

Sum_Order   Min_Order   Max_Order    City
---------  ----------  ----------  ---------
  29          8            12       اردبیل
  24          5            19       ارومیه
  57          3            18       اصفهان
  ...	      	  		           
  30          12           18       کرمانشاه
  11          11           11       یاسوج
  51          4            15       یزد

(28 rows affected)
*/


/*
Subquery

Outer Query: Orders
Inner Query: Customers
*/
SELECT
	COUNT(O.OrderID) AS Num,
	(SELECT C.City FROM Customers AS C
		WHERE C.CustomerID = O.CustomerID)
FROM Orders AS O;
GO


-- !!!رفع مشکل کوئری بالا اما باز هم مناسب نیست
SELECT
	COUNT(O.OrderID) AS Num,
	(SELECT C.City FROM Customers AS C
		WHERE C.CustomerID = O.CustomerID)
FROM Orders AS O
GROUP BY O.CustomerID;
GO

/*
Subquery

Outer Query: Customers
Inner Query: Orders
*/
SELECT
	C.City,
	(SELECT COUNT(O.OrderID) FROM Orders AS O
		WHERE O.CustomerID = C.CustomerID)
FROM Customers AS C;
GO

-- Derived Table رفع مشکل کوئری بالا با استفاده از
SELECT
	Tmp.City,
	MAX(Tmp.Num) AS Max_Order,
	MIN(Tmp.Num) AS Min_Order,
	SUM (Tmp.Num) AS Sum_Order
FROM
(
SELECT
	C.City,
	(SELECT COUNT(O.OrderID) FROM Orders AS O
		WHERE O.CustomerID = C.CustomerID) AS Num
FROM Customers AS C
) AS Tmp
GROUP BY Tmp.City;
GO

/*
JOIN
*/
SELECT
	Tmp.City,
	MAX(Tmp.Num) AS Max_Order,
	MIN(Tmp.Num) AS Min_Order,
	SUM (Tmp.Num) AS Sum_Order
FROM
(SELECT
	C.City,
	COUNT(O.OrderID) AS Num
FROM Customers AS C
LEFT JOIN Orders AS O
	ON C.CustomerID = O.CustomerID
GROUP BY C.City, C.CustomerID) AS Tmp
GROUP BY Tmp.City;
GO
--------------------------------------------------------------------

/*
GROUP BY ALL
.فیلتر شده‌اند WHERE نمایش نتایجی که در شرط
*/ 
SELECT
	City,
	COUNT(City) AS Num
FROM Employees
	WHERE Birthdate >= '1962-01-01'
GROUP BY ALL City;
GO

/*
تمرین کلاسی

.شبیه‌سازی کنید GROUP BY ALL کوئری بالا را بدون استفاده از
*/
SELECT
	City,
	COUNT(CASE WHEN Birthdate >= '1962-01-01' THEN 1 END) AS Num
FROM Employees
GROUP BY City;
GO


-- GROUP BY ALL روشی دیگر برای شبیه‌سازی
SELECT
	City,
	COUNT(City) AS Num
FROM Employees
	WHERE Birthdate >= '1962-01-01'
GROUP BY City
UNION ALL
SELECT
	City, 0
FROM Employees
	WHERE City NOT IN (SELECT City FROM Employees
						WHERE Birthdate >= '1962-01-01');
GO
--------------------------------------------------------------------

-- GROUP BY ALL بر روی HAVING تاثیر
SELECT 
	City,
	COUNT(City) AS Num
FROM Employees
	WHERE Birthdate > '1962-01-01'
GROUP BY ALL City
	HAVING COUNT(*) > 2;
GO

