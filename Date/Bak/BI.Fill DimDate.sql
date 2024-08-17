--CREATE OR ALTER FUNCTION [dbo].[MiladiToShamsi2](@Date_Var Datetime) 
--RETURNS CHAR(10) 
--WITH SCHEMABINDING AS 
--BEGIN
--	SET @Date_Var=DATEADD(n, 0, @Date_Var) DECLARE @Sh_Y int, @Sh_M int, @Sh_D int, @TmpY int, @Leap int, @Result int IF @Date_Var IS NULL RETURN ''
--	SET @Result = convert(int, convert(float,@Date_Var)) IF @Result <= 78 BEGIN
--	SET @Sh_Y = 1278
--	SET @Sh_M =(@Result + 10) / 30 + 10
--	SET @Sh_D =(@Result + 10) % 30 + 1 END ELSE BEGIN
--	SET @Result = @Result - 78
--	SET @Sh_Y = 1279 WHILE 1 = 1 BEGIN
--	SET @TmpY = @Sh_Y + 11
--	SET @TmpY = @TmpY -(@TmpY / 33) * 33 IF(@TmpY <> 32)
--	AND((@TmpY / 4) * 4 = @TmpY)
--	SET @Leap = 1 ELSE
--	SET @Leap = 0 IF @Result <=(365+@Leap) BREAK
--	SET @Result = @Result -(365+@Leap)
--	SET @Sh_Y = @Sh_Y + 1 END

--	IF @Result <= 31*6 BEGIN
--	SET @Sh_M =(@Result-1) / 31 + 1
--	SET @Sh_D =(@Result-1) % 31 + 1 END ELSE BEGIN
--	SET @Sh_M =((@Result-1) - 31*6) / 30 + 7
--	SET @Sh_D =((@Result-1) - 31*6) % 30 + 1 END END RETURN LEFT(CAST(@Sh_Y AS CHAR(4)), 4)+'/'+REPLICATE('0', 2-Len(CAST(@Sh_M AS CHAR(2))))+CAST(@Sh_M AS CHAR(2))+'/'+REPLICATE('0', 2-Len(CAST(@Sh_D AS CHAR(2))))+CAST(@Sh_D AS CHAR(2)) 
--END 
--GO
--CREATE TABLE [dbo].[Dim_Date](
--	[FullDate] [date] NOT NULL,
--	[time_Date_Id] [INT] NOT NULL,
--	[time_Key_Year_Month_Day_Native] [INT] NOT NULL,
--	[time_Key_Year_Week_Native] [INT] NOT NULL,
--	[time_Key_Year_Month_Native] [INT] NOT NULL,
--	[time_Key_Year_Half_Native] [INT] NOT NULL,
--	[time_Key_Year_Season_Native] [INT] NOT NULL,
--	[time_Key_Year_Native] [INT] NOT NULL,
--	[time_Key_Year_Month_Day] [INT] NOT NULL,
--	[time_Key_Year_Month] [INT] NOT NULL,
--	[time_Key_Year_Half] [INT] NOT NULL,
--	[time_Key_Year_Season] [INT] NOT NULL,
--	[time_Key_Year] [INT] NOT NULL,
--	[time_Title_Year_Month_Day] [NVARCHAR](64) NOT NULL,
--	[time_Title_Year_Week] [NVARCHAR](64) NOT NULL,
--	[time_Title_Year_Month] [NVARCHAR](64) NOT NULL,
--	[time_Title_Year_Half] [NVARCHAR](64) NOT NULL,
--	[time_Title_Year_Season] [NVARCHAR](64) NOT NULL,
--	[time_Title_Year] [NVARCHAR](16) NOT NULL,
--	[time_Year_Native] [INT] NOT NULL,
--	[time_Month_Native] [TINYINT] NOT NULL,
--	[time_Month_Native_2Char] [CHAR](2) NOT NULL,
--	[time_Day_Native] [TINYINT] NOT NULL,
--	[time_Day_Native_2Char] [CHAR](2) NOT NULL,
--	[time_Date_Name] [NVARCHAR](128) NOT NULL,
--	[time_Year] [INT] NOT NULL,
--	[time_Month_Of_Year] [TINYINT] NOT NULL,
--	[time_Month_Of_Year_2Char] [CHAR](2) NOT NULL,
--	[time_Month_Of_Season] [TINYINT] NOT NULL,
--	[time_Month_Name] [NVARCHAR](32) NOT NULL,
--	[time_Day_Of_Year] [INT] NOT NULL,
--	[time_Day_Of_Month] [TINYINT] NOT NULL,
--	[time_Day_Of_Month_2Char] [CHAR](2) NOT NULL,
--	[time_Day_Of_Week] [TINYINT] NOT NULL,
--	[time_Day_Of_Week_Name] [NVARCHAR](128) NOT NULL,
--	[time_Week_Of_Year] [TINYINT] NOT NULL,
--	[time_Season_Of_Year] [TINYINT] NOT NULL,
--	[time_Season_Name] [NVARCHAR](32) NOT NULL,
--	[time_Half_Of_Year] [TINYINT] NOT NULL,
--	[time_Half_Of_Year_Name] [NVARCHAR](32) NOT NULL
--) --ON [PRIMARY]
--GO
--CREATE CLUSTERED COLUMNSTORE INDEX [IXC_Dim_Date] ON [dbo].[Dim_Date] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) --ON [PRIMARY]
--GO
--CREATE INDEX [IX_Dim_Date_FullDate] ON [dbo].[Dim_Date]([FullDate] ASC)
--INCLUDE([time_Date_Id],[time_Key_Year_Month_Day_Native],[time_Key_Year_Week_Native],[time_Key_Year_Month_Native],[time_Key_Year_Half_Native],[time_Key_Year_Season_Native],[time_Key_Year_Native],[time_Key_Year_Month_Day],[time_Key_Year_Month],[time_Key_Year_Half],[time_Key_Year_Season],[time_Key_Year],[time_Title_Year_Month_Day],[time_Title_Year_Week],[time_Title_Year_Month],[time_Title_Year_Half],[time_Title_Year_Season],[time_Title_Year],[time_Year_Native],[time_Month_Native],[time_Month_Native_2Char],[time_Day_Native],[time_Day_Native_2Char],[time_Date_Name],[time_Year],[time_Month_Of_Year],[time_Month_Of_Year_2Char],[time_Month_Of_Season],[time_Month_Name],[time_Day_Of_Year],[time_Day_Of_Month],[time_Day_Of_Month_2Char],[time_Day_Of_Week],[time_Day_Of_Week_Name],[time_Week_Of_Year],[time_Season_Of_Year],[time_Season_Name],[time_Half_Of_Year],[time_Half_Of_Year_Name]) 
--WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) --ON [PRIMARY]
--GO
CREATE or Alter FUNCTION [dbo].[MiladiTOShamsi] (@MDate DateTime) 
RETURNS Varchar(10)
WITH SCHEMABINDING
AS 
BEGIN 
	DECLARE @SYear as Int
	DECLARE @SMonth as tinyint
	DECLARE @SDay as tinyint
	DECLARE @AllDays as money
	DECLARE @ShiftDays as money
	DECLARE @OneYear as money
	DECLARE @LeftDays as money
	DECLARE @YearDay as INT
	DECLARE @Farsi_Date as VARCHAR(10) 

	SET @MDate=@MDate-CONVERT(char,@MDate,114)

	SET @ShiftDays=466699 +2
	SET @OneYear= 365.24199


	SET @SYear = 0
	SET @SMonth = 0
	SET @SDay = 0
	SET @AllDays = CAst(@Mdate as Real)

	SET @AllDays = @AllDays + @ShiftDays

	SET @SYear = (@AllDays / @OneYear) --trunc
	SET @LeftDays = @AllDays - @SYear * @OneYear

	if (@LeftDays < 0.5)
	begin
	SET @SYear=@SYear-1
	SET @LeftDays = @AllDays - @SYear * @OneYear
	end;

	SET @YearDay = @LeftDays --trunc
	if (@LeftDays - @YearDay) >= 0.5 
	SET @YearDay=@YearDay+1

	if ((@YearDay / 31) > 6 )
	begin
	SET @SMonth = 6
	SET @YearDay=@YearDay-(6 * 31)
	SET @SMonth= @SMonth+( @YearDay / 30)
	if (@YearDay % 30) <> 0 
	SET @SMonth=@SMonth+1
	SET @YearDay=@YearDay-((@SMonth - 7) * 30)
	end 
	else
	begin
	SET @SMonth = @YearDay / 31
	if (@YearDay % 31) <> 0 
	SET @SMonth=@SMonth+1 
	SET @YearDay=@YearDay-((@SMonth - 1) * 31)
	end
	SET @SDay = @YearDay
	SET @SYear=@SYear+1

	SET @Farsi_Date = CAST (@SYear as VarChar(10)) + '/' + 
			REPLICATE('0',2-len(CAST (@SMonth as VarChar(10)))) + CAST (@SMonth as VarChar(10)) + '/' + 
			REPLICATE('0',2-len(CAST (@SDay as VarChar(10)))) + CAST (@SDay as VarChar(10))
	Return @Farsi_Date
END
Go
--SELECT [dbo].[MiladiToShamsi](Getdate()) 
--GO
--CREATE OR ALTER FUNCTION [dbo].[ShamsiToMiladi](@DateStr CHAR(10)) 
--RETURNS DATE 
--WITH SCHEMABINDING 
--AS 
--BEGIN 
--	DECLARE @YYear int DECLARE @MMonth int DECLARE @DDay int DECLARE @epbase int DECLARE @epyear int DECLARE @mdays int DECLARE @persian_jdn int DECLARE @i int DECLARE @j int DECLARE @l int DECLARE @n int DECLARE @TMPRESULT varchar(10) DECLARE @IsValideDate int DECLARE @TempStr varchar(20) DECLARE @TmpDateStr varchar(10)
--	SET @i=charindex('/', @DateStr) --IF LEN(@DateStr) - CHARINDEX('/', @DateStr,CHARINDEX('/', @DateStr,1)+1) = 4

--	SET @TmpDateStr = @DateStr IF((@i<>0)
--							AND(ISNUMERIC(REPLACE(@TmpDateStr, '/', ''))=1)
--							AND(charindex('.', @TmpDateStr)=0)) BEGIN
--	SET @YYear=CAST(SUBSTRING(@TmpDateStr, 1,@i-1) AS INT) IF(@YYear< 1300)
--	SET @YYear =@YYear + 1300 IF @YYear > 9999 RETURN NULL
--	SET @TempStr= SUBSTRING(@TmpDateStr,@i+1, Len(@TmpDateStr))
--	SET @i=charindex('/', @TempStr)
--	SET @MMonth=CAST(SUBSTRING(@TempStr, 1,@i-1) AS INT)
--	SET @MMonth=@MMonth-- -1

--	SET @TempStr= SUBSTRING(@TempStr,@i+1, Len(@TempStr))
--	SET @DDay=CAST(@TempStr AS INT)
--	SET @DDay=@DDay-- - 1
--	IF(@YYear >= 0)
--	SET @epbase = @YYear - 474 ELSE
--	SET @epbase = @YYear - 473
--	SET @epyear = 474 +(@epbase % 2820) IF(@MMonth <= 7)
--	SET @mdays =((@MMonth) - 1) * 31 ELSE
--	SET @mdays =((@MMonth) - 1) * 30 + 6
--	SET @persian_jdn =(@DDay) + @mdays + CAST((((@epyear * 682) - 110) / 2816) AS int) +(@epyear - 1) * 365 + CAST((@epbase / 2820) AS int) * 1029983 +(1948321 - 1) IF(@persian_jdn > 2299160) BEGIN
--	SET @l = @persian_jdn + 68569
--	SET @n = CAST(((4 * @l) / 146097) AS int)
--	SET @l = @l - CAST(((146097 * @n + 3) / 4) AS int)
--	SET @i = CAST(((4000 *(@l + 1)) / 1461001) AS int)
--	SET @l = @l - CAST(((1461 * @i) / 4) AS int) + 31
--	SET @j = CAST(((80 * @l) / 2447) AS int)
--	SET @DDay = @l - CAST(((2447 * @j) / 80) AS int)
--	SET @l = CAST((@j / 11) AS int)
--	SET @MMonth = @j + 2 - 12 * @l
--	SET @YYear = 100 *(@n - 49) + @i + @l END
--	SET @TMPRESULT=CAST(@MMonth AS varchar(2))+'/'+CAST(@DDay AS Varchar(2))+'/'+CAST(@YYear AS varchar(4)) 
--	RETURN CAST(@TMPRESULT AS Date) 
--	END 
--	RETURN NULL 
--END 
GO
--SELECT [dbo].[ShamsiToMiladi]([dbo].[MiladiToShamsi](GETDATE()))
--Go
DECLARE @YearStart	SMALLINT
DECLARE @YearEnd	SMALLINT

DECLARE @DateStart	DATE
DECLARE @DateEnd	DATE

DECLARE @mDate		DATETIME
DECLARE @mYear		INT
DECLARE @mMonth		TINYINT
DECLARE @mDay		TINYINT

DECLARE @sDate		CHAR(10)
DECLARE @sYear		SMALLINT
DECLARE @sMonth		TINYINT
DECLARE @sDay		TINYINT

DECLARE @Hour		TINYINT

DECLARE @sYearCH	CHAR(4)
DECLARE @sMonthCH	CHAR(2)
DECLARE @sDayCH		CHAR(2)

DECLARE @HourCH		CHAR(2)

DECLARE @sDayOfYear		SMALLINT
DECLARE @mDayOfYear		SMALLINT
DECLARE @sWeekOfYear	TINYINT
DECLARE @mWeekOfYear	TINYINT
DECLARE @sDayOfWeek		TINYINT
DECLARE @mDayOfWeek		TINYINT

DECLARE @sMonthName		NVARCHAR(32)
DECLARE @sSeasonName	NVARCHAR(32)
DECLARE @sHalfYearName	NVARCHAR(32)
DECLARE @sDayOfWeekName	NVARCHAR(32)

DECLARE @FirstDayOfYearWeekDay TINYINT

--------------------------------------------------

SET @YearStart	= 1403
SET @YearEnd	= 1403
--------------------------------------------------

SET @DateStart = dbo.ShamsiToMiladi(CAST(@YearStart AS VARCHAR(4)) + '/01/01')
SET @DateEnd = dbo.ShamsiToMiladi(CAST(@YearEnd AS VARCHAR(4)) + '/01/01')

SET @mDate = @DateStart
--Delete [Dim_Date]
WHILE @mDate < @DateEnd
BEGIN
	SET @mYear = DATEPART(yy, @mDate)
	SET @mMonth = DATEPART(mm, @mDate)
	SET @mDay = DATEPART(dd, @mDate)
	
	SET @sDate = dbo.MiladiTOShamsi(@mDate)	
	Print @sDate
	SET @sDay = CAST(RIGHT(@sDate, 2) AS SMALLINT)
	SET @sMonth = CAST(SUBSTRING(@sDate, 6,2) AS SMALLINT)
	SET @sYear = CAST(LEFT(@sDate, 4) AS SMALLINT)

	SET @sDayCH = RIGHT(@sDate, 2) 
	SET @sMonthCH = SUBSTRING(@sDate, 6,2) 
	SET @sYearCH = LEFT(@sDate, 4)
		
	SET @mDayOfWeek =  DATEPART(dw,@mDate) 
	SET @sDayOfWeek =  DATEPART(dw,@mDate) +1
	IF @sDayOfWeek > 7 
		 SET @sDayOfWeek = @sDayOfWeek - 7
	
	SET @mDayOfYear = DATEPART(dy,@mDate)
	IF(@sMonth = 1) AND(@sDay = 1)
	BEGIN 
		SET @sDayOfYear =  1
		SET @FirstDayOfYearWeekDay = @sDayOfWeek		
	END
	ELSE
	BEGIN
		SET @sDayOfYear = @sDayOfYear + 1
	END
	
	--print @sDayOfYear
	--print @FirstDayOfYearWeekDay
	
	SET @sMonthName = 
		CASE @sMonth 
		WHEN 1 THEN N'فروردين'
		WHEN 2 THEN N'ارديبهشت'
		WHEN 3 THEN N'خرداد'
		WHEN 4 THEN N'تير'
		WHEN 5 THEN N'مرداد'
		WHEN 6 THEN N'شهريور'
		WHEN 7 THEN N'مهر'
		WHEN 8 THEN N'آبان'
		WHEN 9 THEN N'آذر'
		WHEN 10 THEN N'دي'
		WHEN 11 THEN N'بهمن'
		WHEN 12 THEN N'اسفند'
		END
		
	SET @sDayOfWeekName = 
		CASE @sDayOfWeek
		WHEN 1 THEN N'شنبه'
		WHEN 2 THEN N'يکشنبه'
		WHEN 3 THEN N'دوشنبه'
		WHEN 4 THEN N'سه شنبه'
		WHEN 5 THEN N'چهار شنبه'
		WHEN 6 THEN N'پنج شنبه'
		WHEN 7 THEN N'جمعه'
		END		

	SET @sSeasonName = 
		CASE CEILING(CAST(@sMonth AS Money) / 3 ) 
		WHEN 1 THEN N'سه ماهه اول'
		WHEN 2 THEN N'سه ماهه دوم'
		WHEN 3 THEN N'سه ماهه سوم'
		WHEN 4 THEN N'سه ماهه چهارم'
		END		
	
	SET @sHalfYearName = 
		CASE CEILING(CAST(@sMonth AS Money) / 6 ) 
		WHEN 1 THEN N'نيمسال اول'
		WHEN 2 THEN N'نيمسال دوم'
	END		

	SET @mWeekOfYear =  DATEPART(ww, @mDate)
	SET @sWeekOfYear =  CEILING((CAST(@sDayOfYear AS Money) + CAST(@FirstDayOfYearWeekDay AS Money)-1) / 7)
	
	SET @Hour = 1 
	WHILE @Hour <= 1
	BEGIN		
		SET @HourCH =  REPLICATE('0', 2 - LEN(LTRIM(CAST(@Hour AS VARCHAR(2))))) + CAST(@Hour AS VARCHAR(2))
		
		INSERT INTO [Dim_Date](
			[time_Date_Id],--[time_Key_Year_Month_Day_Hour_Native],
			[time_Key_Year_Month_Day_Native],
			[time_Key_Year_Week_Native],[time_Key_Year_Month_Native],[time_Key_Year_Half_Native],
			[time_Key_Year_Season_Native],[time_Key_Year_Native],--[time_Key_Year_Month_Day_Hour],
			[time_Key_Year_Month_Day],[time_Key_Year_Month],[time_Key_Year_Half],
			[time_Key_Year_Season],[time_Key_Year],--[time_Title_Year_Month_Day_Hour],
			[time_Title_Year_Month_Day],
			[time_Title_Year_Week],[time_Title_Year_Month],[time_Title_Year_Half],[time_Title_Year_Season],
			[time_Title_Year],[time_Year_Native],[time_Month_Native],[time_Month_Native_2CHAR],
			[time_Day_Native],[time_Day_Native_2CHAR],--[time_Hour],[time_Hour_2CHAR],
			[time_Date_Name],[time_Year],
			[time_Month_Of_Year],[time_Month_Of_Year_2CHAR],[time_Month_Of_Season],[time_Month_Name],
			[time_Day_Of_Year],[time_Day_Of_Month],[time_Day_Of_Month_2CHAR],[time_Day_Of_Week],[time_Day_Of_Week_Name],
			[time_Week_Of_Year],[time_Season_Of_Year],[time_Season_Name],[time_Half_Of_Year],[time_Half_Of_Year_Name],fulldate
		)
		VALUES
		(
			CAST(@mDate AS INT), 
			--CAST(@mYear  * 1000000 + @mMonth * 10000 + @mDay * 100 + @Hour AS BIGINT),
			@mYear  * 10000		+ @mMonth * 100		  + @mDay,
			@mYear  * 100		+ @mWeekOfYear,
			@mYear  * 100		+ @mMonth,
			@mYear  * 10		+ CEILING(CAST(@mMonth AS Money) / 6 ),
			@mYear  * 10		+ CEILING(CAST(@mMonth AS Money) / 3 ) ,
			@mYear,
			@sYear  * 10000	+ @sMonth * 100 + @sDay,
			@sYear  * 10000		+ @sMonth * 100	+ @sDay,
			--@sYear  * 100		+ @sWeekOfYear,
			@sYear  * 100		+ @sMonth,
			@sYear  * 10		+ CEILING(CAST(@sMonth AS Money) / 6 ),
			@sYear  * 10		+ CEILING(CAST(@sMonth AS Money) / 3 ),
			--@sYear,
			--N'ساعت ' + CAST(@Hour AS NVARCHAR(2))+ N' ' + N'روز' + N' ' + @sDate,
			@sDate,
			N'هفته ' + CAST(@sDayOfWeek AS NVARCHAR(2))+ N' سال ' + @sYearCH,
			@sMonthName + N' ' + @sYearCH, 
			@sHalfYearName + N' ' + @sYearCH, 
			@sSeasonName + N' ' + @sYearCH, 
			N'سال ' + @sYearCH, 
			@sYear,
			@sMonth,
			@sMonthCH,
			@sDay,
			@sDayCH,
			--@Hour,
			--@HourCH, 
			N'روز' + CAST(@sDay AS NVARCHAR(2)) + N' ' + @sMonthName + N' ' + @sYearCH, 
			@sYear,
			@sMonth,
			@sMonthCH,
			CASE WHEN @sMonth % 3 = 0 THEN 3 ELSE @sMonth % 3 END, 
			@sMonthName, 
			@sDayOfYear,
			@sDay, 
			@sDayCH,
			@sDayOfWeek,
			@sDayOfWeekName,
			@sWeekOfYear,
			CEILING(CAST(@sMonth AS Money) / 3), 
			@sSeasonName,
			CEILING(CAST(@sMonth AS Money) / 6 ),
			@sHalfYearName,
			@mDate
		)
		SET @Hour = @Hour + 1
	END
	
	SET @mDate = DATEADD(day, 1, @mDate )
END
Go
Select *
from Dim_Date
Order By FullDate