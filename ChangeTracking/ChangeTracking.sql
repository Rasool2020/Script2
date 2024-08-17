USE master
GO
--بررسی جهت وجود بانک اطلاعاتی
IF DB_ID('ChangeTracking')>0
BEGIN
	ALTER DATABASE ChangeTracking SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE ChangeTracking
END
GO
--ایجاد بانک اطلاعاتی
CREATE DATABASE ChangeTracking
GO
--------------------------------------------------------------------
--برای بانک اطلاعاتی Change Tracking فعال کردن ویژگی 
USE master
GO
ALTER DATABASE dbTest2 SET CHANGE_TRACKING = ON
	(CHANGE_RETENTION = 20 DAYS, AUTO_CLEANUP = ON)
GO
--مدت زمان نگهداری تغییرات چند روز است ، آیا تغییرات اتوماتیک پاک شود
GO
USE ChangeTracking
GO
--Change Tracking مشاهده وضعیت 
SELECT DB_NAME(database_id),* FROM sys.change_tracking_databases 
GO
--------------------------------------------------------------------
USE ChangeTracking
GO
--پاک کردن جدول در صورت وجود
DROP TABLE IF EXISTS Employee
GO
--ساخت جدول
CREATE TABLE Employee
(
	EmployeeID INT IDENTITY PRIMARY KEY,
	FirstName VARCHAR(100),
	LastName VARCHAR(100),
	CurrentPayScale DECIMAL(18,0)
)
GO
--درج تعدادی رکورد تستی
INSERT INTO Employee(FirstName, LastName, CurrentPayScale) VALUES
	('Masoud', 'Taheri', 18000),
	('Farid', 'Taheri', 17000),
	('Alireza', 'Taheri', 5000)
GO
--مشاهده رکوردهای موجود در جدول
SELECT * FROM Employee
GO
--------------------------------------------------------------------
--به ازای یک جدول Change Tracking فعال سازی ویژگی 
ALTER TABLE Employee ENABLE CHANGE_TRACKING
	WITH (TRACK_COLUMNS_UPDATED = ON)
GO
--هستند Change Tracking مشاهده جداولی که دارای 
SELECT OBJECT_NAME(object_id),* FROM sys.change_tracking_tables
GO
SELECT OBJECT_NAME(parent_object_id),* FROM sys.internal_tables 
	WHERE parent_object_id = OBJECT_ID('Employee')
GO
--------------------------------------------------------------------
GO
--درج یک رکورد
INSERT INTO Employee(FirstName, LastName, CurrentPayScale) VALUES
	('Majid', 'Taheri', 14000)
GO
/*
--دیگر Session مشاهده نسخه در یک 
SELECT CHANGE_TRACKING_CURRENT_VERSION ()
SELECT CHANGE_TRACKING_MIN_VALID_VERSION(OBJECT_ID('Employee'))
SELECT * FROM CHANGETABLE (CHANGES Employee,0) AS CT 
	ORDER BY SYS_CHANGE_VERSION
GO
*/
GO
--حذف یک رکورد
DELETE FROM Employee WHERE EmployeeID = 2
GO
--به روز رسانی یک رکورد
UPDATE Employee SET 
	CurrentPayScale = 15000, FirstName += '*'
WHERE EmployeeID = 3
GO
--------------------------------------------------------------------
--بدست آوردن آخرین تغییرات پس از آخرین خواندن 
-- Get all DML changes (Inserts, Updates and Deletes) after the previous synchronized version 
DECLARE @PreviousVersion bigint
SET @PreviousVersion = 0
SELECT 
	CTTable.EmployeeID, CTTable.SYS_CHANGE_OPERATION, 
	Emp.FirstName, Emp.LastName, Emp.CurrentPayScale,
	CTTable.SYS_CHANGE_VERSION, CTTable.SYS_CHANGE_COLUMNS, 
	CTTable.SYS_CHANGE_CONTEXT 
FROM CHANGETABLE (CHANGES Employee, @PreviousVersion) AS CTTable
LEFT OUTER JOIN Employee AS Emp
	ON emp.EmployeeID = CTTable.EmployeeID
GO
--------------------------------------------------------------------
--Context روش استفاده از 
DECLARE @RequesterAppID varbinary(128) = CAST('MyCachingAppID' AS varbinary(128));
WITH CHANGE_TRACKING_CONTEXT (@RequesterAppID)
UPDATE Employee SET CurrentPayScale = 20000
	WHERE EmployeeID = 1 
GO
--Context مشاهده مقدار 
SELECT 
	CTTable.EmployeeID, CTTable.SYS_CHANGE_VERSION, 
	CAST(CTTable.SYS_CHANGE_CONTEXT AS VARCHAR(128)) AS RequesterAppID
FROM CHANGETABLE(CHANGES Employee, 1) AS CTTable;
GO
Select Min(CTTable.SYS_CHANGE_VERSION), Max(CTTable.SYS_CHANGE_VERSION)
FROM CHANGETABLE(CHANGES Employee, 1) AS CTTable;
--------------------------------------------------------------------
--مشاهده فیلدهای تغییر یافته 
/*
بررسی تابع 
CHANGE_TRACKING_IS_COLUMN_IN_MASK
*/
SELECT COLUMNPROPERTY(OBJECT_ID('Employee'), 'EmployeeID', 'ColumnId')
GO
DECLARE @PreviousVersion bigint
SET @PreviousVersion = 1
SELECT 
	CTTable.EmployeeID, CTTable.SYS_CHANGE_OPERATION, 
	Emp.FirstName, Emp.LastName, Emp.CurrentPayScale,
	CTTable.SYS_CHANGE_VERSION, CTTable.SYS_CHANGE_COLUMNS, 
	CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('Employee'), 'EmployeeID', 'ColumnId'),CTTable.sys_change_columns)  AS EmployeeID_Changed,
	CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('Employee'), 'FirstName', 'ColumnId'),CTTable.sys_change_columns)  AS FirstName_Changed,
	CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('Employee'), 'LastName', 'ColumnId'),CTTable.sys_change_columns)  AS LastName_Changed,
	CHANGE_TRACKING_IS_COLUMN_IN_MASK(COLUMNPROPERTY(OBJECT_ID('Employee'), 'CurrentPayScale', 'ColumnId'),CTTable.sys_change_columns)  AS CurrentPayScale_Changed
FROM CHANGETABLE (CHANGES Employee, @PreviousVersion) AS CTTable
LEFT OUTER JOIN Employee AS Emp
	ON emp.EmployeeID = CTTable.EmployeeID
GO
--------------------------------------------------------------------
--Change Tracking غیر فعال کردن 
ALTER DATABASE ChangeTracking SET CHANGE_TRACKING = OFF
GO
ALTER TABLE Employee DISABLE CHANGE_TRACKING
GO
--------------------------------------------------------------------



