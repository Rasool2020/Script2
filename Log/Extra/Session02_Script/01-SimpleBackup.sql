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
/*
--Full Backup
BACKUP DATABASE XXX TO DISK=....

...
...
Change Customer


--Differential Backup
BACKUP DATABASE XXX TO DISK=.... WITH DIFFERENTIAL,COMPRESS

--Log Backup
BACKUP LOG XXX TO DISK=.... 
GO
*/
--برای این موضوع فراهم شود SSMS استفاده از 

BACKUP DATABASE Northwind TO DISK='C:\TEMP1\Northwind_FULL.BAK'
GO
UPDATE Customers SET CompanyName+='x'
GO
BACKUP DATABASE Northwind TO DISK='C:\TEMP1\Northwind_Diff.BAK'
	WITH DIFFERENTIAL,COMPRESSION
GO
BACKUP LOG Northwind TO DISK='C:\TEMP1\Northwind_Log.trn'
GO