USE sPeykMAPTest2
Go
DECLARE @DatabaseName nvarchar(50)
DECLARE @SPId int
DECLARE @SQL nvarchar(100)

SET @DatabaseName = N'sPeykMAPTest2'
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
--sp_dboption 'sPeykMAPTest2','single user',True
ALTER DATABASE sPeykMAPTest2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
Go
USE [master]
Go
Drop DATABASE if exists [sPeykMAPTest2]
Go
RESTORE DATABASE [sPeykMAPTest2] FROM  DISK = N'C:\Backup\speykmap.bak' WITH  FILE = 1,  MOVE N'sShipmentManager' TO N'C:\DBFiles\sPeykMAPTest2\sPeykmap.mdf',  MOVE N'sShipmentManager2' TO N'C:\DBFiles\sPeykMAPTest2\sPeykmap2.ndf',  MOVE N'sShipmentManager_log' TO N'C:\DBFiles\sPeykMAPTest2\sPeykmap_log.ldf',  NOUNLOAD,  STATS = 5
GO
Use [sPeykMAPTest2]
Go
