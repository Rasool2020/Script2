CREATE or Alter PROCEDURE [sp00Backup]
	(@path varchar(100), @dbType sysname = 'All', @bkpType char(4) = 'Full', 
	 @retention smallint = -1, @liteSpeed char(1) = 'N', @now char(128) = '', 
	 @extension char(4) = '')
AS
SET NOCOUNT ON
DECLARE @dbName sysname 
DECLARE @cmd nvarchar(4000) 
DECLARE @result int 
DECLARE @rowCnt int 
DECLARE @fileName varchar(200) 
DECLARE @edition int 
DECLARE @rc int 
DECLARE @version char(10) 

SET @version = CONVERT(char(10), SERVERPROPERTY('ProductVersion'))
SET @version = Left(@version ,charindex('.' ,@version ) - 1)
--If (@version = '11' Or @version = '12' Or @version = '13' Or @version = '14' Or @version = '15')
--	Set @version = '10'
--If @version NOT IN ('8', '9', '10')
--BEGIN
-- 	SET @rc = 1
-- 	GOTO EXIT_ROUTINE
--END
--If @version IN('9', '10')
	Exec sp00ActiveShell2008
--Else
--	Exec sp00ActiveShell2000

--Enterprise and Developer editions have msdb.dbo.log_shipping* tables, other editions do not
SET @Edition = CONVERT(int, SERVERPROPERTY('EngineEdition'))
-- validate input parameters
If @dbType IS NOT NULL AND @dbType NOT IN ('All', 'System', 'User') AND @dbType NOT LIKE '-%'
BEGIN
	SET @rc = 2
 	GOTO EXIT_ROUTINE
END
If @dbType LIKE '-%' AND @version = '8'
BEGIN
 	If NOT Exists(Select 1 FROM master.dbo.sysdatabases WHERE [name] = SUBSTRING(@dbType, 2, DATALENGTH(@dbType)))
 	BEGIN
 		SET @rc = 3
 		GOTO EXIT_ROUTINE
 	END
END
Else If @dbType LIKE '-%' AND (@version = '9' OR @version = '10')
BEGIN
 	If NOT Exists(Select 1 FROM master.sys.databases WHERE [name] = SUBSTRING(@dbType, 2, DATALENGTH(@dbType)))
 	BEGIN
 		SET @rc = 3
 		GOTO EXIT_ROUTINE
 	END
END
If @bkpType IS NOT NULL AND @bkpType NOT IN ('Full', 'TLog', 'Diff')
BEGIN
 	SET @rc = 4
 	GOTO EXIT_ROUTINE
END
If @dbType = 'System' AND @bkpType <> 'Full'
BEGIN
 	SET @rc = 5
 	GOTO EXIT_ROUTINE
END
If @liteSpeed IS NOT NULL AND @liteSpeed NOT IN ('N', 'Y')
BEGIN
 	SET @rc = 6
 	GOTO EXIT_ROUTINE
END
-- use the default backup directory If @path is null
If @path IS NULL
 	Exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE',N'Software\Microsoft\MSSQLServer\MSSQLServer',N'BackupDirectory', @path output, 'no_output'
-- we need the backslash after the path, so add it If it wasn't provided in the input parameter
If RIGHT(@path, 1) <> '\'
		SET @path = @path + '\'
CREATE TABLE #WhichDatabase(dbName SYSNAME NOT NULL)
-- put the databases to be backed up into temp table
If @dbType LIKE '-%'
BEGIN
	If @bkpType = 'TLog' AND DATABASEPROPERTYEX(SUBSTRING(@dbType, 2, DATALENGTH(@dbType)), 'RECOVERY') = 'SIMPLE'
	BEGIN
		SET @rc = 7
		GOTO EXIT_ROUTINE
	END
	If @edition = 3
	BEGIN
		If @version = '8'
		BEGIN
			If Exists(Select 1 FROM msdb.dbo.log_shipping_databases WHERE database_name = SUBSTRING(@dbType, 2, DATALENGTH(@dbType)))
			BEGIN
				SET @rc = 8
				GOTO EXIT_ROUTINE
			END
		END
		Else If (@version = '9' OR @version = '10')
		BEGIN
			If Exists(Select 1 FROM msdb.dbo.log_shipping_primary_databases WHERE primary_database = SUBSTRING(@dbType, 2, DATALENGTH(@dbType)))
			BEGIN
				SET @rc = 8
				GOTO EXIT_ROUTINE
			END
		END
	END
	If (@version = '9' OR @version = '10')
	BEGIN
		If Exists(Select 1 FROM master.sys.databases WHERE [name] = SUBSTRING(@dbType, 2, DATALENGTH(@dbType)) AND source_database_id IS NOT NULL)
		BEGIN
			SET @rc = 11
			GOTO EXIT_ROUTINE
		END
	END
	INSERT #WhichDatabase(dbName)
	VALUES(SUBSTRING(@dbType, 2, DATALENGTH(@dbType))) 
END
Else If @dbType = 'All' 
BEGIN
	If @edition = 3 AND @version = '8'
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.dbo.sysdatabases
		WHERE 
		[name] NOT IN ('tempdb', 'ReportServerTempDB') AND
		[name] NOT IN (SELECT database_name FROM msdb.dbo.log_shipping_databases) AND
		DATABASEPROPERTYEX([name], 'IsInStandBy') = 0 AND
		DATABASEPROPERTYEX([name], 'Status') = 'ONLINE'
		ORDER BY [name]
	Else If @edition = 3 AND (@version = '9' OR @version = '10')
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.sys.databases
		WHERE 
		[name] NOT IN ('tempdb', 'ReportServerTempDB') AND
		[name] NOT IN (SELECT primary_database FROM msdb.dbo.log_shipping_primary_databases) AND
		DATABASEPROPERTYEX([name], 'IsInStandBy') = 0 AND
		DATABASEPROPERTYEX([name], 'Status') = 'ONLINE'
		ORDER BY [name]
	Else If @version = '8'
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.dbo.sysdatabases
		WHERE 
		[name] NOT IN ('tempdb', 'ReportServerTempDB') AND
		DATABASEPROPERTYEX([name], 'IsInStandBy') = 0 AND
		DATABASEPROPERTYEX([name], 'Status') = 'ONLINE'
		ORDER BY [name]
	Else -- version is 9
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.sys.databases
		WHERE 
		[name] NOT IN ('tempdb', 'ReportServerTempDB') AND
		DATABASEPROPERTYEX([name], 'IsInStandBy') = 0 AND
		DATABASEPROPERTYEX([name], 'Status') = 'ONLINE'
		ORDER BY [name]
	END
Else If @dbType = 'System'
BEGIN
	If @version = 8
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.dbo.sysdatabases
		WHERE [name] IN ('master', 'model', 'msdb')
		ORDER BY [name]
	Else
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.sys.databases
		WHERE [name] IN ('master', 'model', 'msdb')
		ORDER BY [name]
	END
	Else If @dbType = 'User'
	BEGIN
		If @edition = 3 AND @version = '8'
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.dbo.sysdatabases
		WHERE 
		[name] NOT IN ('master', 'model', 'msdb', 'tempdb', 'ReportServerTempDB') AND
		[name] NOT IN (SELECT database_name FROM msdb.dbo.log_shipping_databases) AND
		DATABASEPROPERTYEX([name], 'IsInStandBy') = 0 AND
		DATABASEPROPERTYEX([name], 'Status') = 'ONLINE'
		ORDER BY [name]
	Else If @edition = 3 AND (@version = '9' OR @version = '10')
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.sys.databases
		WHERE 
		[name] NOT IN ('master', 'model', 'msdb', 'tempdb', 'ReportServerTempDB') AND
		[name] NOT IN (SELECT primary_database FROM msdb.dbo.log_shipping_primary_databases) AND
		DATABASEPROPERTYEX([name], 'IsInStandBy') = 0 AND
		DATABASEPROPERTYEX([name], 'Status') = 'ONLINE'
		ORDER BY [name]
	Else If @version = '8'
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.dbo.sysdatabases
		WHERE 
		[name] NOT IN ('master', 'model', 'msdb', 'tempdb', 'ReportServerTempDB') AND
		DATABASEPROPERTYEX([name], 'IsInStandBy') = 0 AND
		DATABASEPROPERTYEX([name], 'Status') = 'ONLINE'
		ORDER BY [name]
	Else
		INSERT #WhichDatabase (dbName)
		SELECT [name]
		FROM master.sys.databases
		WHERE 
		[name] NOT IN ('master', 'model', 'msdb', 'tempdb', 'ReportServerTempDB') AND
		DATABASEPROPERTYEX([name], 'IsInStandBy') = 0 AND
		DATABASEPROPERTYEX([name], 'Status') = 'ONLINE'
		ORDER BY [name]
END
Else -- no databases to be backed up
BEGIN
	SET @rc = 9
	GOTO EXIT_ROUTINE
END
-- Remove snapshots
If (@version = '9' OR @version = '10')
	DELETE t
	FROM #WhichDatabase t 
	JOIN master.sys.databases d	ON t.dbName = d.[name]
	WHERE d.source_database_id IS NOT NULL
-- Get the database to be backed up
SELECT TOP 1 @dbName = dbName
FROM #WhichDatabase
SET @rowCnt = @@ROWCOUNT
-- Iterate throught the temp table until no more databases need to be backed up
-- Select * FROM #WhichDatabase

WHILE @rowCnt <> 0
BEGIN 
	If @bkpType = 'TLog' AND @dbType IN ('All', 'User') AND DATABASEPROPERTYEX(@dbName, 'RECOVERY') = 'SIMPLE'
		PRINT 'Skipping transaction log backup of ' + @dbName
	Else If @bkpType = 'Diff' AND @dbName IN ('master', 'model', 'msdb')
		PRINT 'Skipping differential backup of ' + @dbName
	Else
	BEGIN
		-- Build the dir command that will check to see If the directory exists
		SET @cmd = 'dir ' + @path
		-- Run the dir command, put output of xp_cmdshell into @result
		Exec @result = master..xp_cmdshell @cmd, NO_OUTPUT
		-- If the directory does not exist, we must create it
		If @result <> 0
		BEGIN
			-- Build the mkdir command 
			SET @cmd = 'mkdir ' + @path
			-- Create the directory
			Exec master..xp_cmdshell @cmd, NO_OUTPUT
			If @@ERROR <> 0
			BEGIN
				SET @rc = 10
				GOTO EXIT_ROUTINE
			END
		END
			-- The directory exists, so let's delete files older than two days
			Else If @retention <> -1
			BEGIN
				-- Stores the name of the file to be deleted
				DECLARE @whichFile VARCHAR(1000)
				CREATE TABLE #DeleteOldFiles(DirInfo VARCHAR(7000))
				-- Build the command that will list out all of the files in a directory
				SELECT @cmd = 'dir ' + @path + ' /OD'
				-- Run the dir command and put the results into a temp table
				INSERT #DeleteOldFiles
				Exec master..xp_cmdshell @cmd
				-- Delete all rows from the temp table except the ones that correspond to the files to be deleted
				DELETE FROM #DeleteOldFiles
				WHERE ISDATE(SUBSTRING(DirInfo, 1, 10)) = 0 OR DirInfo LIKE '%<DIR>%' OR SUBSTRING(DirInfo, 1, 10) >= GETDATE() - @retention
				-- Get the file name portion of the row that corresponds to the file to be deleted
				SELECT TOP 1 @whichFile = SUBSTRING(DirInfo, LEN(DirInfo) - PATINDEX('% %', REVERSE(DirInfo)) + 2, LEN(DirInfo)) 
				FROM #DeleteOldFiles 
				SET @rowCnt = @@ROWCOUNT
				-- Interate through the temp table until there are no more files to delete
			WHILE @rowCnt <> 0
		 	BEGIN
				-- Build the del command
				SELECT @cmd = 'del ' + @path + @whichFile + ' /Q /F'
				-- Delete the file
				Exec master..xp_cmdshell @cmd, NO_OUTPUT
				-- To move to the next file, the current file name needs to be deleted from the temp table
				DELETE FROM #DeleteOldFiles
				WHERE SUBSTRING(DirInfo, LEN(DirInfo) - PATINDEX('% %', REVERSE(DirInfo)) + 2, LEN(DirInfo)) = @whichFile
				-- Get the file name portion of the row that corresponds to the file to be deleted
				SELECT TOP 1 @whichFile = SUBSTRING(DirInfo, LEN(DirInfo) - PATINDEX('% %', REVERSE(DirInfo)) + 2, LEN(DirInfo)) 
				FROM #DeleteOldFiles
				SET @rowCnt = @@ROWCOUNT
			END
			DROP TABLE #DeleteOldFiles
		END
	-- Get the current date using style 120, remove all dashes, spaces, and colons
		If LEN(@now) = 0
			SET @now = @dbName + '_' + REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR(50), GETDATE(), 120), '-', ''), ' ', ''), ':', '')
		If LEN(@extension) = 0
			SET @extension =
			CASE
			WHEN @bkpType = 'Full' THEN '.BAK'
			WHEN @bkpType = 'TLog' THEN '.TRN'
			Else '.DIF'
	END
	-- Build the backup path and file name, backup the database
	If @liteSpeed = 'N'
	BEGIN
		SET @fileName = @path + rtrim(ltrim(@now)) + @extension
		If @bkpType = 'FULL'
			BACKUP DATABASE @dbName
			TO DISK = @filename
			WITH INIT
		Else If @bkpType = 'DIFF'
			BACKUP DATABASE @dbName
			TO DISK = @filename
			WITH INIT, DIFFERENTIAL
	Else
		BACKUP LOG @dbName
		TO DISK = @filename
		WITH INIT 
	END
	Else
	BEGIN
		SET @fileName = @path + @now + @extension
		DECLARE @regOutput varchar(20) -- stores the output from the registry
		DECLARE @numProcs INT -- stores the number of processors that the server has registered
		-- Get the number of processors that the server has
		Exec master..xp_regread 
		@rootkey = 'HKEY_LOCAL_MACHINE', 
		@key = 'SYSTEM\CurrentControlSet\Control\Session Manager\Environment\',
		@value_name = 'NUMBER_OF_PROCESSORS',
		@value = @regOutput OUTPUT
		-- We want n - 1 threads, where n is the number of processors
		SET @numProcs = CONVERT(int, @regOutput) - 1
		If @bkpType = 'FULL'
			Exec master.dbo.xp_backup_database
			@database = @dbName,
			@filename = @fileName,
			@threads = @numProcs,
			@init = 1
		Else If @bkpType = 'DIFF'
			Exec master.dbo.xp_backup_database
			@database = @dbName,
			@filename = @fileName,
			@threads = @numProcs,
			@init = 1,
			@with = 'DIFFERENTIAL'
		Else
			Exec master.dbo.xp_backup_log
			@database = @dbName,
			@filename = @fileName,
			@threads = @numProcs,
			@init = 1
		END
	END
	-- To move onto the next database, the current database name needs to be deleted from the temp table
	DELETE FROM #WhichDatabase
	WHERE dbName = @dbName
	-- Get the database to be backed up
	SELECT TOP 1 @dbName = dbName
	FROM #WhichDatabase
	SET @rowCnt = @@ROWCOUNT
	-- Let the system rest for 3 seconds before starting on the next backup
	WAITFOR DELAY '00:00:03'
END
SET @rc = 0
EXIT_ROUTINE:
If @rc <> 0
BEGIN
	DECLARE @rm varchar(500)
	DECLARE @error table (returnCode int PRIMARY KEY CLUSTERED, returnMessage varchar(500))
	INSERT @error(returnCode, returnMessage)
	SELECT 0, 'Success' UNION ALL
	SELECT 1, 'Version is not Between 2000 to 2019' UNION ALL
	SELECT 2, 'Invalid option passed to @dbType' UNION ALL
	SELECT 3, 'Database passed to @dbType does not exist' UNION ALL
	SELECT 4, 'Invalid option passed to @bkpType' UNION ALL
	SELECT 5, 'Only full backups are allowed on system databases' UNION ALL
	SELECT 6, 'Invalid option passed to @liteSpeed' UNION ALL
	SELECT 7, 'Can not backup tlog when using SIMPLE recovery model' UNION ALL
	SELECT 8, 'Will not backup the tlog on a log shipped database' UNION ALL
	SELECT 9, 'No databases to be backed up' UNION ALL
	SELECT 10, 'Unable to create directory' UNION ALL
	SELECT 11, 'Can not backup database snapshots'
	SELECT @rm = returnMessage 
	FROM @error 
	WHERE returnCode = @rc
	RAISERROR(@rm, 16, 1)
END
RETURN @rc
Go
