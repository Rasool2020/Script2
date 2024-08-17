--------------------------------------------------------------------
/*
Performance & Tuning in SQL Server 2017 دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
/*
Where Condition عدم استفاده از عبارت های محاسباتی در 
*/
GO
--Show Actual Execution Plan 
SET STATISTICS IO ON
SET STATISTICS TIME ON
GO
USE AdventureWorks2017
GO
SELECT * FROM  Purchasing.PurchaseOrderHeader AS poh
	WHERE  poh.PurchaseOrderID * 2 = 3400 ;
GO
SELECT * FROM  Purchasing.PurchaseOrderHeader AS poh
	WHERE  poh.PurchaseOrderID  = 3400/2 ;
GO


