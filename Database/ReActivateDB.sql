ALTER DATABASE [dbName] SET ONLINE
Go
exec sp_resetstatus [dbName]
Go
Alter Database [dbName] Set Emergency
Go
--DBCC Checkdb([dbName])
Go
Alter Database [dbName] Set Single_user With RollBack Immediate
Go
DBCC Checkdb([dbName], Repair_Allow_Data_loss)
Go
Alter Database [dbName] Set Multi_User