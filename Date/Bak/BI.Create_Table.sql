Drop TABLE if Exists [basic].[DimDate]
Go
CREATE TABLE [basic].[DimDate](
	FullDate DATE,
	[time_Date_Id] [int] NOT NULL,
	--[time_Key_Year_Month_Day_Hour_Native] [int] NOT NULL,
	[time_Key_Year_Month_Day_Native] [int] NOT NULL,
	[time_Key_Year_Week_Native] [int] NOT NULL,
	[time_Key_Year_Month_Native] [int] NOT NULL,
	[time_Key_Year_Half_Native] INT NOT NULL,
	[time_Key_Year_Season_Native] INT NOT NULL,
	[time_Key_Year_Native] INT NOT NULL,
	--[time_Key_Year_Month_Day_Hour] [BIGINT] NOT NULL,
	[time_Key_Year_Month_Day] [int] NOT NULL,
	--[time_Key_Year_Week] [int] NOT NULL,
	[time_Key_Year_Month] [int] NOT NULL,
	[time_Key_Year_Half] INT NOT NULL,
	[time_Key_Year_Season] INT NOT NULL,
	[time_Key_Year] INT NOT NULL,
	--[time_Title_Year_Month_Day_Hour] [NVARCHAR](128) Not NULL,
	[time_Title_Year_Month_Day] [NVARCHAR](64) Not NULL,
	[time_Title_Year_Week] [NVARCHAR](64) Not NULL,
	[time_Title_Year_Month] [NVARCHAR](64) Not NULL,
	[time_Title_Year_Half] [NVARCHAR](64) Not NULL,
	[time_Title_Year_Season] [NVARCHAR](64) Not NULL,
	[time_Title_Year] [NVARCHAR](16) Not NULL,
	[time_Year_Native] INT NOT NULL,
	[time_Month_Native] [tinyint] NOT NULL,
	[time_Month_Native_2Char] [char](2) Not NULL,
	[time_Day_Native] [tinyint] NOT NULL,
	[time_Day_Native_2Char] [char](2) Not NULL,
	--[time_Hour] [tinyint] NOT NULL,
	--[time_Hour_2Char] [char](2) Not NULL,
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
	[time_Half_Of_Year_Name] [NVARCHAR](32) Not NULL,
 CONSTRAINT [PK_Dim_Date] PRIMARY KEY CLUSTERED 
(
	FullDate ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
