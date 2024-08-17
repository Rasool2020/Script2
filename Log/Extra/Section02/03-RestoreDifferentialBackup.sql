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
--مجموعه تغییرات اول و دیف بکاپ
INSERT INTO Students(FullName) VALUES (N'مسعود')
GO
BACKUP DATABASE NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' 
	WITH STATS=1,FORMAT,DIFFERENTIAL
GO
--مجموعه تغییرات دوم و دیف بکاپ
INSERT INTO Students(FullName) VALUES (N'فرید')
GO
BACKUP DATABASE NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' 
	WITH STATS=1,DIFFERENTIAL
GO
--مجموعه تغییرات سوم و دیف بکاپ
INSERT INTO Students(FullName) VALUES (N'علیرضا')
GO
BACKUP DATABASE NikAmoozDB2017 TO DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' 
	WITH STATS=1,DIFFERENTIAL
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Full.bak'  
RESTORE HEADERONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' WITH FILE=1
RESTORE HEADERONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' WITH FILE=2
RESTORE HEADERONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' WITH FILE=3
GO
/*
Differential Backup بازیابی
کدام باید برگردانده شود
به تنهایی قابل برگرداندن استDifferentail بررسی شود که آیا 
*/
RESTORE FILELISTONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak'
GO
RESTORE DATABASE NikAmoozDB2017_2 FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' WITH
FILE=2,
MOVE 'NikAmoozDB2017' TO 'E:\DUMP\NikAmoozDB2017.mdf',
MOVE 'NikAmoozDB2017_log' TO 'E:\DUMP\NikAmoozDB2017_log.ldf'
GO 
RESTORE FILELISTONLY FROM DISK='C:\Temp1\NikAmoozDB2017_Full.bak'
GO
RESTORE DATABASE NikAmoozDB2017_2 FROM DISK='C:\Temp1\NikAmoozDB2017_Full.bak' WITH
MOVE 'NikAmoozDB2017' TO 'E:\DUMP\NikAmoozDB2017.mdf',
MOVE 'NikAmoozDB2017_log' TO 'E:\DUMP\NikAmoozDB2017_log.ldf',
NORECOVERY
GO 
RESTORE DATABASE NikAmoozDB2017_2 FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' WITH
FILE=3,NORECOVERY
GO 
RESTORE DATABASE NikAmoozDB2017_2 WITH RECOVERY
-------------------
/*
هم انجام شود Standby بازیابی در حالت 
STANDBY
*/
RESTORE DATABASE NikAmoozDB2017_2 FROM DISK='C:\Temp1\NikAmoozDB2017_Full.bak' WITH
MOVE 'NikAmoozDB2017' TO 'E:\DUMP\NikAmoozDB2017.mdf',
MOVE 'NikAmoozDB2017_log' TO 'E:\DUMP\NikAmoozDB2017_log.ldf',
STANDBY='C:\TEMP\NikAmoozDB2017_2.UNDO'
GO 
RESTORE DATABASE NikAmoozDB2017_2 FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' WITH
FILE=1,STANDBY='C:\TEMP\NikAmoozDB2017_2.UNDO'

RESTORE DATABASE NikAmoozDB2017_2 FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' WITH
FILE=2,STANDBY='C:\TEMP\NikAmoozDB2017_2.UNDO'


RESTORE DATABASE NikAmoozDB2017_2 FROM DISK='C:\Temp1\NikAmoozDB2017_Diff.bak' WITH
FILE=3,STANDBY='C:\TEMP\NikAmoozDB2017_2.UNDO'

RESTORE  DATABASE NikAmoozDB2017_2 WITH  RECOVERY


------------------------------------------
RESTORE HEADERONLY FROM DISK='C:\TEMP1\DiffRestore.bak' WITH FILE=1
RESTORE HEADERONLY FROM DISK='C:\TEMP1\DiffRestore.bak' WITH FILE=5


RESTORE FILELISTONLY FROM DISK='C:\TEMP1\DiffRestore.bak' WITH FILE=1
GO

RESTORE DATABASE NW2  FROM DISK='C:\TEMP1\DiffRestore.bak' WITH FILE=1,
MOVE 'Northwind' TO 'E:\Dump\Northwind.mdf',
MOVE 'Northwind_log' TO 'E:\Dump\Northwind_log.ldf',
NORECOVERY
GO
RESTORE DATABASE NW2  FROM DISK='C:\TEMP1\DiffRestore.bak' WITH FILE=5,
RECOVERY
