--------------------------------------------------------------------
/*
SQL Server 2022 بررسی ویژگی های جدید 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
/*
در این قسمت تنظیمات اولیه مرتبط با هر دیتابیس انجام خواهد شد  
*/
USE [master]
GO
ALTER DATABASE [StackOverflow2013] SET COMPATIBILITY_LEVEL = 160
GO
/*
1-بشیمRollback در مرحله اول باید این قسمت رو اجرا کنیم بدون این که وارد فاز 
2-در مرحله دوم 
*/
USE StackOverflow2013
GO
/* Clustered index */
SELECT * FROM sys.dm_db_index_physical_stats(5, 149575571, 1, 0, 'DETAILED')

/* Nonclustered index */
SELECT * FROM sys.dm_db_index_physical_stats(5, 149575571, 2, 0, 'DETAILED')
GO
BEGIN TRANSACTION
	UPDATE dbo.Users
	  SET Reputation = 1000000,
		  LastAccessDate = GETDATE();
GO
ROLLBACK
GO
sp_msforeachdb 'ALTER DATABASE ? SET ACCELERATED_DATABASE_RECOVERY = ON;'

ALTER DATABASE StackOverflow2013 SET ACCELERATED_DATABASE_RECOVERY = ON;
SELECT * FROM sys.databases;

/* Run a transaction that does a lot of work: */
BEGIN TRANSACTION
	UPDATE dbo.Users
	  SET Reputation = 1000000,
		  LastAccessDate = GETDATE();
GO

/*
این خروجی ها را باید زمانی بگیریم که این قابلیت فعال هست 
*/

/* How much space is being used? */
SELECT TOP 100 * FROM sys.dm_tran_persistent_version_store_stats WHERE database_id=5
--SELECT TOP 100 * FROM sys.dm_tran_top_version_generators
--SELECT TOP 100 * FROM sys.dm_tran_version_store
--SELECT TOP 100 * FROM sys.dm_tran_version_store_space_usage


EXEC sp_persistent_version_store;

ROLLBACK;
GO

EXEC sp_persistent_version_cleanup;