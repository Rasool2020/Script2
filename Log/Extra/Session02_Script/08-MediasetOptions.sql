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
--Mediaset Option استفاده از 
-----------------------------------
--Init استفاده از 
/*
پاک کردن بکاپ ست ها
نگهداری مدیا هدر
*/
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithInit.bak'
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithInit.bak'
GO
--Media Header (MediaDate:2017-10-20 11:51:30.000)
RESTORE LABELONLY FROM DISK='C:\Temp1\Northwind_WithInit.bak'
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Temp1\Northwind_WithInit.bak'
GO
--INIT تهیه بکاپ این بار با آپشن 
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithInit.bak'
	WITH INIT
GO
--Media Header (MediaDate:2017-10-20 11:51:30.000)
RESTORE LABELONLY FROM DISK='C:\Temp1\Northwind_WithInit.bak'
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Temp1\Northwind_WithInit.bak'
GO
-----------------------------------
--FORMAT استفاده از 
/*
پاک کردن بکاپ ست ها
پاک کردن مدیا هدر
*/
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithFormat.bak'
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithFormat.bak'
GO
--Media Header (MediaDate:2017-10-20 11:54:48.000)
RESTORE LABELONLY FROM DISK='C:\Temp1\Northwind_WithFormat.bak'
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Temp1\Northwind_WithFormat.bak'
GO
--FORMAT تهیه بکاپ این بار با آپشن 
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithFormat.bak'
	WITH FORMAT
GO
--Media Header (MediaDate:2017-10-20 11:55:20.000)
RESTORE LABELONLY FROM DISK='C:\Temp1\Northwind_WithFormat.bak'
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Temp1\Northwind_WithFormat.bak'
GO
-----------------------------------
--SKIP استفاده از 
/*
در صورت وجود تاریخ انقضاء از آن صرف نظر می کند
*/
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithRetainDays.bak'
WITH RetainDays=1
GO
--رفتار هنگام بازنویسی
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithRetainDays.bak'
WITH INIT
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithRetainDays.bak'
WITH INIT,SKIP
GO
RESTORE HEADERONLY FROM DISK='C:\Temp1\Northwind_WithRetainDays.bak'
-----------------------------------
--MediaName,MediaDescription استفاده از 
/*
تخصیص نام و توضیحات برای مدیا
*/
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithMediaNameDesc.bak' WITH 
	NAME=N'نام بکاپ ست',DESCRIPTION=N'توضیحات بکاپ ست',
	MEDIANAME=N'نام مدیا',MEDIADESCRIPTION=N'توضیحات مدیا'
GO
--Media Header
RESTORE LABELONLY FROM DISK='C:\Temp1\Northwind_WithMediaNameDesc.bak' 
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Temp1\Northwind_WithMediaNameDesc.bak'
GO
/*
--Media Header
RESTORE LABELONLY FROM DISK=..... 

--Backupset Header
RESTORE HEADERONLY FROM DISK=..... WITH FILE=N

--Backupset File
RESTORE FILELISTONLY FROM DISK=.... WITH FILE=N
*/
