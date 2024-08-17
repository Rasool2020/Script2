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
--Media Header
RESTORE LABELONLY FROM DISK=.....

--Backupset Header
RESTORE HEADERONLY FROM DISK=.....

--Backupset File
RESTORE FILELISTONLY FROM DISK=....
*/
--برای این موضوع فراهم شود SSMS استفاده از 
RESTORE LABELONLY FROM DISK ='C:\TEMP1\Northwind_FULL.BAK'
RESTORE HEADERONLY FROM DISK ='C:\TEMP1\Northwind_FULL.BAK'
RESTORE FILELISTONLY FROM DISK ='C:\TEMP1\Northwind_FULL.BAK'
RESTORE FILELISTONLY FROM DISK ='C:\TEMP1\Northwind_FULL.BAK'
	WITH FILE=2

GO
BACKUP DATABASE msdb TO DISK ='C:\TEMP1\Northwind_FULL.BAK'
GO
