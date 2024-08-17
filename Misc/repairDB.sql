DECLARE @DatabaseName nvarchar(50)
DECLARE @SPId int
DECLARE @SQL nvarchar(100)

SET @DatabaseName = N'dbDatabase'
--SET @DatabaseName = DB_NAME()
DECLARE my_cursor CURSOR FAST_FORWARD FOR
SELECT SPId FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId

OPEN my_cursor

FETCH NEXT FROM my_cursor INTO @SPId

WHILE @@FETCH_STATUS = 0
BEGIN
 SET @SQL = 'KILL ' + CAST(@SPId as nvarchar(10))
 print @SQL
 EXEC sp_executeSQL @SQL
 
 FETCH NEXT FROM my_cursor INTO @SPId
END

CLOSE my_cursor
DEALLOCATE my_cursor
Go
--sp_dboption 'dbDatabase','single user',True
ALTER DATABASE dbDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE
Go
dbcc checkdb('dbDatabase',REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS
--dbcc checkdb('dbDatabase',REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS
dbcc checkdb('dbDatabase',REPAIR_REBUILD) WITH NO_INFOMSGS
Go
--sp_dboption 'dbDatabase','single user',false
ALTER DATABASE dbDatabase SET MULTI_USER
Go
--dbcc checkdb('dbDatabase')