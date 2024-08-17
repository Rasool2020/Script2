use AuthDBMo
Go
ALTER DATABASE [AuthDBMo] SET AUTO_CLOSE OFF WITH ROLLBACK IMMEDIATE
GO
if not exists(select 1 from sys.data_spaces Where type='FX')
ALTER DATABASE [AuthDBMo] ADD FILEGROUP [IMO_FG] CONTAINS MEMORY_OPTIMIZED_DATA 
GO
if not exists(select 1 from sys.master_files where type_desc='FILESTREAM' And database_id=DB_ID())
Begin
 Declare @MoPath nvarchar(MAX)
 Declare @strSQL nvarchar(MAX)
 select top 1 @MoPath = SUBSTRING(physical_name,1,len(physical_name)-charindex('\',REVERSE(physical_name))) + '\MemoryOptimizedDB_IMOX' + 'AuthDBMo'
 from sys.master_files
 Where database_id=DB_ID();
 Set @strSQL = 'ALTER DATABASE [AuthDBMo] ADD FILE (NAME = N''MemoryOptimizedDB_IMO'', FILENAME = N''' + @MoPath + ''') TO FILEGROUP [' + (select name from sys.data_spaces Where type='FX') + ']'
 EXEC sp_executesql @strSQL
End
GO
if not exists(select 1 from sys.types where name='MoReturnID')
CREATE TYPE MoReturnID AS TABLE(id INT NOT NULL PRIMARY KEY NONCLUSTERED)
WITH(MEMORY_OPTIMIZED = ON)
Go
if not exists(select 1 from sys.types where name='MoReturnID')
CREATE TYPE MoReturnID AS TABLE(id INT NOT NULL PRIMARY KEY NONCLUSTERED)
WITH(MEMORY_OPTIMIZED = ON)
Go
--CREATE TYPE [dbo].[MoFlightAggregation] AS TABLE(
--	[FlightAggregationID] [bigint] IDENTITY(1,1) NOT NULL,
--	[FlightId] [bigint] NOT NULL,
--	[ClientRefrenceNumber] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[Agency] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[HostAddress] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[SearchType] [int] NOT NULL,
--	[DemandType] [int] NOT NULL,
--	[CreateDate] [datetime] NOT NULL,
--	[FlightStatus] [int] NOT NULL,
--	[FlightItemID] [bigint] NOT NULL,
--	[ReferenceCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[TicketType] [int] NOT NULL,
--	[TourismInvoiceId] [bigint] NULL,
--	[TourismInvoiceStatus] [int] NULL,
--	[HotelBookingRef] [bigint] NULL,
--	[PaymentStatus] [tinyint] NULL,
--	[PaymentId] [bigint] NULL,
--	[BuyerMobile] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[BuyerEmail] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[BuyerName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[User] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[CompanyReferarTitle] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[AssignUser] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[CustomerRefundStatus] [int] NULL,
--	[Itinerary] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[DepartureDate] [datetime] NULL,
--	[DepartureReturnDate] [datetime] NULL,
--	[FlightNumber] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[AirLineCode] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[PassengersNationalCode] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[PassengersFullName] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	[ProviderTitle] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
--	 PRIMARY KEY NONCLUSTERED 
--(
--	[FlightAggregationID] ASC
--)
--)
--WITH (MEMORY_OPTIMIZED = ON)
--GO
--CREATE TYPE [dbo].[MoOrders2] AS TABLE(
--	[OrderType] [tinyint] NULL,
--	[OrderId] [bigint] NOT NULL,
--	[TourismInvoiceId] [bigint] NULL DEFAULT (NULL),
--	[OrderDate] [datetime] NOT NULL,
--	[Adult] [tinyint] NULL DEFAULT ((0)),
--	[Child] [tinyint] NULL DEFAULT ((0)),
--	[Infant] [tinyint] NULL DEFAULT ((0)),
--	INDEX [IX_Orders_OrderId] NONCLUSTERED HASH 
--(
--	[OrderId]
--)WITH ( BUCKET_COUNT = 524288)
--)
--WITH (MEMORY_OPTIMIZED = ON)
--GO
--CREATE TYPE [dbo].[MoOrders3] AS TABLE(
--	[iCount] [int] NULL,
--	[OrderType] [tinyint] NULL,
--	[OrderId] [bigint] NOT NULL,
--	[TourismInvoiceId] [bigint] NULL DEFAULT (NULL),
--	[OrderDate] [datetime] NOT NULL,
--	[Adult] [tinyint] NULL DEFAULT ((0)),
--	[Child] [tinyint] NULL DEFAULT ((0)),
--	[Infant] [tinyint] NULL DEFAULT ((0)),
--	INDEX [IX_Orders_OrderId] NONCLUSTERED HASH 
--(
--	[OrderId]
--)WITH ( BUCKET_COUNT = 524288)
--)
--WITH (MEMORY_OPTIMIZED = ON)
GO
--CREATE TYPE [dbo].[MoReturnID] AS TABLE(
--	[id] [int] NOT NULL,
--	 PRIMARY KEY NONCLUSTERED 
--(
--	[id] ASC
--)
--)
--WITH (MEMORY_OPTIMIZED = ON)
--GO
