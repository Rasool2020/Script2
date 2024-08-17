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
USE AdventureWorks2017
GO
--Show Actual Execution Plan 
SET STATISTICS IO ON
GO
--INDEX hint
SELECT 
	*
FROM  Purchasing.PurchaseOrderHeader AS poh WITH (INDEX (PK_PurchaseOrderHeader_PurchaseOrderID))
WHERE  
	poh.PurchaseOrderID * 2 = 3400
GO
--No hint (with the arithmetic operator on the WHERE clause column)
SELECT 
	* 
FROM Purchasing.PurchaseOrderHeader AS poh
WHERE  poh.PurchaseOrderID * 2 = 3400
GO
--No hint (without the arithmetic operator on the  WHERE clause column)
SELECT 
	* 
FROM Purchasing.PurchaseOrderHeader AS poh 
WHERE  
	poh.PurchaseOrderID  = 3400/2

