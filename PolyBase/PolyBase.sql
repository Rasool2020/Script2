SELECT SERVERPROPERTY(N'IsPolybaseInstalled')
Go
--EXEC sp_configure 'hadoop connectivity', 6;
--GO
--RECONFIGURE;
Go
Exec sp_configure N'Polybase Enabled', 1
Reconfigure
Go
CREATE MASTER KEY ENCRYPTION BY PASSWORD ='FSDfjp4532#gew'
GO
--Drop DATABASE SCOPED CREDENTIAL SqlServerCredentials
GO
CREATE DATABASE SCOPED CREDENTIAL SqlServerCredentials
WITH IDENTITY = 'PolybaseLogin', SECRET = 'Sdfhk#@$9FSfwi2';
Go
--DROP EXTERNAL DATA SOURCE SQLServerDataSource
Go
CREATE EXTERNAL DATA SOURCE SQLServerDataSource
WITH (
  LOCATION = 'sqlserver://192.168.159.50:1433' ,
  CREDENTIAL = SQLServerCredentials
);
Go
USE [master]
GO
CREATE LOGIN [PolybaseLogin] WITH PASSWORD=N'Sdfhk#@$9FSfwi2', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [IPA_Log]
GO
CREATE USER [PolybaseLogin] FOR LOGIN [PolybaseLogin]
GO
ALTER ROLE [db_datareader] ADD MEMBER [PolybaseLogin]
GO
ALTER ROLE [db_datawriter] ADD MEMBER [PolybaseLogin]
GO
USE [IPA_Log]
GO

/****** Object:  Table [flight].[TbFlightSearchLogDW]    Script Date: 6/17/2023 2:58:50 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE EXTERNAL TABLE [flight].[TbFlightSearchLog](
	[FlightSearchLogID] [bigint] NOT NULL,
	[OriginLocation] [varchar](32) NOT NULL,
	[Destination] [varchar](32) NOT NULL,
	[DepartureDate] [date] NOT NULL,
	[ReturnDate] [date] NULL,
	[ItineraryCount] [tinyint] NOT NULL,
	[ChildQuantity] [tinyint] NOT NULL,
	[InfantQuantity] [tinyint] NOT NULL,
	[AdultQuantity] [tinyint] NOT NULL,
	[DirectFlightsOnly] [bit] NOT NULL,
	[CabinType] [tinyint] NULL,
	[IpAddress] [varchar](32) NOT NULL,
	[UserAgent] [varchar](512) NULL,
	[ResultIsSucceed] [bit] NOT NULL,
	[ResultCount] [smallint] NOT NULL,
	[ResultMessages] [varchar](64) NULL,
	[ProviderMessages] [varchar](64) NULL,
	[CreateDate] [datetime] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[CreatedByUserRef] [varchar](128) NULL,
	[UpdatedByUserRef] [varchar](128) NULL,
	[SearchType] [tinyint] NOT NULL,
	[SearchMode] [tinyint] NOT NULL,
	[ChannelType] [tinyint] NOT NULL,
	[SessionId] [varchar](200) NULL,
	[CompanyRef] [bigint] NULL,
	[CompanyReferarRef] [bigint] NULL,
	[HostAddress] [varchar](128) NULL,
	[SearchIds] [varchar](128) NULL,
	[DemandType] [tinyint] NOT NULL,
	[OriginLocationItinerary] [varchar](32) NULL,
	[DestinationItinerary] [varchar](32) NULL,
	[DepartureDateItinerary] [date] NULL
) WITH (
 LOCATION='IPA_Log.[flight].[TbFlightSearchLogDW]',
 DATA_SOURCE= SQLServerDataSource
);
Go
Select count(*)
from [flight].[TbFlightSearchLogDW]
Go
Select 'sp_helptext ''' + OBJECT_SCHEMA_NAME(id) + '.' + Object_name(id) + ''''
from syscomments
where text like '%IPA_Log.flight.TbFlightSearchLog%' 
	And not Object_name(id) like '%_old'
Go
SELECT * FROM sys.dm_db_column_store_row_group_physical_stats