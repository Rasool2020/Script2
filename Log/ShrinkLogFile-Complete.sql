ALTER database [IPA_Log] SET RECOVERY SIMPLE
--ALTER DATABASE [IPA_Log] SET RECOVERY BULK_LOGGED WITH NO_WAIT
Go
--ALTER database [IPA_Log] SET Single_user with Rollback immediate
--ALTER database [IPA_Log] SET multi_user with Rollback immediate
Go
USE [IPA_Log]
Go
CHECKPOINT 
Go 70
Print 'CHECKPOINT Done'
Declare @log_File_Name VARCHAR(200)

Select @log_File_Name = name From sysfiles Where groupid=0

Declare @SQLScript VARCHAR(MAX);
--Set @SQLScript = 'ALTER DATABASE [IPA_Log] MODIFY FILE (NAME = ' + @log_File_Name + ', MAXSIZE = UNLIMITED, FILEGROWTH = 262144KB)'; -- 524288KB 262144KB

--Exec(@SQLScript);

Print 'Modification Done'
Declare @I int = FILE_IDEX(@log_File_Name);

DBCC SHRINKFILE (@I , 512);
DBCC SHRINKFILE (@I , 1024);

DBCC SHRINKFILE (2 , 128);
DBCC SHRINKFILE (2 , 1024);
Print 'SHRINKFILE256 Done'
Go
DBCC SHRINKDATABASE(N'IPA_Log')
Print 'SHRINKDATABASE Done'
Go
sp_helpfile
--	AUX

--SELECT name, database_id, log_reuse_wait, log_reuse_wait_desc 
--FROM sys.databases
--Go
--DBCC LOGINFO