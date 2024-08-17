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

PERCENT_RANK() عملکرد تابع

X (rk-1) : تعداد رکوردهایی که در پارتیشن موردنظر مقدارشان از رکورد جاری کوچکتر است

Y (rn-1): 1 - تعداد کل رکوردهای پارتیشن موردنظر

PERCENT_RANK() = X/Y

*/

SELECT * FROM Stats.Scores
ORDER BY score;
GO

-- Ordering
SELECT
	testid, studentid, score,
	PERCENT_RANK() OVER(ORDER BY score) AS Prcnt_Val
FROM Stats.Scores;
GO
--------------------------------------------------------------------

-- Ordering & Partitioning
SELECT
	testid, studentid, score,
	PERCENT_RANK() OVER( PARTITION BY testid
						 ORDER BY score ) AS Prcnt_Val
FROM Stats.Scores;
GO
--------------------------------------------------------------------

-- !!!هیچ‌کدام از اسکریپت‌های زیر معتبر نیستند
SELECT
	testid, studentid, score,
	PERCENT_RANK() OVER( ORDER BY score
					     ROWS UNBOUNDED PRECEDING) AS Prcnt_Val
FROM Stats.Scores;
GO

SELECT
	testid, studentid, score,
	PERCENT_RANK() OVER(PARTITION BY testid) AS Prcnt_Val
FROM Stats.Scores;
GO