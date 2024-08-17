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
--Log Backups تهیه 
-----------------------------------
USE master
GO
--بررسي جهت وجود بانك اطلاعاتي و حذف آن
IF DB_ID('NikAmoozDB2017')>0
BEGIN
	ALTER DATABASE NikAmoozDB2017 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2017
END
GO	
CREATE DATABASE NikAmoozDB2017
GO
BACKUP LOG NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Log.bak' 
	WITH STATS=1,FORMAT
GO
BACKUP DATABASE NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Full.bak' 
	WITH STATS=1,FORMAT
GO
-----------------------------------
--رنجیر لاگ
/*
دنباله پیوسته از لاگ بکاپ
FirstLSN , LastLSN هر لاگ بکاپ شامل 
مراجعه شود به تصویر
LogChan1,LogChan2
*/
USE master
GO
IF DB_ID('NikAmoozDB2017')>0
BEGIN
	ALTER DATABASE NikAmoozDB2017 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2017
END
GO	
CREATE DATABASE NikAmoozDB2017
GO
USE NikAmoozDB2017
GO
DROP TABLE IF EXISTS Students
GO
CREATE TABLE Students
(
	ID INT IDENTITY PRIMARY KEY,
	FullName NVARCHAR(100)
)
GO
--تهیه فول بکاپ
BACKUP DATABASE NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Full.bak' 
	WITH STATS=1,FORMAT
GO
--مجموعه تغییرات اول و لاگ بکاپ
INSERT INTO Students(FullName) VALUES (N'مسعود')
GO
BACKUP LOG NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Log.bak' 
	WITH STATS=1,FORMAT
GO
--مجموعه تغییرات دوم و لاگ بکاپ
INSERT INTO Students(FullName) VALUES (N'فرید')
GO
BACKUP LOG NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Log.bak' 
	WITH STATS=1
GO
--مجموعه تغییرات سوم و لاگ بکاپ
INSERT INTO Students(FullName) VALUES (N'علیرضا')
GO
BACKUP LOG NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Log.bak' 
	WITH STATS=1
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Full.bak'  
RESTORE HEADERONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Log.bak' WITH FILE=1
RESTORE HEADERONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Log.bak' WITH FILE=2
RESTORE HEADERONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Log.bak' WITH FILE=3
GO
/*
--Media Header
RESTORE LABELONLY FROM DISK=..... 

--Backupset Header
RESTORE HEADERONLY FROM DISK=..... WITH FILE=N

--Backupset File
RESTORE FILELISTONLY FROM DISK=.... WITH FILE=N
*/