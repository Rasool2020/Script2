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
--Copy_Onlyاستفاده از 
/*
عدم تاثیر روی روال بکاپ 
به ازای فول بکاپ و لاگ بکاپ مفهوم دارد
زنجیره لاگ را از بین نمی برد
Copy_Only مراجعه به تصویر
SSMS بررسی این آپشن در 
*/
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithCopyOnly.bak'
	WITH COPY_ONLY
GO
-----------------------------------
--Compress استفاده از 
/*
فشرده کردن نسخه پشتیبان
افزایش سرعت عملیات تهیه نسخه پشتیبان
بررسی ظرفیت فایل در سیستم عامل
SSMS بررسی این آپشن در 
*/
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithoutCompress.bak'
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithCompress.bak'
	WITH COMPRESSION
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithCompress.bak'
	WITH COMPRESSION
GO
/*
SP_CONFIGURE 'backup compression default',1
SP_CONFIGURE 'backup compression default',0
RECONFIGURE
*/
-----------------------------------
--Description,Name استفاده از 
/*
تخصیص نام و توضیحات به بکاپ ست
امکان مشاهده و بازیابی آن
SSMS بررسی این آپشن در 
*/
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithNameDesc.bak'
WITH NAME=N'نام بکاپ ست',DESCRIPTION=N'توضیحات بکاپ ست'
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Temp1\Northwind_WithNameDesc.bak'
GO
-----------------------------------
--ExpireDate ,RetainDays استفاده از 
/*
تاریخ انقضاء و مدت زمان حفظ و نگهداری بکاپ ست
Media retention تنظیمات 
SSMS بررسی این آپشن در 
*/
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithRetainDays.bak'
WITH RetainDays=1
GO
--رفتار هنگام بازنویسی
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithRetainDays.bak'
WITH INIT
GO
RESTORE HEADERONLY FROM  DISK='C:\Temp1\Northwind_WithRetainDays.bak'
GO
SP_CONFIGURE 'media retention'

/*



--Media Header
RESTORE LABELONLY FROM DISK=..... 

--Backupset Header
RESTORE HEADERONLY FROM DISK=..... WITH FILE=N

--Backupset File
RESTORE FILELISTONLY FROM DISK=.... WITH FILE=N
*/
