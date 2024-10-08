﻿--------------------------------------------------------------------
/*
Performance & Tuning in SQL Server 2017 دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
--Estimated Number of Rows
--Show Actual Plan
DROP TABLE IF EXISTS #TT
--ایجاد یک متغییر جدولی
DECLARE @TTV TABLE(ID INT NOT NULL PRIMARY KEY)
--ایجاد یک جدول موقت
CREATE TABLE #TT(ID INT NOT NULL PRIMARY KEY)
--درج دیتا تستی در متغییر جدولی و جدول موقت
;WITH N1(C) AS (SELECT 0 UNION ALL SELECT 0) -- 2 ROWS
,N2(C) AS (SELECT 0 FROM N1 AS T1 CROSS JOIN N1 AS T2) -- 4 ROWS
,N3(C) AS (SELECT 0 FROM N2 AS T1 CROSS JOIN N2 AS T2) -- 16 ROWS
,N4(C) AS (SELECT 0 FROM N3 AS T1 CROSS JOIN N3 AS T2) -- 256 ROWS
,IDS(ID) AS (SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) FROM N4)
INSERT INTO #TT(ID)
	SELECT ID FROM IDS
INSERT INTO @TTV(ID)
	SELECT ID FROM #TT
--استخراج کوئری در حالت های مختلق و مشاهده پلن
SELECT COUNT(*) FROM #TT
SELECT COUNT(*) FROM @TTV
SELECT COUNT(*) FROM @TTV OPTION (RECOMPILE)
GO
--------------------------------------------------------------------
