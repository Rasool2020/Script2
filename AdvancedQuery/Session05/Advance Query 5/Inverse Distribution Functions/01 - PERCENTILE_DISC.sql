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
	testid, studentid, score,
	CUME_DIST() OVER( PARTITION BY testid
					  ORDER BY score ) AS Cum_Val
FROM Stats.Scores;
GO

DECLARE @pct AS FLOAT = 0.2;
SELECT
	testid, score,
	PERCENTILE_DISC(@pct) WITHIN GROUP(ORDER BY score)
								  OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;
GO

DECLARE @pct AS FLOAT = 0.49;
SELECT
	testid, score,
	PERCENTILE_DISC(@pct) WITHIN GROUP(ORDER BY score)
								  OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;
GO

DECLARE @pct AS FLOAT = 1;
SELECT	
	testid, score,
	PERCENTILE_DISC(@pct) WITHIN GROUP(ORDER BY score)
								  OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;
GO
--------------------------------------------------------------------

-- !!!هیچ‌کدام از اسکریپت‌های زیر معتبر نیستند

DECLARE @pct AS FLOAT = 0.1;
SELECT
	testid, score,
	PERCENTILE_DISC(@pct) WITHIN GROUP()
								  OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;

SELECT
	testid, score,
	PERCENTILE_DISC(@pct) WITHIN GROUP(ORDER BY score, studentid)
								  OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;

SELECT
	testid, score,
	PERCENTILE_DISC(@pct) WITHIN GROUP(ORDER BY score)
								  OVER(PARTITION BY testid ORDER BY studentid) AS P_D
FROM Stats.Scores;
GO