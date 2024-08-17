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
Sales.OrderValues: 830 Records

830 / 10 = 83 
830 % 10 = 0
*/
SELECT
	orderid, val,
	ROW_NUMBER() OVER(ORDER BY val) AS Row_Num,
	NTILE(10)	 OVER(ORDER BY val) AS Tile_Num
FROM Sales.OrderValues;
GO

/*
Sales.OrderValues: 830 Records

830 / 100 = 8 
830 % 100 = 30
*/
SELECT
	orderid, val,
	ROW_NUMBER() OVER(ORDER BY val) AS Row_Num,
	NTILE(100)	 OVER(ORDER BY val) AS Tile_Num
FROM Sales.OrderValues;
GO