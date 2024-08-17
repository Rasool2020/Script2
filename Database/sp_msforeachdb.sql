Exec sp_msforeachdb 
'if (Select database_id 
	From sys.databases
	Where name=''?'')<5
	Return;
USE [?];
DROP USER if Exists [Avijeh];
CREATE USER [Avijeh] FOR LOGIN [Avijeh];'
GO


