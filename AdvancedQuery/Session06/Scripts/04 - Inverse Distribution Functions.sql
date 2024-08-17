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

DECLARE @pct AS FLOAT = 0.5;
SELECT
	testid, score,
	PERCENTILE_DISC(@pct) WITHIN GROUP(ORDER BY score) OVER(PARTITION BY testid) AS P_Disc,
	PERCENTILE_CONT(@pct) WITHIN GROUP(ORDER BY score) OVER(PARTITION BY testid) AS P_Cont
FROM Stats.Scores;
GO

/*
  testid    P_Disc  P_Cont
---------- ------- -------
 Test ABC    75      75
 Test XYZ    75      77.5
*/

/*
برای رسیدن به نتایج بالا نمی‌توان از این
.استفاده کرد SQL Server مدل کوئری‌نویسی در
*/
DECLARE @pct AS FLOAT = 0.5;
SELECT
	testid, 
	PERCENTILE_DISC(@pct) WITHIN GROUP(ORDER BY score) AS P_Disc,
	PERCENTILE_CONT(@pct) WITHIN GROUP(ORDER BY score) AS P_Cont
FROM Stats.Scores
GROUP BY testid;
GO

-- روش اول
SELECT
	DISTINCT testid,
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY score) OVER(PARTITION BY testid) AS P_Disc,
	PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY score) OVER(PARTITION BY testid) AS P_Cont
FROM Stats.Scores;
GO

-- روش دوم
WITH C
AS
(
	SELECT
		testid,
		PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY score) OVER(PARTITION BY testid) AS P_Disc,
		PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY score) OVER(PARTITION BY testid) AS P_Cont,
		ROW_NUMBER() OVER(PARTITION BY testid ORDER BY (SELECT NULL)) AS Row_Num
	FROM Stats.Scores
)
SELECT
	testid, P_Disc, P_Cont
FROM C
	WHERE Row_Num = 1;
GO

-- روش سوم;
SELECT
	TOP (1) WITH TIES testid,
	PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY score) OVER(PARTITION BY testid) AS P_Disc,
	PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY score) OVER(PARTITION BY testid) AS P_Cont
FROM Stats.Scores
ORDER BY ROW_NUMBER() OVER(PARTITION BY testid ORDER BY (SELECT NULL));
GO