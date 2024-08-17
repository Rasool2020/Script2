DBCC CHECKDB
DBCC CHECKIDENT
GO
--Miscellaneous Statements
DROP DATABASE IF EXISTS Northwind_Clone
GO
DBCC CLONEDATABASE (Northwind, Northwind_Clone)   
GO
