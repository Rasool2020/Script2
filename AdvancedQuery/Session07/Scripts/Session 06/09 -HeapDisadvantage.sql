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
-- Heap بررسی معایب 

USE WF;
GO

DBCC DROPCLEANBUFFERS;
CHECKPOINT;
GO

-- STATISTICS TIME و STATISTICS IO بررسی
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

-- Heap واکشی تعدادی رکورد خاص از جدول
SELECT * FROM SalesOrderDetail_Heap
	WHERE SalesOrderID < 75100;
-- Clustered واکشی تعدادی رکورد خاص از جدول
SELECT * FROM SalesOrderDetail_Clustered
	WHERE SalesOrderID < 75100;
GO

-- Heap واکشی تعدادی رکورد خاص از جدول
SELECT * FROM SalesOrderDetail_Heap
	WHERE SalesOrderID > 75100;
-- Clustered واکشی تعدادی رکورد خاص از جدول
SELECT * FROM SalesOrderDetail_Clustered
	WHERE SalesOrderID > 75100;
GO

-- Heap واکشی تعدادی رکورد خاص از جدول
SELECT * FROM SalesOrderDetail_Heap
	WHERE SalesOrderID = 72855;
-- Clustered واکشی تعدادی رکورد خاص از جدول
SELECT * FROM SalesOrderDetail_Clustered
	WHERE SalesOrderID = 72855;
GO

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO

-- Clustered و Heap مربوط به Executio Plan مقایسه
SELECT * FROM SalesOrderDetail_Heap
	WHERE SalesOrderID < 75100;
SELECT * FROM SalesOrderDetail_Clustered
	WHERE SalesOrderID < 75100;
GO

-- Clustered و Heap مربوط به Executio Plan مقایسه
SELECT * FROM SalesOrderDetail_Heap
	WHERE SalesOrderID > 75100;
SELECT * FROM SalesOrderDetail_Clustered
	WHERE SalesOrderID > 75100;
GO

-- Clustered و Heap مربوط به Executio Plan مقایسه
SELECT * FROM SalesOrderDetail_Heap
	WHERE SalesOrderID = 72855;
SELECT * FROM SalesOrderDetail_Clustered
	WHERE SalesOrderID = 72855;
GO