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
--Backupset Option استفاده از 
-----------------------------------
USE master
GO
DROP DATABASE IF EXISTS NikAmoozDB2017 
CREATE DATABASE NikAmoozDB2017
GO
BACKUP DATABASE Northwind TO DISK ='C:\TEMP1\NW.BAK'
WITH COMPRESSION,NAME=N'فول 1',DESCRIPTION=N'توضیحات فول 1'
GO
BACKUP DATABASE NikAmoozDB2017 TO DISK ='C:\TEMP1\NW.BAK'
WITH 
	COMPRESSION,NAME=N'فول 2',DESCRIPTION=N'توضیحات فول 2'
GO
BACKUP DATABASE NikAmoozDB2017 TO DISK ='C:\TEMP1\NW.BAK'
WITH 
	COMPRESSION,NAME=N'دیفرنشیال 1',DESCRIPTION=N'توضیحات دیفرنشیال 1',
	DIFFERENTIAL
GO
RESTORE LABELONLY FROM  DISK ='C:\TEMP1\NW.BAK'
RESTORE HEADERONLY FROM  DISK ='C:\TEMP1\NW.BAK'
RESTORE FILELISTONLY FROM  DISK ='C:\TEMP1\NW.BAK' WITH FILE =2
GO
/*
--Media Header
RESTORE LABELONLY FROM DISK=..... 

--Backupset Header
RESTORE HEADERONLY FROM DISK=..... WITH FILE=N

--Backupset File
RESTORE FILELISTONLY FROM DISK=.... WITH FILE=N
*/
