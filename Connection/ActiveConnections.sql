
-- This script returns the Database, Number of open connections and logged-in user credentials

SELECT DB_NAME(dbid) as DBName, COUNT(dbid) as NumberOfConnections,loginame as LoginName
FROM sys.sysprocesses
WHERE dbid > 0
GROUP BY dbid, loginame

-- This script returns the status, login name and host name for the database you specify.

SELECT spid, status, loginame, hostname, blocked, db_name(dbid), cmd
FROM sys.sysprocesses
WHERE db_name(dbid) = 'databasename'



-- SQL Server 2005 introduced Dynamic Management Views, in this case we can just check if the is_user_process is 1 instead of checking for the value of spid.
-- This will work in SQL Server 2005 and 2008.

SELECT count(*) as ConnectionCount
FROM sys.dm_exec_sessions
WHERE is_user_process = 1


--If you want both system and user information:

SELECT count(*) as ConnectionCount,
CASE when is_user_process =1 then 'UserProcess' else 'System Process' end
FROM sys.dm_exec_sessions
GROUP by is_user_process


--Also, can look at the sys.dm_exec_connections Dynamic Management Views. This view only shows user connections.

SELECT  count(*)  
FROM sys.dm_exec_connections
