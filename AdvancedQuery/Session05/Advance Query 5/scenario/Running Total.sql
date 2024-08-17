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

-- WF با استفاده از Running Total
SELECT
	actid, tranid, val,
	SUM(val) OVER( PARTITION BY actid
				   ORDER BY tranid
				   ROWS BETWEEN UNBOUNDED PRECEDING
							AND CURRENT ROW ) AS Total
FROM dbo.Transactions;
GO

-- JOIN با استفاده از Running Total
SELECT
	T1.actid, T1.tranid, T1.val,
	SUM(T2.val) AS Total
FROM dbo.Transactions AS T1
JOIN dbo.Transactions AS T2
	ON T2.actid = T1.actid
	AND T2.tranid <= T1.tranid
GROUP BY T1.actid, T1.tranid, T1.val;
GO

-- Subquery با استفاده از Running Total
SELECT
	actid, tranid, val,
	(SELECT SUM(T2.val) FROM dbo.Transactions AS T2
		WHERE T2.actid = T1.actid
		AND T2.tranid <= T1.tranid) AS Total
FROM dbo.Transactions AS T1;
GO