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
--Differential Backups تهیه 
-----------------------------------
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_Full.bak' 
	WITH STATS=1,FORMAT
GO
--دارای حجم کمتر
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_Diff.bak' 
	WITH STATS=1,FORMAT,DIFFERENTIAL
GO
-----------------------------------
--DCM Page بررسی تخصصی 
GO
USE master
GO
--بررسي جهت وجود بانك اطلاعاتي و حذف آن
IF DB_ID('DCM_Page_Demo')>0
BEGIN
	ALTER DATABASE DCM_Page_Demo SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE DCM_Page_Demo
END
GO	
--ايجاد بانك اطلاعاتي
CREATE DATABASE DCM_Page_Demo
GO
Use DCM_Page_Demo
GO
--مشاهده فايل هاي مربوط به بانك اطلاعاتي
SP_HELPFILE
SELECT * FROM sys.database_files
GO
--از بانك اطلاعاتي Full Backup تهيه
BACKUP DATABASE DCM_Page_Demo 
	TO DISK='C:\TEMP1\DCM_Page_Demo_Full1.bak' WITH FORMAT
GO
--Page بررسي وضعيت 
--DCM Page No =6
DBCC TRACEON(3604)
DBCC PAGE('DCM_Page_Demo',1,6,3)WITH NO_INFOMSGS-- به خروجي انتهاي دستور توجه كنيد
GO
--Bulk Operation انجام عمليات
SELECT * INTO DCM_Page_Demo..SalesOrderDetail 
	FROM Northwind..[Order Details]
GO
--مشاهده تعداد ركوردهاي جدول
SP_SPACEUSED SalesOrderDetail
GO
--Page بررسي وضعيت 
DBCC PAGE('DCM_Page_Demo',1,6,3)WITH NO_INFOMSGS-- به خروجي انتهاي دستور توجه كنيد
GO
--از بانك اطلاعاتي Differential Backup تهيه
BACKUP DATABASE DCM_Page_Demo 
	TO DISK='C:\TEMP1\DCM_Page_Demo_Diff.bak' WITH DIFFERENTIAL
GO
--Page بررسي وضعيت 
DBCC PAGE('DCM_Page_Demo',1,6,3)WITH NO_INFOMSGS-- به خروجي انتهاي دستور توجه كنيد
GO
--از بانك اطلاعاتي Full Backup تهيه
BACKUP DATABASE DCM_Page_Demo 
	TO DISK='C:\TEMP1\DCM_Page_Demo_Full2.bak' WITH FORMAT
GO	
--Page بررسي وضعيت 
DBCC PAGE('DCM_Page_Demo',1,6,3)WITH NO_INFOMSGS-- به خروجي انتهاي دستور توجه كنيد
GO
USE master
GO
--بررسي جهت وجود بانك اطلاعاتي و حذف آن
IF DB_ID('DCM_Page_Demo')>0
	DROP DATABASE DCM_Page_Demo
GO	
