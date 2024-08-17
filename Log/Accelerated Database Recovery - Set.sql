DECLARE @DatabaseName NVARCHAR(50)
DECLARE @SPId int
DECLARE @SQLkill NVARCHAR(100)=''

SET @DatabaseName = N'AyeghOrigin'
--SET @DatabaseName = DB_NAME()
SELECT @SQLkill = STRING_AGG('kill ' + CONVERT(NVARCHAR(MAX), session_id), ';' )
--SELECT @SQLkill = @SQLkill + 'kill ' + CONVERT(NVARCHAR(MAX), session_id) + ';'  
FROM sys.dm_exec_sessions
WHERE database_id = DB_ID(@DatabaseName) AND session_id <> @@SPId

Print(@SQLkill);
Exec(@SQLkill);
Go
ALTER DATABASE Current SET ACCELERATED_DATABASE_RECOVERY = ON;