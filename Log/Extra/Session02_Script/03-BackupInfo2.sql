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
BACKUP DATABASE Northwind TO DISK ='C:\TEMP1\NW.BAK'
BACKUP DATABASE Northwind TO DISK ='C:\TEMP1\NW.BAK' WITH DIFFERENTIAL
BACKUP LOG Northwind TO DISK ='C:\TEMP1\NW.BAK'
--Media Header
RESTORE LABELONLY FROM DISK='C:\TEMP1\NW.BAK'
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\TEMP1\NW.BAK'
/*
--Media Header
RESTORE LABELONLY FROM DISK=..... 

--Backupset Header
RESTORE HEADERONLY FROM DISK=..... WITH FILE=N

--Backupset File
RESTORE FILELISTONLY FROM DISK=.... WITH FILE=N
*/
--برای این موضوع فراهم شود SSMS استفاده از 