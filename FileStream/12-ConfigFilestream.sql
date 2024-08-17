--------------------------------------------------------------------
/*
Performance & Tuning in SQL Serve دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
--Filestream بررسی نحوه فعال کردن تنظیمات 
GO

----------------------------------
USE master
GO
--SQL Server در سطح سرویسFilestream اعمال تنظیمات مربوط به 
GO
----------------------------------
USE master
GO
--Instance در سطحFilestream اعمال تنظیمات مربوط به 
--دستور
--SSMS
GO
SP_CONFIGURE 'show advanced options',1
RECONFIGURE
GO
/*
-- 
0:Disable 
1:Transact SQL Access  
2:Full Acess Enabled
*/
SP_CONFIGURE 'filestream access level',1  
RECONFIGURE
GO
