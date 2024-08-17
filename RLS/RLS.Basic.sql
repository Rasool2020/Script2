CREATE TABLE dbo.Orders
(
Supplier_Code int,
[Supplier_Name] varchar(10),
[Orderdate] datetime,
[OrderQuantity] int,
[ProcessedBy] Varchar(10)
)
GO
-- Sample data
INSERT INTO dbo.orders VALUES(101, 'AXP Inc', '2015-08-11 00:34:51:090', 1789, 'LAX')
INSERT INTO dbo.orders VALUES(102, 'VFG Inc', '2014-01-08 19:44:51:090', 767, 'AURA')
INSERT INTO dbo.orders VALUES(103, 'ZAD Inc', '2015-08-19 19:44:51:090', 500, 'ZAP')
INSERT INTO dbo.orders VALUES(102, 'VFG Inc', '2014-08-19 19:44:51:090', 1099, 'ZAP')
INSERT INTO dbo.orders VALUES(101, 'AXP Inc', '2014-08-04 19:44:51:090', 654, 'LAX')
INSERT INTO dbo.orders VALUES(103, 'ZAD Inc', '2015-08-10 19:44:51:090', 498, 'AURA')
INSERT INTO dbo.orders VALUES(102, 'VFG Inc', '2015-04-17 19:44:51:090', 999, 'AURA')
INSERT INTO dbo.orders VALUES(101, 'AXP Inc', '2015-08-21 19:44:51:090', 543, 'ZAP')
INSERT INTO dbo.orders VALUES(103, 'ZAD Inc', '2015-08-06 19:44:51:090', 876, 'ZAP')
INSERT INTO dbo.orders VALUES(102, 'VFG Inc', '2015-08-26 19:44:51:090', 665, 'LAX')
GO
SELECT * FROM dbo.Orders
Go
Alter FUNCTION dbo.fn_securitypredicateOrder (@processedby1 sysname)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS [fn_securityPredicateOrder_result]
FROM dbo.orders
WHERE @processedby1=USER_NAME() -- it will be Filter applied while running the query
Go
CREATE SECURITY POLICY dbo.fn_security
ADD
FILTER PREDICATE dbo.fn_securitypredicateOrder(processedby)
ON dbo.orders
Go
CREATE USER LAX WITHOUT LOGIN
CREATE USER AURA WITHOUT LOGIN
CREATE USER ZAP WITHOUT LOGIN
GO
GRANT SELECT ON dbo.Orders TO LAX
GRANT SELECT ON dbo.Orders TO AURA
GRANT SELECT ON dbo.Orders TO ZAP
Go
EXECUTE ('SELECT * FROM dbo.Orders') AS USER='LAX'
EXECUTE ('SELECT * FROM dbo.Orders') AS USER='AURA'
EXECUTE ('SELECT * FROM dbo.Orders') AS USER='ZAP'
GO
GRANT SHOWPLAN TO ZAP
GO
EXECUTE ('SELECT * FROM dbo.Orders') AS USER='ZAP'
GO
ALTER SECURITY POLICY fn_security WITH (STATE=OFF)
Go
CREATE FUNCTION dbo.fn_securitypredicateOrder (@processedby sysname,@Orderdate datetime)
RETURNS TABLE
WITH SCHEMABINDING
AS
RETURN SELECT 1 AS [fn_securityPredicateOrder_result]
FROM dbo.Orders
WHERE @processedby=USER_NAME() AND @orderdate>=GETDATE()-365
GO
CREATE SECURITY POLICY dbo.fn_security
ADD
FILTER PREDICATE dbo.fn_securitypredicateOrder(processedby,Orderdate)
ON dbo.orders