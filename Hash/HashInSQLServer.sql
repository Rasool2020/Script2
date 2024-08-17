USE Northwind
GO
/*
است Checksum استفاده از تابع Hash ساده ترین روش 
CHECKSUM ( * | expression [ ,...n ] )  
*/
SELECT CHECKSUM('A')
SELECT CHECKSUM('a')
SELECT CHECKSUM(N'A')
SELECT CHECKSUM(N'a')
GO
SELECT CHECKSUM('ALI')
SELECT CHECKSUM('ali')
GO
SELECT CHECKSUM('علیرضا')
SELECT CHECKSUM(N'علیرضا')
GO
SELECT CHECKSUM('علیرضا')
SELECT CHECKSUM(N'علیرضا')
GO
SELECT CHECKSUM('A','B','C')
SELECT CHECKSUM('A','B','C','D')
GO
--بر روی عملیات هشNull,Blank تاثیر
SELECT CHECKSUM('')
GO
--?
SELECT CHECKSUM(NULL)
GO
--رکوردهای یک جدول Hash برای بدست آوردن Checksum استفاده از تابع 
USE Northwind
GO
SELECT 
	OrderID,CustomerID,EmployeeID,OrderDate,
	CONCAT(OrderID,'|',CustomerID,'|',EmployeeID,'|',OrderDate) AS ConcatColumn,
	CHECKSUM('SHA2_256',CONCAT(OrderID,'|',CustomerID,'|',EmployeeID,'|',OrderDate)) AS HashValue
FROM Orders 
GO
--------------------------------------------------------------------
USE Northwind
GO
--SQL Server هش کردن دیتا در 
GO
/*
HashBytes استفاده از تابع 

HASHBYTES ( '<algorithm>', { @input | 'input' } )  
  
<algorithm>::= MD2 | MD4 | MD5 | SHA | SHA1 | SHA2_256 | SHA2_512   
*/
--به ازاي هر بار اجراي كوئري نتيجه هش يكسان مي باشد
SELECT HASHBYTES('SHA1', 'ALIREZA')
SELECT HASHBYTES('SHA1', 'ALIREZA')
SELECT HASHBYTES('SHA1', 'ALIREZA')
GO
--حروف كوچك و بزرگ در هش كردن تاثير دارد
SELECT HASHBYTES('SHA1', 'ALIREZA')
SELECT HASHBYTES('SHA1', 'alireza')
GO
--داده یونی کد در هش كردن تاثير دارد
SELECT HASHBYTES('SHA1', 'A')
SELECT HASHBYTES('SHA1', N'A')
GO
--دیتا فارسی قابلیت هش شدن دارد
SELECT HASHBYTES('SHA1', 'علیرضا')
SELECT HASHBYTES('SHA1', N'علیرضا')
GO 
--های مختلف Collation دیتا فارسی با 
--تاثیری ندارد
SELECT HASHBYTES('SHA1', 'علیرضا' COLLATE SQL_Latin1_General_CP1256_CI_AS)
SELECT HASHBYTES('SHA1', 'علیرضا' COLLATE PERSIAN_100_CI_AI)
SELECT HASHBYTES('SHA1', N'علیرضا' COLLATE SQL_Latin1_General_CP1256_CI_AS)
SELECT HASHBYTES('SHA1', N'علیرضا' COLLATE PERSIAN_100_CI_AI)
GO 
--بر روی عملیات هشNull,Blank تاثیر
SELECT HASHBYTES('SHA1','')
SELECT HASHBYTES('SHA1',NULL)
GO
--Hash بررسي ساير الگوريتم هاي 
SELECT HASHBYTES('SHA','A')
SELECT HASHBYTES('SHA1','A')
SELECT HASHBYTES('MD5','A')
SELECT HASHBYTES('MD4','A')
SELECT HASHBYTES('MD2','A')
GO
--رکوردهای یک جدول Hash برای بدست آوردن HashBytes استفاده از تابع 
SELECT 
	OrderID,CustomerID,EmployeeID,OrderDate,
	CONCAT(OrderID,'|',CustomerID,'|',EmployeeID,'|',OrderDate) AS ConcatColumn,
	HASHBYTES('SHA2_256',CONCAT(OrderID,'|',CustomerID,'|',EmployeeID,'|',OrderDate)) AS HashValue
FROM Orders 
GO
