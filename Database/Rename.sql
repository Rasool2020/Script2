USE kc_test1
Go
alter database kc_test1 set single_user with rollback immediate
Go
DECLARE @DatabaseName NVARCHAR(50)
DECLARE @SPId int
DECLARE @SQL NVARCHAR(100)

SET @DatabaseName = N'kc_test1'
--SET @DatabaseName = DB_NAME()
DECLARE my_cursor CURSOR FAST_FORWARD FOR
SELECT SPId FROM MASTER..SysProcesses
WHERE DBId = DB_ID(@DatabaseName) AND SPId <> @@SPId

OPEN my_cursor

FETCH NEXT FROM my_cursor INTO @SPId

WHILE @@FETCH_STATUS = 0
BEGIN
 SET @SQL = 'KILL ' + CAST(@SPId as NVARCHAR(10))
 -- print @SQL
 EXEC sp_executeSQL @SQL
 
 FETCH NEXT FROM my_cursor INTO @SPId
END

CLOSE my_cursor
DEALLOCATE my_cursor
Go
--ALTER DATABASE kc_test1 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
ALTER DATABASE kc_test1 MODIFY NAME = keycloak_25;
GO  
ALTER DATABASE keycloak_25 SET MULTI_USER

