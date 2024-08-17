use tempdb
Go
sp_helpfile
Go
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'temp5', FILENAME = N'E:\DB\TempDB\temp5.ndf' , SIZE = 262144KB , FILEGROWTH = 262144KB )
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'temp6', FILENAME = N'E:\DB\TempDB\temp6.ndf' , SIZE = 262144KB , FILEGROWTH = 262144KB )
Go
sp_helpfile
Go
