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

SELECT * FROM Stats.Scores
ORDER BY testid;
GO

/*
:برای کوئری زیر PERCENTILE_CONT سناریو محاسبه

-----------------
testid = Test ABC
-----------------
n = 9 Records

a = @pct * (n - 1) = 0.5 * (9 - 1) = 4.0
a = 4.0		f = 0

.شمارش شوند Zero Base توجه: سطرهای هر پارتیشن به‌صورت
FLOOR(a)   = FLOOR(4.0)   = 4 ---> X = Row(4) = 75
CEILING(a) = CEILING(4.0) = 4 ---> Y = Row(4) = 75

PERCENTILE_CONT (@pct) = X  + f * (Y - X) 
PERCENTILE_CONT (0.5)  = 75 + 0 * (75 - 75) = 75
 
-----------------
testid = Test XYZ
-----------------
n = 10 Records

a = @pct * (n - 1) = 0.5 * (10 - 1) = 4.5
a = 4.5		f = 0.5

.شمارش شوند Zero Base توجه: سطرهای هر پارتیشن به‌صورت
FLOOR(a)   = FLOOR(4.5)   = 4 ---> X = Row(4) = 75
CEILING(a) = CEILING(4.5) = 5 ---> Y = Row(5) = 80

PERCENTILE_CONT (0.5) = X + f * (Y - X) 
PERCENTILE_CONT (0.5) = 75 + 0.5 * (80 - 75) = 77.5
*/
DECLARE @pct AS FLOAT = 0.5;
SELECT
	testid, score,
	PERCENTILE_CONT(@pct) WITHIN GROUP(ORDER BY score)
								   OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;
GO

DECLARE @pct AS FLOAT = 0.49;
SELECT
	testid, score,
	PERCENTILE_CONT( @pct) WITHIN GROUP(ORDER BY score)
								   OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;
GO

DECLARE @pct AS FLOAT = 0.56;
SELECT
	testid, score,
	PERCENTILE_CONT( @pct) WITHIN GROUP(ORDER BY score)
								   OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;
GO
--------------------------------------------------------------------

-- !!!هیچ‌کدام از اسکریپت‌های زیر معتبر نیستند

DECLARE @pct AS FLOAT = 0.1;
SELECT
	testid, score,
	PERCENTILE_CONT(@pct) WITHIN GROUP()
								  OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;

SELECT
	testid, score,
	PERCENTILE_CONT(@pct) WITHIN GROUP(ORDER BY score, studentid)
								  OVER(PARTITION BY testid) AS P_D
FROM Stats.Scores;

SELECT
	testid, score,
	PERCENTILE_CONT(@pct) WITHIN GROUP(ORDER BY score)
								  OVER(PARTITION BY testid ORDER BY studentid) AS P_D
FROM Stats.Scores;
GO

https://www.red-gate.com/simple-talk/sql/t-sql-programming/what-does-percentile_cont-do/