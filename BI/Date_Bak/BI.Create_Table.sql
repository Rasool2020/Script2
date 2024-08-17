Drop TABLE if Exists [dbo].[Dim_Date]
Go
CREATE TABLE [dbo].[Dim_Date](
	FullDate DATE,
	[time_Date_Id] [int] NOT NULL,
	[time_Key_Year_Month_Day_Native] [int] NOT NULL,
	[time_Key_Year_Week_Native] [int] NOT NULL,
	[time_Key_Year_Month_Native] [int] NOT NULL,
	[time_Key_Year_Half_Native] INT NOT NULL,
	[time_Key_Year_Season_Native] INT NOT NULL,
	[time_Key_Year_Native] INT NOT NULL,
	[time_Key_Year_Month_Day] [int] NOT NULL,
	[time_Key_Year_Month] [int] NOT NULL,
	[time_Key_Year_Half] INT NOT NULL,
	[time_Key_Year_Season] INT NOT NULL,
	[time_Key_Year] INT NOT NULL,
	[time_Title_Year_Month_Day] [NVARCHAR](64) Not NULL,
	[time_Title_Year_Week] [NVARCHAR](64) Not NULL,
	[time_Title_Year_Month] [NVARCHAR](64) Not NULL,
	[time_Title_Year_Half] [NVARCHAR](64) Not NULL,
	[time_Title_Year_Season] [NVARCHAR](64) Not NULL,
	[time_Title_Year] [NVARCHAR](16) Not NULL,
	[time_Month_Native] [tinyint] NOT NULL,
	[time_Month_Native_2Char] [char](2) Not NULL,
	[time_Day_Native] [tinyint] NOT NULL,
	[time_Day_Native_2Char] [char](2) Not NULL,
	[time_Date_Name] [NVARCHAR](128) Not NULL,
	[time_Year] INT NOT NULL,
	[time_Month_Of_Year] [tinyint] NOT NULL,
	[time_Month_Of_Year_2Char] [char](2) Not NULL,
	[time_Month_Of_Season] [tinyint] NOT NULL,
	[time_Month_Name] [NVARCHAR](32) Not NULL,
	[time_Day_Of_Year] INT NOT NULL,
	[time_Day_Of_Month] [tinyint] NOT NULL,
	[time_Day_Of_Month_2Char] [char](2) Not NULL,
	[time_Day_Of_Week] [tinyint] NOT NULL,
	[time_Day_Of_Week_Name] [NVARCHAR](128) Not NULL,
	[time_Week_Of_Year] [tinyint] NOT NULL,
	[time_Season_Of_Year] [tinyint] NOT NULL,
	[time_Season_Name] [NVARCHAR](32) Not NULL,
	[time_Half_Of_Year] [tinyint] NOT NULL,
	[time_Half_Of_Year_Name] [NVARCHAR](32) Not NULL
) ON [PRIMARY]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [IXC_Dim_Date] ON [dbo].[Dim_Date] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
GO
CREATE NONCLUSTERED INDEX [IX_Dim_Date_] ON [dbo].[Dim_Date]
([FullDate] ASC)
INCLUDE([time_Date_Id],[time_Key_Year_Month_Day_Native],[time_Key_Year_Week_Native],[time_Key_Year_Month_Native],[time_Key_Year_Half_Native],[time_Key_Year_Season_Native],[time_Key_Year_Native],[time_Key_Year_Month_Day],[time_Key_Year_Month],[time_Key_Year_Half],[time_Key_Year_Season],[time_Key_Year],[time_Title_Year_Month_Day],[time_Title_Year_Week],[time_Title_Year_Month],[time_Title_Year_Half],[time_Title_Year_Season],[time_Title_Year],[time_Month_Native],[time_Month_Native_2Char],[time_Day_Native],[time_Day_Native_2Char],[time_Date_Name],[time_Year],[time_Month_Of_Year],[time_Month_Of_Year_2Char],[time_Month_Of_Season],[time_Month_Name],[time_Day_Of_Year],[time_Day_Of_Month],[time_Day_Of_Month_2Char],[time_Day_Of_Week],[time_Day_Of_Week_Name],[time_Week_Of_Year],[time_Season_Of_Year],[time_Season_Name],[time_Half_Of_Year],[time_Half_Of_Year_Name]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF)

