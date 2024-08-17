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
----Data Transfer اعمال تنظیمات
-----------------------------------
USE master
GO
--بررسي جهت وجود بانك اطلاعاتي و حذف آن
IF DB_ID('XXXXX')>0
BEGIN
	ALTER DATABASE XXXX SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE XXXXX
END
GO	
--Backup&Restore بر روی عملیات Data Transafer تاثیر استفاده از 
GO
--Performance Monitor اجرای برنامه 
GO
USE master
GO
SET STATISTICS TIME ON
GO
--SQL Server Logs در Backup & Restore ثبت اطلاعات اضافی درباره 
DBCC TRACEON (3605)
DBCC TRACEON (3213)
GO
--Data Transfer تهیه نسخه پشتیبان به صورت فشرده فاقد
BACKUP DATABASE AdventureWorksDW2016CTP3 
	TO DISK='E:\Dump\AdventureWorksDW2016CTP3_1.bak',
	DISK='C:\Dump\AdventureWorksDW2016CTP3_2.bak'
	WITH STATS=1,FORMAT,COMPRESSION
GO
--SQL Server Logs مشاهده اطلاعات 
EXEC xp_ReadErrorLog
GO
--Data Transfer تهیه نسخه پشتیبان به صورت فشرده دارای
BACKUP DATABASE AdventureWorksDW2016CTP3 
	TO DISK='E:\Dump\AdventureWorksDW2016CTP3_1.bak',DISK='C:\Dump\AdventureWorksDW2016CTP3_2.bak'
	WITH STATS=1,FORMAT,COMPRESSION
	,BUFFERCOUNT = 1500
	,MAXTRANSFERSIZE=419434 
	,BLOCKSIZE = 65536
GO
--SQL Server Logs مشاهده اطلاعات 
EXEC xp_ReadErrorLog
GO
--SQL Server Logs پاک کردن اطلاعات 
EXEC sp_cycle_errorlog 