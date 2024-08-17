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

DROP TABLE IF EXISTS dbo.Users_Apps;
GO

CREATE TABLE dbo.Users_Apps
(
  Code INT PRIMARY KEY,
  App VARCHAR(10),
  UserID VARCHAR(10),
  Start_Time DATETIME,
  End_Time DATETIME
);
GO

INSERT INTO dbo.Users_Apps(Code, App, UserID, Start_Time, End_Time) 
VALUES
	(2,  'App1', 'user1', '20180212 08:30', '20180212 10:30'),
	(3,  'App1', 'user2', '20180212 08:30', '20180212 08:45'),
	(5,  'App1', 'user3', '20180212 09:00', '20180212 09:30'),
	(7,  'App1', 'user4', '20180212 09:15', '20180212 10:30'),
	(11, 'App1', 'user5', '20180212 09:15', '20180212 09:30'),
	(13, 'App1', 'user6', '20180212 10:30', '20180212 14:30'),
	(17, 'App1', 'user7', '20180212 10:45', '20180212 11:30'),
	(19, 'App1', 'user8', '20180212 11:00', '20180212 12:30'),
	(23, 'App2', 'user8', '20180212 08:30', '20180212 08:45'),
	(29, 'App2', 'user7', '20180212 09:00', '20180212 09:30'),
	(31, 'App2', 'user6', '20180212 11:45', '20180212 12:00'),
	(37, 'App2', 'user5', '20180212 12:30', '20180212 14:00'),
	(41, 'App2', 'user4', '20180212 12:45', '20180212 13:30'),
	(43, 'App2', 'user3', '20180212 13:00', '20180212 14:00'),
	(47, 'App2', 'user2', '20180212 14:00', '20180212 16:30'),
	(53, 'App2', 'user1', '20180212 15:30', '20180212 17:00');
GO
--------------------------------------------------------------------

-- WF حل مسئله بدون استفاده از
WITH CTE
AS 
(
	SELECT
		App, Start_Time,
		(SELECT COUNT(*) FROM dbo.Users_Apps AS US2
			WHERE US2.App = US1.App
			AND US2.Start_Time <= US1.Start_Time -- ها Task جاری نسبت به زمان شروع سایر Task بررسی زمان شروع
			AND US2.End_Time > US1.Start_Time) AS Num_Concurrent -- ها Task جاری نسبت به زمان پایان سایر Task بررسی زمان شروع ‌
	FROM dbo.Users_Apps AS US1
)
SELECT
	App, MAX(Num_Concurrent) AS Num_Concurrent
FROM CTE
GROUP BY App;
GO
--------------------------------------------------------------------

-- Window Aggregate Function با استفاده از
WITH CTE1 -- Flag به‌همراه مقدار Session ترکیب مقادیر آغازین و پایانی هر
AS
(
	SELECT
		App, Start_Time AS S_Time, 1 AS Typ
	FROM dbo.Users_Apps

	UNION ALL

	SELECT
		App, End_Time, -1
	FROM dbo.Users_Apps
),
CTE2 -- Window Aggregate Function محاسبه با استفاده از
AS
(
	SELECT
		*,
		SUM(Typ) OVER( PARTITION BY App 
					   ORDER BY S_Time, Typ
					   ROWS BETWEEN UNBOUNDED PRECEDING
								AND CURRENT ROW) AS cnt
	FROM CTE1
)
SELECT -- App نمایش مقادیر بیشینه به‌ازای هر
	App,
	MAX(cnt) AS Num_Concurrent
FROM CTE2
GROUP BY App;
GO

/*
.تودرتو استفاده می‌کنیم CTE برای حل این مساله از

.می‌کنیم UNION ALL را با یکدیگر Users_Apps از جدول SELECT حاصل دو CTE1 در
آغاز Flag هر رکورد به‌همراه مقدار 1 به‌عنوان Start_Time شامل مقادیر SELECT اولین
.پایان Flag هر رکورد به‌همراه مقدار 1 به‌عنوان End_Time شامل مقادیر SELECT و دومین

  App          S_Time             Typ
-----  ------------------------  -----
 App1   2018-02-12 08:30:00.000    1
 App1   2018-02-12 08:30:00.000    1
 App1   2018-02-12 09:00:00.000    1
 ...  							   
 App2   2018-02-12 14:00:00.000   -1
 App2   2018-02-12 16:30:00.000   -1
 App2   2018-02-12 17:00:00.000   -1



App پارتیشن‌بندی را بر روی فیلد CTE2 سپس در
را هم به‌صورت صعودی و براساس Ordering و
.انجام می‌دهیم S_Time, Typ ترکیب فیلدهای
است Session حاصل ترکیب مقادیر شروع و پایان هر S_Time فیلد
.هم شامل مقادیر 1 به‌نشانه شروع و 1- برای پایان است Typ و فیلد
.می‌گذاریم SUM(Typ) از این‌جا به‌بعد هم همه چیز را به‌عهده تابع

 App            S_Time             Typ    cnt
------  ------------------------  -----  -----
 App1    2018-02-12 08:30:00.000    1      1
 App1    2018-02-12 08:30:00.000    1      2
 App1    2018-02-12 08:45:00.000   -1      1
 App1    2018-02-12 09:00:00.000    1      2
 App1    2018-02-12 09:15:00.000    1      3
 App1    2018-02-12 09:15:00.000    1      4
 App1    2018-02-12 09:30:00.000   -1      3
 App1    2018-02-12 09:30:00.000   -1      2
 App1    2018-02-12 10:30:00.000   -1      1
 App1    2018-02-12 10:30:00.000   -1      0
 App1    2018-02-12 10:30:00.000    1      1
 App1    2018-02-12 10:45:00.000    1      2
 App1    2018-02-12 11:00:00.000    1      3
 App1    2018-02-12 11:30:00.000   -1      2
 App1    2018-02-12 12:30:00.000   -1      1
 App1    2018-02-12 14:30:00.000   -1      0
 App2    2018-02-12 08:30:00.000    1      1
 App2    2018-02-12 08:45:00.000   -1      0
 App2    2018-02-12 09:00:00.000    1      1
 App2    2018-02-12 09:30:00.000   -1      0
 App2    2018-02-12 11:45:00.000    1      1
 App2    2018-02-12 12:00:00.000   -1      0
 App2    2018-02-12 12:30:00.000    1      1
 App2    2018-02-12 12:45:00.000    1      2
 App2    2018-02-12 13:00:00.000    1      3
 App2    2018-02-12 13:30:00.000   -1      2
 App2    2018-02-12 14:00:00.000   -1      1
 App2    2018-02-12 14:00:00.000   -1      0
 App2    2018-02-12 14:00:00.000    1      1
 App2    2018-02-12 15:30:00.000    1      2
 App2    2018-02-12 16:30:00.000   -1      1
 App2    2018-02-12 17:00:00.000   -1      0
 
 به‌ازای  CTE در پایان هم در بخش کوئری بیرونی
. مقدار ماکزیموم محاسبه شده را می‌خوانیم App هر
*/

--------------------------------------------------------------------

-- ROW_NUMBER حل مسئله با استفاده از
WITH CTE1
AS
(
	SELECT
		App, Start_Time AS ST,
		ROW_NUMBER() OVER( PARTITION BY App
						   ORDER BY Start_Time ) AS start_ordinal -- .آغاز شده است Session تاکنون چه تعداد
	FROM dbo.Users_Apps

	UNION ALL

	SELECT
		App, End_Time, NULL
	FROM dbo.Users_Apps
),
CTE2 AS
(
	SELECT
		*,
		ROW_NUMBER() OVER( PARTITION BY App 
						   ORDER BY ST ) AS start_or_end_ordinal -- .آغاز شده و یا به پایان رسیده است Session تاکنون چه تعداد
	FROM CTE1
)
SELECT
	App,
	MAX(start_ordinal - (start_or_end_ordinal - start_ordinal)) AS Num_Concurrent
	/*
	(start_or_end_ordinal - start_ordinal) فعالیتش تمام شده است Session چه تعداد
	*/
FROM CTE2
GROUP BY App;
GO