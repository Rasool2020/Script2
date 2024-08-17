USE master
GO
IF DB_ID('CDC_DEMO')>0
BEGIN
	ALTER DATABASE CDC_DEMO SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE CDC_DEMO 
END
GO
CREATE DATABASE CDC_DEMO
GO 
USE CDC_DEMO
GO
DROP TABLE IF EXISTS Students
GO
CREATE TABLE Students
(
	CODE INT PRIMARY KEY,
	NAME NVARCHAR(50),
	FAMILY NVARCHAR(50) 
)
GO
EXEC sys.sp_cdc_enable_db
GO
--بر روی بانک اطلاعاتی CDC بررسی فعال بودن 
SELECT name,is_cdc_enabled FROM SYS.databases
GO
/*
--CDC (Syetem Tables) بررسی جداول سیستمی 
cdc.CapturedColumn = لیستی از فیلدهای ضبط شده
cdc.ChangeTable =به ازای آنها فعال است CDC جداولی که 
cdc.ddl_History = CDC های تغییر یافته از زمان فعال شدن DDLتاریخچه ای از همه 
cdc.Index_Columns = CDC ایندکس های به کار رفته در جداول
cdc.lsn_time_mapping = شده است Commit شده با زمانی که تراکنش  Commit های LSN مپینگ بین 
*/
/*
1 = Delete
2 = Insert
3 = Update (old value)  قبل از به روزرسانی
4 = Update (new value)  مقدار قبل از به روزرسانی
5 = Merge
*/
------------------------------------------------
--براي جدول فوق CDC فعال سازي قابليت
--ايجاد خودكار جاب و فانكشن به 
EXEC sys.sp_cdc_enable_table
    @Source_Schema = N'dbo',
    @Source_Name   = N'Students',
    @Role_Name     = null,
    @Supports_Net_Changes = 1
GO
--گيريCaptureاستخراج پروسه هاي مربوط به 
--به ستون هايي كه قرار است تغييرات آن ذخيره شود دقت كنيد
EXEC SYS.sp_cdc_help_change_data_capture
GO
------------------------------ساعت 9
--حالتي از دستور درج اطلاعات در 2008
INSERT INTO Students VALUES 
	(100,'Masoud','Taheri'),
	(101,'Farid','Taheri'),
	(102,'Saman','Farzam')
GO
UPDATE Students SET FAMILY+='*' WHERE CODE=102
--استخراج سابقه تغييرات
-- Please note that __$operation column indicates 1 for delete, 2 for insert,
-- 3(old Values) & 4(New Values) for update
SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_Students
    (sys.fn_cdc_get_min_lsn('dbo_Students'), sys.fn_cdc_get_max_lsn(), N'all update old' )
GO
------------------------------ساعت 10
DELETE FROM Students WHERE CODE=100
GO
--استخراج سابقه تغييرات
-- Please note that __$operation column indicates 1 for delete, 2 for insert,
-- 3(old Values) & 4(New Values) for update
SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_Students
    (sys.fn_cdc_get_min_lsn('dbo_Students'), sys.fn_cdc_get_max_lsn(), N'all update old' )
GO
------------------------------ساعت 11
UPDATE Students SET NAME='Ali',FAMILY='Farzam Tehrani' WHERE CODE=102
GO
--استخراج سابقه تغييرات
-- Please note that __$operation column indicates 1 for delete, 2 for insert,
-- 3(old Values) & 4(New Values) for update
SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_Students
    (sys.fn_cdc_get_min_lsn('dbo_Students'), sys.fn_cdc_get_max_lsn(), N'all update old' )
GO
------------------
--به پارامتر آخر دقت شود
--كليه مقادير قديم مربوط به دستور به روز رساني نمايش داده نمي شود
SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_Students 
    (sys.fn_cdc_get_min_lsn('dbo_Students'), sys.fn_cdc_get_max_lsn(), N'all')
Go
---------------------------------------------------------------------------------
--بدست آوردن سوابق تغييرات داده ها بر حسب زمان
SELECT GETDATE();
DECLARE @begin_time DATETIME
DECLARE @end_time   DATETIME
DECLARE @begin_lsn	BINARY(10)
DECLARE @end_lsn	BINARY(10)

SET @begin_time = '2010-10-21 08:57:00'
SET @end_time = '2010-10-21 10:30:00' 

SELECT @begin_lsn = sys.fn_cdc_map_time_to_lsn('smallest greater than', @begin_time); 
SELECT @end_lsn = sys.fn_cdc_map_time_to_lsn('largest less than or equal', @end_time); 

SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_Students(@begin_lsn, @end_lsn, N'all'); 
SELECT * FROM cdc.fn_cdc_get_all_changes_dbo_Students(@begin_lsn, @end_lsn, N'all update old'); 
-----------------------------------------------------------------------
--براي جدول  CDC غير فعال كردن قابليت
EXECUTE sys.sp_cdc_disable_table 
    @source_schema = N'dbo', 
    @source_name = N'Students',
    @capture_instance = N'dbo_Students';
GO
--------------------------------
--CDCغير فعال كردن قابليت
--هاJobحذف كليه  
EXEC sys.sp_cdc_disable_db
GO
EXEC sys.sp_cdc_enable_db

--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
--SSIS در CDC کار با 
--CDC Spliter
--مشاهده تعداد رکوردهای هر عملیات
USE CDC_DEMO
GO
DROP TABLE IF EXISTS Employees
GO
CREATE TABLE Employees
(
	EmployeeID INT PRIMARY KEY,
	FullName NVARCHAR(100),
	EmployeeGroup VARCHAR(10)
)
GO
--ساخت جدول اکشن های انجام شده
DROP  TABLE IF EXISTS Employees_Log
GO
CREATE TABLE Employees_Log
(	
	LogID INT IDENTITY PRIMARY KEY,
	EmployeeID INT ,
	FullName NVARCHAR(100),
	EmployeeGroup VARCHAR(10),
	ActionName VARCHAR(100)
)
GO
INSERT INTO Employees(EmployeeID,FullName,EmployeeGroup) VALUES 
	(1,N'Masoud Taheri','G1'),
	(2,N'Farid Taheri','G1'),
	(3,N'Majid Taheri','G2'),
	(4,N'Ali Taheri','G2'),
	(5,N'Alireza Taheri','G3')	
GO
SELECT * FROM Employees
GO
SELECT * FROM Employees_Log
GO
--براي جدول فوق CDC فعال سازي قابليت
--ايجاد خودكار جاب و فانكشن به 
EXEC sys.sp_cdc_enable_table
    @Source_Schema = N'dbo',
    @Source_Name   = N'Employees',
    @Role_Name     = null,
    @Supports_Net_Changes = 1
GO
--برای جداول CDC مشاهده وضعیت فعال بودن 
SELECT name, is_tracked_by_cdc FROM sys.tables
GO
/*
اولیه Initial پیاده سازی 
ندارد CDC این حالت هیچ ارتباطی با 
و فقط یک لود اولیه ساده می باشد
*/
----------------------------------
----------------------------------
/*
های خوانده شدهLSN ساخت جدول جهت نگهداری 
*/
USE CDC_DEMO
GO
DROP TABLE IF EXISTS dbo.cdc_states 
GO
CREATE TABLE dbo.cdc_states 
(
	 name nvarchar(256) NOT NULL, 
	 state nvarchar(256) NOT NULL
 ) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX cdc_states_name ON dbo.cdc_states( name ASC ) 
 WITH (PAD_INDEX  = OFF) ON [PRIMARY]
GO
SELECT * FROM cdc_states 
GO
SELECT * FROM Employees
GO
SELECT * FROM Employees_Log
GO
----------------------------------
----------------------------------
USE CDC_DEMO
GO
INSERT INTO Employees(EmployeeID,FullName,EmployeeGroup) VALUES 
	(10,N'Mohamad Mazidi','G1')
GO
UPDATE Employees SET FullName+='*' WHERE EmployeeID=10
GO
UPDATE Employees SET FullName+='-' WHERE EmployeeID=10
GO
SELECT * FROM Employees
GO


/*
CDC Source
--All 
--شناسایی کلیه تغییرات **فقط تغییرات
یک ردیف برای هر تغییر برگشت داده می شود،
 اگر سه تا آپدیت داشته باشیم سه تا رکورد بر می گرداند

--All With old Values
است Befor Update عین قبل است و شامل حالت 

--Net (Normal ETL)
--خلاصه تغییرات**آخرین تغییرات
همه تغییراتی که برای یک رکورد خاص انجام شده را اعمال و یک ردیف بر می گرداند
اگر یک رکورد درج شده و دو بار آپدیت شود فقط یک رکورد برگشت داده می شود



Net wit Update mask
مثل حالت قبل است اما به از هر فیلد یک مقدار بولین دارد که نشان می دهد تغییر یافته و یاخیر

Net With Merge
مناسب برای تشخیص نوع عملیات 
با مقادیر عملیاتی یکسان گروه بندی می شوندUpdate , Insert
کرده باشید Run  را Merge زمانی استفاده می شود که شما دستور کرده
*/
--------------------------------------------------------------------
--------------------------------------------------------------------
INSERT INTO Employees(EmployeeID,FullName,EmployeeGroup) VALUES 
	(10,N'Mohamad Mazidi','G1')
GO
UPDATE Employees SET FullName+='*' WHERE EmployeeID=10
GO
UPDATE Employees SET FullName+='-' WHERE EmployeeID=10
GO

GO
/*
روش استفاده از CDC در SSIS برای هر جدول


Initial Load: بارگذاری اولیه
خواندن کوچکترین LSN
انتقال داده ها به جدول مقصد
خواندن آخرین LSN


Incremental Load: بارگذاری تغییرات
خواندن LSN از جدول جانبی (cdc_state)
خواندن تغییرات از LSN فوق تا آخرین LSN و انتقال آنها به مقصد
خواندن آخرین LSN و ثبت آنها در جدول جانبی
*/
--https://blogs.msdn.microsoft.com/dataaccesstechnologies/2018/05/14/invalid-column-__command_id-issue-during-cdc-implementation-in-ssis-package-2/