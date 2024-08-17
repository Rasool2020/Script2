ALTER DATABASE [tempdb] Remove FILE [tempdev2]
GO
ALTER DATABASE [tempdb] Remove FILE [tempdev3]
GO
ALTER DATABASE [tempdb] Remove File [tempdev4.ndf]
Go
ALTER DATABASE [tempdb] Remove File [tempdev5.ndf]
GO
ALTER DATABASE [tempdb] Remove File [tempdev6.ndf]
GO
ALTER DATABASE [tempdb] Remove File [tempdev7.ndf]
Go
ALTER DATABASE [tempdb] Remove File [tempdev9.ndf]
GO
ALTER DATABASE [tempdb] Remove File [tempdev10.ndf]
Go
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev2', FILENAME = N'D:\DBFile\TempDB\tempdev2.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev3', FILENAME = N'D:\DBFile\TempDB\tempdev3.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev4y', FILENAME = N'D:\DBFile\TempDB\tempdev4.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
Go
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev5y', FILENAME = N'E:\DBFile\TempDB\tempdev5.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev6y', FILENAME = N'E:\DBFile\TempDB\tempdev6.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev7y', FILENAME = N'E:\DBFile\TempDB\tempdev7.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
Go
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev9y', FILENAME = N'E:\DBFile\TempDB\tempdev8.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
GO
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev10y', FILENAME = N'E:\DBFile\TempDB\tempdev10.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
Go
ALTER DATABASE [tempdb] ADD FILE ( NAME = N'tempdev11y', FILENAME = N'E:\DBFile\TempDB\tempdev11.ndf' , SIZE = 524288KB , FILEGROWTH = 262144KB )
Go
sp_helpfile