USE master
GO
--بررسی جهت وجود بانک اطلاعاتی
IF DB_ID('TemporalTableDemo')>0
BEGIN
	ALTER DATABASE TemporalTableDemo SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE TemporalTableDemo
END
GO
--ایجاد بانک اطلاعاتی
CREATE DATABASE TemporalTableDemo
GO
--------------------------------------------------------------------
USE TemporalTableDemo
GO
IF OBJECT_ID('Employees')>0
BEGIN
	ALTER TABLE Employees SET ( SYSTEM_VERSIONING = OFF )
	DROP TABLE IF EXISTS EmployeesHistory
	DROP TABLE IF EXISTS Employees 
END
GO
--Temporal ایجاد جدول جدید با قابلیت 
CREATE TABLE Employees
(
	EmployeeID INT NOT NULL IDENTITY(1,1) PRIMARY KEY CLUSTERED, 
    EmployeeName NVARCHAR(50) NOT NULL, 
    ManagerName NVARCHAR(50) NULL, 
	StartDate DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	EndDate DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate)
)
WITH ( SYSTEM_VERSIONING = ON ( HISTORY_TABLE = dbo.EmployeesHistory ) )
GO
--Check Object Explorer
GO
/*
				DateTime					DateTime2[(n)]
Min Value	1753-01-01 00:00:00	 ***	0001-01-01 00:00:00
Storage Size	8 Bytes			 ***	6 to 8 bytes
*/
-- می باشد UTC مقادیر تاریخ بر اساس 
/*

--Convert UTC to Local Date
declare @InputUtcDateTime datetime2 = '2016-11-23 14:22:46.090'
declare @LocalDateTime datetime2 = dateadd(minute, datepart(TZoffset, sysdatetimeoffset()), @InputUtcDateTime)
SELECT  @LocalDateTime
GO
--Convert Local Date to UTC
SELECT DATEADD(second, DATEDIFF(second, GETDATE(), GETUTCDATE()), '2016-11-23 17:52:46.090');
GO
*/
--------------------------------------------------------------------
--درج دیتا در جدول اصلی
INSERT Employees (EmployeeName,ManagerName) VALUES 
	(N'علیرضا طاهری',N'مسعود طاهری'),
	(N'علی طاهری',N'فرید طاهری'),
	(N'محمد مزیدی',N'سعید رضایی تبار')
GO
SELECT * FROM Employees
SELECT * FROM EmployeesHistory
GO
UPDATE Employees SET ManagerName+='*' WHERE EmployeeID=1
GO
UPDATE Employees SET ManagerName+='*' WHERE EmployeeID=2
GO
SELECT * FROM Employees
SELECT * FROM EmployeesHistory --بررسی فیلد تاریخ شروع و تاریخ پایان
GO
--Show Execution Plan
UPDATE Employees SET ManagerName+='-' WHERE EmployeeID=1
GO
UPDATE Employees SET ManagerName+='-' WHERE EmployeeID=2
GO
SELECT * FROM Employees
SELECT * FROM EmployeesHistory
GO
DELETE FROM Employees WHERE EmployeeID=1
GO
SELECT * FROM Employees
SELECT * FROM EmployeesHistory
GO
--------------------------------------------------------------------
--واکشی دیتا به روشی دیگر
--واکشی سوابق از اصل جدول
SELECT * FROM Employees
	FOR SYSTEM_TIME ALL
WHERE EmployeeID=2
ORDER BY StartDate
GO
SELECT * FROM Employees
	FOR SYSTEM_TIME BETWEEN '2016-11-23 14:36:29' AND '2016-11-23 14:36:30'
WHERE EmployeeID=2
ORDER BY StartDate
GO
--------------------------------------------------------------------
--اضافه شدن تعدادی فیلد به جدول اصلی و سابقه
GO
ALTER TABLE Employees SET (SYSTEM_VERSIONING = OFF);
GO
--اضافه شدن فیلد تصویر
ALTER TABLE Employees ADD Pic VARBINARY(MAX)
ALTER TABLE EmployeesHistory ADD Pic VARBINARY(MAX)
GO
--Temporal Table فعال سازی مجدد قابلیت 
ALTER TABLE Employees   
   SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.EmployeesHistory, DATA_CONSISTENCY_CHECK = ON))   
GO
DECLARE @P VARBINARY(MAX)
SELECT @P=CAST(123 AS VARBINARY(MAX))
UPDATE Employees SET PIC=@P WHERE EmployeeID=2
GO
DECLARE @P VARBINARY(MAX)
SELECT @P=CAST(1234 AS VARBINARY(MAX))
UPDATE Employees SET PIC=@P WHERE EmployeeID=2
GO
SELECT * FROM Employees
	FOR SYSTEM_TIME ALL
WHERE EmployeeID=2
ORDER BY StartDate
GO
--------------------------------------------------------------------
--ایجاد جدول سابقه به طور جداگانه
CREATE TABLE DepartmentHistory   
(    
     DeptID int NOT NULL  
   , DeptName varchar(50) NOT NULL  
   , ManagerID INT  NULL  
   , ParentDeptID int NULL  
   , SysStartTime datetime2 NOT NULL  
   , SysEndTime datetime2 NOT NULL   
);   
GO   
--اعمال ایندکس های خاص بر روی جدول سابقه
CREATE CLUSTERED COLUMNSTORE INDEX IX_DepartmentHistory   
   ON DepartmentHistory;   
CREATE NONCLUSTERED INDEX IX_DepartmentHistory_ID_PERIOD_COLUMNS   
   ON DepartmentHistory (SysEndTime, SysStartTime, DeptID);   
GO   
--ایجاد جدول اصلی
CREATE TABLE Department   
(    
    DeptID int NOT NULL PRIMARY KEY CLUSTERED  
   , DeptName varchar(50) NOT NULL  
   , ManagerID INT  NULL  
   , ParentDeptID int NULL  
   , SysStartTime datetime2 GENERATED ALWAYS AS ROW START NOT NULL  
   , SysEndTime datetime2 GENERATED ALWAYS AS ROW END NOT NULL     
   , PERIOD FOR SYSTEM_TIME (SysStartTime,SysEndTime)      
)    
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.DepartmentHistory))   
--------------------------------------------------------------------
--فرض کنید جدول از قبل وجود دارد
IF OBJECT_ID('Employees ')>0
BEGIN
	ALTER TABLE Employees SET ( SYSTEM_VERSIONING = OFF )
	DROP TABLE EmployeesHistory
	DROP TABLE Employees 
END
GO
CREATE TABLE Employees
(
	EmployeeID INT NOT NULL IDENTITY(1,1) PRIMARY KEY CLUSTERED, 
    EmployeeName NCHAR(1000) NOT NULL, 
    ManagerName NVARCHAR(1000) NULL
)
GO
--Temporal ایجاد حالت 
ALTER TABLE Employees ADD
	StartDate DATETIME2(0) GENERATED ALWAYS AS ROW START NOT NULL,
	EndDate DATETIME2(0) GENERATED ALWAYS AS ROW END NOT NULL,
	PERIOD FOR SYSTEM_TIME (StartDate, EndDate)
GO
ALTER TABLE Employees SET
	( SYSTEM_VERSIONING = ON ( HISTORY_TABLE = dbo.EmployeesHistory ) )
GO
INSERT Employees (EmployeeName,ManagerName) VALUES 
	(N'علیرضا طاهری',N'مسعود طاهری'),
	(N'علی طاهری',N'فرید طاهری'),
	(N'محمد مزیدی',N'سعید رضایی تبار')
GO
SELECT * FROM Employees
SELECT * FROM EmployeesHistory
GO
UPDATE Employees SET ManagerName+='*' WHERE EmployeeID=1
GO 100
UPDATE Employees SET ManagerName+='*' WHERE EmployeeID=2
GO 100
SELECT * FROM Employees
SELECT * FROM EmployeesHistory --بررسی فیلد تاریخ شروع و تاریخ پایان
GO
--------------------------------------------------------------------
--Temporal مدیریت جداول مربوط به 
USE TemporalTableDemo
GO
SELECT 
	index_id,index_type_desc,index_depth,
	index_level,page_count,compressed_page_count
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID('TemporalTableDemo'),OBJECT_ID('Employees'),NULL,NULL,'DETAILED')
GO
--جدول سابقه همیشه فشرده است
SELECT 
	index_id,index_type_desc,index_depth,
	index_level,page_count,compressed_page_count
FROM SYS.DM_DB_INDEX_PHYSICAL_STATS(DB_ID('TemporalTableDemo'),OBJECT_ID('EmployeesHistory'),NULL,NULL,'DETAILED')
GO
ALTER INDEX ALL ON Employees REBUILD 
ALTER INDEX ALL ON EmployeesHistory REBUILD 
GO
CREATE INDEX IX_EmployeeName ON Employees(EmployeeName)
CREATE INDEX IX_EmployeeName ON EmployeesHistory(EmployeeName)
GO
SP_HELPINDEX Employees
SP_HELPINDEX EmployeesHistory
GO
UPDATE STATISTICS Employees WITH FULLSCAN
UPDATE STATISTICS EmployeesHistory WITH FULLSCAN
GO
--------------------------------------------------------------------
--Temporal استخراج اطلاعاتی درباره جداول
SELECT 
	object_id, temporal_type, temporal_type_desc, 
	history_table_id, name 
FROM SYS.TABLES 
WHERE object_id = OBJECT_ID('dbo.Employees', 'U')
GO
SELECT 
	OBJECT_ID, temporal_type, temporal_type_desc, 
	history_table_id, name 
FROM SYS.TABLES 
WHERE 
	OBJECT_ID = 
		( 
			SELECT 
				history_table_id 
			FROM SYS.TABLES 
			WHERE 
				object_id = OBJECT_ID('dbo.Employees', 'U')
		)
GO
--------------------------------------------------------------------
--شماره 4 با این روشSCD پیاده سازی 
GO
