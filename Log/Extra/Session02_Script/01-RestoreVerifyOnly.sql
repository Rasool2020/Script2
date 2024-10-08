﻿--------------------------------------------------------------------
/*
SQL Server 2017 در High Availability دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
--RESTORE VERIFYONLY استفاده از 
--SSMS بررسی در 
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_Full.bak' 
	WITH STATS=1,FORMAT
GO
RESTORE VERIFYONLY FROM DISK = 'C:\Temp1\Northwind_Full.bak' 
	WITH STATS=1
GO
RESTORE VERIFYONLY FROM DISK = 'C:\Temp1\Northwind_Full.bak' 
	WITH STATS=1,CHECKSUM
GO
RESTORE VERIFYONLY FROM DISK = 'C:\Temp1\broken.bak' 
	WITH STATS=1
GO
RESTORE VERIFYONLY FROM DISK = 'C:\Temp1\broken.bak' 
	WITH STATS=1,CHECKSUM
/*
بررسی صحت و سلامت 
با چک سام و بدون چک سام
broken.bak
*/
----------
BACKUP DATABASE msdb TO DISK ='C:\TEMP1\full.bak' WITH STATS=1
BACKUP DATABASE Northwind TO DISK ='C:\TEMP1\full.bak' WITH CHECKSUM,STATS=1

RESTORE HEADERONLY FROM  DISK ='C:\TEMP1\full.bak'

RESTORE VERIFYONLY FROM  DISK ='C:\TEMP1\full.bak' WITH FILE=2,CHECKSUM,STATS=1