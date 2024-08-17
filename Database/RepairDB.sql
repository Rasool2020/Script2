DECLARE @DatabaseName NVARCHAR(50)
DECLARE @SPId int
DECLARE @SQLkill NVARCHAR(100)=''

SET @DatabaseName = N'dbDatabase'
--SET @DatabaseName = DB_NAME()
SELECT @SQLkill = STRING_AGG('kill ' + CONVERT(NVARCHAR(MAX), session_id), ';' )
--SELECT @SQLkill = @SQLkill + 'kill ' + CONVERT(NVARCHAR(MAX), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id = DB_ID(@DatabaseName) AND session_id <> @@SPId

Print(@SQLkill);
Exec(@SQLkill);
Go
--sp_dboption 'dbDatabase','single user',True
ALTER DATABASE dbDatabase SET SINGLE_USER WITH ROLLBACK IMMEDIATE
Go
DBCC Checkdb('dbDatabase',REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS
--DBCC Checkdb('dbDatabase',REPAIR_ALLOW_DATA_LOSS) WITH NO_INFOMSGS
DBCC Checkdb('dbDatabase',REPAIR_REBUILD) WITH NO_INFOMSGS
Go
--sp_dboption 'dbDatabase','single user',false
ALTER DATABASE dbDatabase SET MULTI_USER
Go
--DBCC Checkdb('dbDatabase')