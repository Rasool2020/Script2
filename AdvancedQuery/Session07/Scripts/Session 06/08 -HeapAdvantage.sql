--------------------------------------------------------------------
/*
SQL Server 2017 دوره آموزشی کوئری‌نویسی پیشرفته در 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Mehdi Shishebory 
*/
--------------------------------------------------------------------
-- Heap Table بررسی محاسن 

USE WF;
GO

-- Heap ایجاد یک جدول از نوع 
DROP TABLE IF EXISTS SalesOrderDetail_Heap;
GO

CREATE TABLE SalesOrderDetail_Heap
(
	SalesOrderID INT NOT NULL,
	SalesOrderDetailID INT,
	CarrierTrackingNumber NVARCHAR(25) NULL,
	OrderQty SMALLINT NULL,
	ProductID INT NULL,
	SpecialOfferID INT NULL,
	UnitPrice MONEY  NULL,
	UnitPriceDiscount MONEY,
	LineTotal  MONEY,
	rowguid UNIQUEIDENTIFIER,
	ModifiedDate DATETIME 
);
GO

-- Clustered ایجاد یک جدول از نوع 
DROP TABLE IF EXISTS SalesOrderDetail_Clustered;
GO

CREATE TABLE SalesOrderDetail_Clustered
(
	SalesOrderID INT NOT NULL,
	SalesOrderDetailID INT,
	CarrierTrackingNumber NVARCHAR(25) NULL,
	OrderQty SMALLINT NULL,
	ProductID INT NULL,
	SpecialOfferID INT NULL,
	UnitPrice MONEY  NULL,
	UnitPriceDiscount MONEY,
	LineTotal  MONEY,
	rowguid UNIQUEIDENTIFIER,
	ModifiedDate DATETIME 
);
GO

-- به‌ازای جدول Clustered Index ایجاد
CREATE CLUSTERED INDEX IX_Clustered 
ON SalesOrderDetail_Clustered (SalesOrderID,SalesOrderDetailID);
GO
--------------------------------------------------------------------

SELECT
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber
    ,OrderQty, ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM AdventureWorks2017.Sales.SalesOrderDetail;
GO

SET NOCOUNT ON;
GO

-- Heap درج دیتا در جدول 
INSERT INTO SalesOrderDetail_Heap
(
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber,
	OrderQty, ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
)
SELECT  
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber
    ,OrderQty, ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM AdventureWorks2017.Sales.SalesOrderDetail;
GO 10

-- Clustered درج دیتا در جدول 
INSERT INTO SalesOrderDetail_Clustered
(
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber,
	OrderQty, ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
)
SELECT
	SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber
    ,OrderQty, ProductID, SpecialOfferID, UnitPrice,
	UnitPriceDiscount, LineTotal, rowguid, ModifiedDate
FROM AdventureWorks2017.Sales.SalesOrderDetail;
GO 10
--------------------------------------------------------------------

-- مشاهده فضای تخصیص یافته به جداول
SP_SPACEUSED SalesOrderDetail_Heap;
GO

SP_SPACEUSED SalesOrderDetail_Clustered;
GO

-- Heap های مربوط به جدولPage بررسی 
SELECT 
	COUNT(*)
FROM sys.dm_db_database_page_allocations
	(
		DB_ID('WF'), OBJECT_ID('SalesOrderDetail_Heap'),
		NULL, NULL, 'DETAILED'
	)
	WHERE page_type_desc = 'DATA_PAGE';
GO

-- Clustered های مربوط به جدولPage بررسی 
SELECT 
	COUNT(*)
FROM sys.dm_db_database_page_allocations
	(
		DB_ID('WF'), OBJECT_ID('SalesOrderDetail_Clustered'),
		NULL, NULL, 'DETAILED'
	)
	WHERE page_type_desc = 'DATA_PAGE';
GO
--------------------------------------------------------------------

DBCC DROPCLEANBUFFERS;
CHECKPOINT;
GO

-- STATISTICS TIME و STATISTICS IO بررسی
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- Heap واکشی تمامی رکوردها از جدول
SELECT * FROM SalesOrderDetail_Heap;
GO
PRINT'----------------------'
-- Clustered واکشی تمامی رکوردها از جدول
SELECT * FROM SalesOrderDetail_Clustered;
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO

-- Clustered و Heap مربوط به Executio Plan مقایسه
SELECT * FROM SalesOrderDetail_Heap;
SELECT * FROM SalesOrderDetail_Clustered;
GO

/*
IO و Time استفاده از لینک زیر برای مشاهده اطلاعات
http://statisticsparser.com/index.html
*/