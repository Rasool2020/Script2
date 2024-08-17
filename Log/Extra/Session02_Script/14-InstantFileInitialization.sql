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
----Instant File Initialization اعمال تنظیمات
-----------------------------------
USE master
GO
--بررسي جهت وجود بانك اطلاعاتي و حذف آن
IF DB_ID('AdventureWorksDW2016CTP3')>0
BEGIN
	ALTER DATABASE AdventureWorksDW2016CTP3 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE AdventureWorksDW2016CTP3
END
GO	
RESTORE FILELISTONLY FROM DISK ='H:\Software\SQL Server 2016\BackupDatabase\AdventureWorksDW2016CTP3.bak'
GO
RESTORE DATABASE AdventureWorksDW2016CTP3 FROM DISK ='H:\Software\SQL Server 2016\BackupDatabase\AdventureWorksDW2016CTP3.bak' WITH 
MOVE 'AdventureWorksDW2014_Data' TO 'E:\DUMP\AdventureWorksDW2014_Data.mdf',
MOVE 'AdventureWorksDW2014_Log' TO 'E:\DUMP\AdventureWorksDW2014_Log.ldf',STATS=1
GO

