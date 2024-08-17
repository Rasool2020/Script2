--------------------------------------------------------------------
/*
دوره کوئری نویسی پیشرفته
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
--پاسخ تمرین جلسه 7
USE AdventureWorksDW2017
GO
DROP TABLE IF EXISTS FactInternetSales2
DROP TABLE IF EXISTS FactInternetSales3

GO
SELECT * INTO FactInternetSales2 FROM FactInternetSales
SELECT * INTO FactInternetSales3 FROM FactInternetSales
GO
CREATE CLUSTERED COLUMNSTORE INDEX IX_CCI ON FactInternetSales2
GO
CREATE CLUSTERED COLUMNSTORE INDEX IX_CCI ON FactInternetSales3
	WITH (DATA_COMPRESSION=COLUMNSTORE_ARCHIVE)
GO
CREATE INDEX IX_CustomerKey ON FactInternetSales2(CustomerKey)
	WITH (DATA_COMPRESSION=PAGE,DROP_EXISTING=ON)
GO
SET STATISTICS IO ON 
SELECT 
	ProductKey,
	COUNT(ProductKey)
FROM FactInternetSales
WHERE 
	OrderDateKey BETWEEN  20110101 AND 20110501
GROUP BY ProductKey
GO
SELECT 
	ProductKey,
	COUNT(ProductKey)
FROM FactInternetSales2
WHERE 
	OrderDateKey BETWEEN  20110101 AND 20110501
GROUP BY ProductKey
GO


SP_SPACEUSED FactInternetSales
GO
SP_SPACEUSED FactInternetSales2
GO
SP_SPACEUSED FactInternetSales3



    
