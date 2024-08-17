--------------------------------------------------------------------
/*
SQL Server 2017 در High Availability دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
/*
Mirror Database های آسیب دیده با استفاده از Page کردن خودکار Repair
را راه اندازی کنیم Mirroring برای راه اندازی این مثال باید 
*/
--------------------------------------------------------------------
USE NikAmoozDB2017_Mirror
GO
--ساخت یک جدول تستی
DROP TABLE IF EXISTS NikAmoozTearchers
GO
--در نظر گرفته شده استFixed Length فیلدهای جدول از قصد 
CREATE TABLE NikAmoozTearchers
(
	TeacherID INT PRIMARY KEY,
	FullName CHAR(8000)
)
GO
INSERT INTO NikAmoozTearchers (TeacherID,FullName) VALUES
(1,'Masoud Taheri'),
(2,'Farid Taheri'),
(3,'Alireza Orumand'),
(4,'Hosein Khoshrafter'),
(5,'Mehdi Shishebori')
GO
SELECT * FROM NikAmoozTearchers
GO
--------------------------------------------------------------------
--های وابسته به یک جدولPage بدست آوردن 
DBCC IND('NikAmoozDB2017_Mirror','NikAmoozTearchers',-1) WITH NO_INFOMSGS
GO
--DBCC IND معادل 
SELECT 
	* 
FROM sys.dm_db_database_page_allocations
	(
		DB_ID('NikAmoozDB2017_Mirror'),OBJECT_ID('NikAmoozTearchers'),
		NULL,NULL,'DETAILED'
	)
GO
-------------------------------
--ی قرار داردPageهر رکورد در چه 
SELECT 
	sys.fn_PhysLocFormatter (%%physloc%%) AS [Physical RID], 
	* 
FROM NikAmoozTearchers
GO
SELECT 
	* 
FROM NikAmoozTearchers AS T 
	CROSS APPLY sys.fn_PhysLocCracker(%%physloc%%) AS FPLC
ORDER BY 
	FPLC.file_id, FPLC.page_id, FPLC.slot_id
GO
-------------------------------
--Page مشاهده محتوای 
--DBCC PAGE بررسی تصویر برای دستور
DBCC TRACEON(3604);
DBCC PAGE('NikAmoozDB2017_Mirror',1,xxx,1)WITH NO_INFOMSGS
GO
--------------------------------------------------------------------
--خاموش شود Mirror Server حالا 
--باشد Disconnected وضعیت بانک اطلاعاتی چک شود الان باید در حالت 
USE master
GO
--سرور اصلی استاپ شودSQL Server سرویس 
--برای تغییر محتوای فایل Hex Editor استفاده از 
--پیدا کردن آدرسی که باید تغییر کند 
--8192 * PageNumber 
GO
--روشن شود Mirror Server حالا 
--کمی زمان می برد
GO
--بازیابی شده اند Mirror Server هایی که از Page مشاهده 
SELECT * FROM sys.dm_db_mirroring_auto_page_repair
GO
SELECT * FROM NikAmoozTearchers
GO
--بازیابی شده اند Mirror Server هایی که از Page مشاهده 
SELECT * FROM sys.dm_db_mirroring_auto_page_repair
GO