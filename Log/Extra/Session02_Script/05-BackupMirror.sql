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
BACKUP DATABASE XXXXX TO DISK =.....
	MIRROR TO DISK= ....
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\NW1.bak'
	MIRROR TO DISK ='C:\Temp1\NW2.bak'
WITH DIFFERENTIAL,FORMAT
GO
/*
--Media Header
RESTORE LABELONLY FROM DISK=..... 

--Backupset Header
RESTORE HEADERONLY FROM DISK=..... WITH FILE=N

--Backupset File
RESTORE FILELISTONLY FROM DISK=.... WITH FILE=N
*/
--برای این موضوع فراهم شود SSMS استفاده از 
GO
