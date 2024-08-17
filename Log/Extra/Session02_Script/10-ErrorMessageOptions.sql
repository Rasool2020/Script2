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
--Error Message Option استفاده از 
-----------------------------------
--Checksumاستفاده از 
/*
قبل از نوشتن پیج ها در دیسک به ازای هر صفحه Checksum محاسبه 
چک سام مربوط به کل بکاپ هم حساب می شود
در هنگام بازیابی از این چک سام می توان استفاده کرد
Page Verify بررسی آپشن 
از آپشن بالا کمک گرفته می شود
*/
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithChecksum.bak'
	WITH CHECKSUM
GO
-----------------------------------
--Stop_On_Errorاستفاده از 
/*
اگر چک سام نامعتبری ببیند  متوقف می شود
این رفتار حالت پیش فرض می باشد
*/
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithStop_On_Error.bak'
	WITH CHECKSUM, STOP_ON_ERROR
GO
BACKUP DATABASE broken TO DISK ='C:\TEMP1\broken.bak'
WITH CHECKSUM,Continue_After_Error
-----------------------------------
--Continue_After_Errorاستفاده از 
/*
بی خیال خطابشو
*/
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_WithContinue_After_Error.bak'
	WITH CONTINUE_AFTER_ERROR
GO
/*
--Media Header
RESTORE LABELONLY FROM DISK=..... 

--Backupset Header
RESTORE HEADERONLY FROM DISK=..... WITH FILE=N

--Backupset File
RESTORE FILELISTONLY FROM DISK=.... WITH FILE=N
*/

/*
بازیابی این بانک اطلاعاتی و بررسی بکاپ با چک سام
broken
*/

