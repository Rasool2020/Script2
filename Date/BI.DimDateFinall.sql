--create database dbtest3
--Go
--use dbtest3

--			Section 1 : Create Structure

Drop TABLE if Exists [basic].[DimDate]
Go
--Create Schema Basic
Go
CREATE TABLE [basic].[DimDate](
	[DateKey] [int] NOT NULL,
	[FullDateAlternateKey] [date] NULL,
	[GregorianDayNumberOfWeek] [tinyint] NULL,
	[GregorianDayNameOfWeek] [VARCHAR](10) NULL,
	[GregorianDayNumberOfMonth] [tinyint] NULL,
	[GregorianDayNumberOfYear] [smallint] NULL,
	[GregorianWeekNumberOfYear] [tinyint] NULL,
	[GregorianMonthName] [VARCHAR](10) NULL,
	[GregorianMonthNumberOfYear] [tinyint] NULL,
	[GregorianYear] [smallint] NULL,
	[PersianDateKey] [int] NULL,
	[PersianDate] [char](10) NULL,
	[PersianDayNumberOfWeek] [tinyint] NULL,
	[PersianDayNameOfWeek] [VARCHAR](20) NULL,
	[PersianDayNumberOfMonth] [tinyint] NULL,
	[PersianWeekNumberOfYear] [tinyint] NULL,
	[PersianMonthName] [VARCHAR](8) NULL,
	[PersianMonthNumberOfYear] [tinyint] NULL,
	[PersianYear] [smallint] NULL,
	[quarter] [tinyint] NULL,
	[MiladiDate] [datetime] NULL,
	[MiladiSmallDate] [smalldatetime] NULL,
	[QuarterName] [nVARCHAR](32) NULL,
	[PersianDayNumberOfWeekDesc] [tinyint] NULL,
	[isHoliday] [tinyint] NULL,
 CONSTRAINT [PK_t00Date] PRIMARY KEY CLUSTERED 
([DateKey] ASC)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF))-- --ON [Basic]) --ON [Basic]
GO
CREATE INDEX [IX_dimDate_DateKey] ON [Basic].[DimDate]
(
	[DateKey] ASC
)
INCLUDE([FullDateAlternateKey],[GregorianDayNumberOfMonth],[GregorianDayNumberOfYear],[GregorianWeekNumberOfYear],[GregorianMonthName],[PersianMonthNumberOfYear],[PersianYear],[MiladiDate],[MiladiSmallDate],[GregorianMonthNumberOfYear],[GregorianYear],[PersianDateKey],[PersianDate],[PersianDayNameOfWeek],[PersianDayNumberOfMonth],[PersianMonthName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) --ON [Basic]
GO
CREATE UNIQUE INDEX [IX_dimDate_FullDateAlternateKey] ON [Basic].[DimDate]
(
	[FullDateAlternateKey] ASC
)
INCLUDE([GregorianMonthNumberOfYear],[GregorianYear],[PersianDateKey],[GregorianMonthName],[PersianMonthNumberOfYear],[PersianMonthName],[PersianYear]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) --ON [Basic]
GO
CREATE UNIQUE INDEX [IX_dimDate_MiladiDate] ON [Basic].[DimDate]
(
	[MiladiDate] ASC
)
INCLUDE([GregorianMonthNumberOfYear],[GregorianYear],[PersianDateKey],[GregorianMonthName],[PersianMonthNumberOfYear],[PersianMonthName],[PersianYear]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) --ON [Basic]
GO
CREATE INDEX [IX_DimDate_persianYear] ON [Basic].[DimDate]
(
	[PersianYear] ASC
)
INCLUDE([PersianDateKey],[PersianDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) --ON [Basic]
GO
CREATE COLUMNSTORE INDEX [IXC_DimDate] ON [Basic].[DimDate]
(
	[DateKey],
	[FullDateAlternateKey],
	[GregorianDayNumberOfWeek],
	[GregorianDayNameOfWeek],
	[GregorianDayNumberOfMonth],
	[GregorianDayNumberOfYear],
	[GregorianWeekNumberOfYear],
	[GregorianMonthName],
	[PersianDayNumberOfWeek],
	[PersianDayNameOfWeek],
	[PersianDateKey],
	[PersianDate],
	[PersianMonthNumberOfYear],
	[PersianYear],
	[PersianDayNumberOfMonth],
	[PersianMonthName],
	[GregorianMonthNumberOfYear],
	[GregorianYear],
	[MiladiDate],
	[MiladiSmallDate],
	[PersianDayNumberOfWeekDesc],
	[isHoliday]
)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) --ON [Basic]
GO

--			Section 2 : Create Function

CREATE or Alter FUNCTION [dbo].[MiladiTOShamsi] (@MDate DateTime) 
RETURNS VARCHAR(10)
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

	SET @ShiftDays=466699 + 2
	SET @OneYear= 365.24199


	SET @SYear = 0
	SET @SMonth = 0
	SET @SDay = 0
	SET @AllDays = CAst(@Mdate as Real)

	SET @AllDays = @AllDays + @ShiftDays

	SET @SYear = (@AllDays / @OneYear) --trunc
	SET @LeftDays = @AllDays - @SYear * @OneYear

	if (@LeftDays < 0.5)
	BEGIN
		SET @SYear=@SYear-1
		SET @LeftDays = @AllDays - @SYear * @OneYear
	End;

	SET @YearDay = @LeftDays --trunc
	if (@LeftDays - @YearDay) >= 0.5 
	SET @YearDay=@YearDay+1

	if ((@YearDay / 31) > 6 )
	BEGIN
		SET @SMonth = 6
		SET @YearDay=@YearDay-(6 * 31)
		SET @SMonth= @SMonth+( @YearDay / 30)
		if (@YearDay % 30) <> 0 
		SET @SMonth=@SMonth+1
		SET @YearDay=@YearDay-((@SMonth - 7) * 30)
	End 
	ELSE
	BEGIN
		SET @SMonth = @YearDay / 31
		if (@YearDay % 31) <> 0 
		SET @SMonth=@SMonth+1 
		SET @YearDay=@YearDay-((@SMonth - 1) * 31)
	End
	SET @SDay = @YearDay
	SET @SYear=@SYear+1

	SET @Farsi_Date = CAST (@SYear as VARCHAR(10)) + '/' + 
			REPLICATE('0',2-len(CAST (@SMonth as VARCHAR(10)))) + CAST (@SMonth as VARCHAR(10)) + '/' + 
			REPLICATE('0',2-len(CAST (@SDay as VARCHAR(10)))) + CAST (@SDay as VARCHAR(10))
	Return @Farsi_Date
End
Go
CREATE Or Alter FUNCTION [dbo].[Shamsi_dateonly](@Date_Var DATETIME)
Returns NVARCHAR(50)
WITH schemabinding
AS
  BEGIN
      SET @Date_Var=Dateadd (n, 0, @Date_Var)

      DECLARE @Time_Var NVARCHAR(8)

      SET @Time_Var=Replicate('0', 2-Len(Cast(Datepart(hh, @Date_Var)AS NVARCHAR)))
                    + Cast(Datepart(hh, @Date_Var)AS NVARCHAR)
                    + ':'
                    + Replicate('0', 2-Len(Cast(Datepart(n, @Date_Var)AS
                    NVARCHAR)))
                    + Cast(Datepart(n, @Date_Var)AS NVARCHAR)
                    + ':'
                    + Replicate('0', 2-Len(Cast(Datepart(ss, @Date_Var)AS
                    NVARCHAR)))
                    + Cast(Datepart(ss, @Date_Var)AS NVARCHAR)

      DECLARE @Sh_Y   INT,
              @Sh_M   INT,
              @Sh_D   INT,
              @TmpY   INT,
              @Leap   INT,
              @Result INT

      IF @Date_Var IS NULL
        RETURN ''

      SET @Result = CONVERT(INT, CONVERT(FLOAT, @Date_Var))

      IF @Result <= 78
        BEGIN
            SET @Sh_Y = 1278
            SET @Sh_M = ( @Result + 10 ) / 30 + 10
            SET @Sh_D = ( @Result + 10 ) % 30 + 1
        END
      ELSE
        BEGIN
            SET @Result = @Result - 78
            SET @Sh_Y = 1279

            WHILE 1 = 1
              BEGIN
                  SET @TmpY = @Sh_Y + 11
                  SET @TmpY = @TmpY - ( @TmpY / 33 ) * 33

                  IF ( @TmpY <> 32 )
                     AND ( ( @TmpY / 4 ) * 4 = @TmpY )
                    SET @Leap = 1
                  ELSE
                    SET @Leap = 0

                  IF @Result <= ( 365 + @Leap )
                    BREAK

                  SET @Result = @Result - ( 365 + @Leap )
                  SET @Sh_Y = @Sh_Y + 1
              END

            IF @Result <= 31 * 6
              BEGIN
                  SET @Sh_M = ( @Result - 1 ) / 31 + 1
                  SET @Sh_D = ( @Result - 1 ) % 31 + 1
              END
            ELSE
              BEGIN
                  SET @Sh_M = ( ( @Result - 1 ) - 31 * 6 ) / 30 + 7
                  SET @Sh_D = ( ( @Result - 1 ) - 31 * 6 ) % 30 + 1
              END
        END

      -- Return RIGHT(Cast(@Sh_Y as NVARCHAR(4)),2)+'/'+REPLICATE('0',2-len(Cast(@Sh_M as NVARCHAR(2))))+Cast(@Sh_M as NVARCHAR(2))+'/'+REPLICATE('0',2-len(Cast(@Sh_D as NVARCHAR(2))))+Cast(@Sh_D as NVARCHAR(2)) +' '+@Time_Var
      RETURN LEFT(Cast(@Sh_Y AS NVARCHAR(4)), 4) + '/'
             + Replicate('0', 2-Len(Cast(@Sh_M AS NVARCHAR(2))))
             + Cast(@Sh_M AS NVARCHAR(2)) + '/'
             + Replicate('0', 2-Len(Cast(@Sh_D AS NVARCHAR(2))))
             + Cast(@Sh_D AS NVARCHAR(2))
  END 
Go
CREATE OR ALTER FUNCTION [dbo].[f00ChShamsiToMiladi] (@mDate AS CHAR(10))
RETURNS CHAR(10)
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @arrMiladiMonth VARCHAR(12)
	DECLARE @arrShamsiMonth VARCHAR(12)
	DECLARE @yearNumber SMALLINT
	DECLARE @monthNumber TINYINT
	DECLARE @dayNumber TINYINT
	DECLARE @tmpDate VARCHAR(10)
	DECLARE @tedDays SMALLINT
	DECLARE @num SMALLINT
	DECLARE @miladiYear SMALLINT
	DECLARE @miladiMonth TINYINT
	DECLARE @miladiDay TINYINT

	IF @mDate IS NULL
		RETURN NULL

	IF len(@mDate) <> 10
		RETURN NULL

	SELECT @yearNumber = Convert(SMALLINT, left(@mDate, 4))

	SELECT @monthNumber = Convert(SMALLINT, substring(@mDate, 6, 2))

	SELECT @dayNumber = Convert(SMALLINT, right(@mDate, 2))

	IF @yearNumber < 1000
		RETURN NULL

	IF @monthNumber < 1
		OR @monthNumber > 12
		RETURN NULL

	IF @monthNumber >= 1
		AND @monthNumber <= 6
		IF @dayNumber < 1
			OR @dayNumber > 31
			RETURN NULL

	IF @monthNumber >= 7
		AND @monthNumber <= 11
		IF @dayNumber < 1
			OR @dayNumber > 30
			RETURN NULL

	IF @monthNumber = 12
	BEGIN
		IF (@yearNumber + 1) % 4 = 0
		BEGIN
			IF @dayNumber < 1
				OR @dayNumber > 30
				RETURN NULL
		END
		ELSE
		BEGIN
			IF @dayNumber < 1
				OR @dayNumber > 29
				RETURN NULL
		END
	END

	SELECT @miladiYear = @yearNumber + 621

	SELECT @arrMiladiMonth = CHAR(31)

	IF (@miladiYear + 1) % 4 = 0
		SELECT @arrMiladiMonth = @arrMiladiMonth + CHAR(29)
	ELSE
		SELECT @arrMiladiMonth = @arrMiladiMonth + CHAR(28)

	SELECT @arrMiladiMonth = @arrMiladiMonth + CHAR(31) + CHAR(30) + CHAR(31) + CHAR(30) + CHAR(31) + CHAR(31) + CHAR(30) + CHAR(31) + CHAR(30) + CHAR(31)

	SELECT @arrShamsiMonth = CHAR(31) + CHAR(31) + CHAR(31) + CHAR(31) + CHAR(31) + CHAR(31) + CHAR(30) + CHAR(30) + CHAR(30) + CHAR(30) + CHAR(30)

	IF (@yearNumber + 1) % 4 = 0
		SELECT @arrShamsiMonth = @arrShamsiMonth + CHAR(30)
	ELSE
		SELECT @arrShamsiMonth = @arrShamsiMonth + CHAR(29)

	SELECT @tedDays = 0

	SELECT @num = 1

	WHILE (@num < @monthNumber)
	BEGIN
		SELECT @tedDays = @tedDays + ascii(substring(@arrShamsiMonth, @num, 1))

		SELECT @num = @num + 1
	END

	SELECT @tedDays = @tedDays + @dayNumber

	IF (@yearNumber + 1) % 4 = 0
		SELECT @miladiDay = 19
	ELSE
		SELECT @miladiDay = 20

	SELECT @miladiMonth = 3

	WHILE (@tedDays > 0)
	BEGIN
		IF (@tedDays <= ascii(substring(@arrMiladiMonth, @miladiMonth, 1)) - @miladiDay)
		BEGIN
			SELECT @miladiDay = @miladiDay + @tedDays

			SELECT @tedDays = 0
		END
		ELSE
		BEGIN
			SELECT @tedDays = @tedDays - (ascii(substring(@arrMiladiMonth, @miladiMonth, 1)) - @miladiDay)

			SELECT @miladiDay = 0

			SELECT @miladiMonth = @miladiMonth + 1

			IF (@miladiMonth > 12)
			BEGIN
				SELECT @miladiMonth = 1

				SELECT @miladiYear = @miladiYear + 1
			END
		END
	END

	SELECT @tmpDate = Convert(CHAR(4), @miladiYear) + '/'

	IF (@miladiMonth > 9)
		SELECT @tmpDate = @tmpDate + Convert(VARCHAR(2), @miladiMonth) + '/'
	ELSE
		SELECT @tmpDate = @tmpDate + '0' + Convert(VARCHAR(2), @miladiMonth) + '/'

	IF (@miladiDay > 9)
		SELECT @tmpDate = @tmpDate + Convert(VARCHAR(2), @miladiDay)
	ELSE
		SELECT @tmpDate = @tmpDate + '0' + Convert(VARCHAR(2), @miladiDay)

	--if @withSlash=0 Return replace(@tmpDate,'/','') 
	RETURN @tmpDate
END
GO
Create Or Alter function dbo.GetShamsiWeekNumber(@Date_Var Datetime)
RETURNS TINYINT
With SchemaBinding
AS
BEGIN
	Declare @ShamsiDate CHAR(10)
	Declare @FirstShamsiDate CHAR(10)
	Declare @FirstMiladiDate CHAR(10)
	Declare @DaysFromStartOfShamsiDate int
	Declare @PersianMonthNumber int
	Declare @ShamsiWeekNumber tinyint

	Set @ShamsiDate = [dbo].[Shamsi_DateOnly](@Date_Var)
	Set @FirstShamsiDate = Left(@ShamsiDate, 5) + '01/01'
	Set @FirstMiladiDate = [dbo].[f00ChShamsiToMiladi](@FirstShamsiDate)
	Set @PersianMonthNumber = Substring(@ShamsiDate, 6 ,2)

	Select @DaysFromStartOfShamsiDate = 
		Case When @PersianMonthNumber = '01' Then 0 
			 When @PersianMonthNumber = '02' Then 31
			 When @PersianMonthNumber = '03' Then 62
			 When @PersianMonthNumber = '04' Then 93 
			 When @PersianMonthNumber = '05' Then 124
			 When @PersianMonthNumber = '06' Then 155
			 When @PersianMonthNumber = '07' Then 186
			 When @PersianMonthNumber = '08' Then 216
			 When @PersianMonthNumber = '09' Then 246 
			 When @PersianMonthNumber = '10' Then 276
			 When @PersianMonthNumber = '11' Then 306
			 When @PersianMonthNumber = '12' Then 336
			 Else -1
		END

	Set @DaysFromStartOfShamsiDate = @DaysFromStartOfShamsiDate + Cast(Right(@ShamsiDate,2) as int)
	Set @ShamsiWeekNumber = (@DaysFromStartOfShamsiDate + Datepart(WEEKDAY, @FirstMiladiDate) - 1)/7 + 1

	Return @ShamsiWeekNumber
END
Go

Select max(FullDateAlternateKey),Max(PersianDate) from basic.dimdate
--			Section 3 : Fill DimDate

ALTER INDEX [IX_DimDate_PersianDateKey] ON [basic].[DimDate] DISABLE


Declare @tDate as Date = '2025/03/19'
Insert [basic].[DimDate](DateKey, FullDateAlternateKey, MiladiDate,MiladiSmallDate,PersianDate,PersianDateKey)
Select Format(DATEADD(Day, Value, @tDate), 'yyyyMMdd', 'en-US'), DATEADD(Day, Value, @tDate), DATEADD(Day, Value, @tDate), 
	DATEADD(Day, Value, @tDate), [dbo].[MiladiTOShamsi](DATEADD(Day, Value, @tDate)),Replace([dbo].[MiladiTOShamsi](DATEADD(Day, Value, @tDate)), '/', '')
From GENERATE_SERIES(0,180)


Update [basic].[DimDate] Set 
       [GregorianDayNumberOfWeek]=DATEPART(DW, FullDateAlternateKey)
      ,[GregorianDayNameOfWeek]=DATENAME(DW, FullDateAlternateKey)
      ,[GregorianDayNumberOfMonth]=Day(FullDateAlternateKey)
      ,[GregorianDayNumberOfYear]=DATEPART(dayofyear, FullDateAlternateKey)
      ,[GregorianWeekNumberOfYear]=DATEPART(WEEK, FullDateAlternateKey)
      ,[GregorianMonthName]=FORMAT(FullDateAlternateKey, 'MMMM')
      ,[GregorianMonthNumberOfYear]=Month(FullDateAlternateKey)
      ,[GregorianYear]=Year(FullDateAlternateKey)
      --,[PersianDateKey]=Replace([dbo].[MiladiTOShamsi](FullDateAlternateKey), '/', '')
      --,[PersianDate]=[dbo].[MiladiTOShamsi](FullDateAlternateKey)
      ,[PersianDayNumberOfWeek]=Case When DATEPART(DW, FullDateAlternateKey)=7 Then 1 ELSE DATEPART(DW, FullDateAlternateKey)+1 End
	  ,[PersianDayNumberOfWeekDesc]=7-(Case When DATEPART(DW, FullDateAlternateKey)=7 Then 1 ELSE DATEPART(DW, FullDateAlternateKey)+1 End)
      ,[PersianDayNameOfWeek]=CASE DATEPART(DW, FullDateAlternateKey)
				WHEN 7 THEN 'شنبه'
				WHEN 1 THEN 'يکشنبه'
				WHEN 2 THEN 'دوشنبه'
				WHEN 3 THEN 'سه شنبه'
				WHEN 4 THEN 'چهار شنبه'
				WHEN 5 THEN 'پنج شنبه'
				WHEN 6 THEN 'جمعه'
				End
      ,[PersianDayNumberOfMonth]=Substring([dbo].[MiladiTOShamsi](FullDateAlternateKey), 9, 2)
	  ,[PersianWeekNumberOfYear]=dbo.GetShamsiWeekNumber(FullDateAlternateKey)
      ,[PersianMonthName]=Case Substring([dbo].[MiladiTOShamsi](FullDateAlternateKey), 6, 2)
						When '01' Then 'فروردین'
						When '02' Then 'اردیبهشت'
						When '03' Then 'خرداد'
						When '04' Then 'تیر'
						When '05' Then 'مرداد'
						When '06' Then 'شهریور'
						When '07' Then 'مهر'
						When '08' Then 'آبان'
						When '09' Then 'آذر'
						When '10' Then 'دی'
						When '11' Then 'بهمن'
						When '12' Then 'اسفند'
						End
      ,[PersianMonthNumberOfYear]=Substring([dbo].[MiladiTOShamsi](FullDateAlternateKey), 6, 2)
      ,[PersianYear]=Substring([dbo].[MiladiTOShamsi](FullDateAlternateKey), 1, 4)
      ,[quarter]=Case Substring([dbo].[MiladiTOShamsi](FullDateAlternateKey), 6, 2)
						When '01' Then 1
						When '02' Then 1
						When '03' Then 1
						When '04' Then 2
						When '05' Then 2
						When '06' Then 2
						When '07' Then 3
						When '08' Then 3
						When '09' Then 3
						When '10' Then 4
						When '11' Then 4
						When '12' Then 4
						End
      ,[QuarterName]=Case Substring([dbo].[MiladiTOShamsi](FullDateAlternateKey), 6, 2)
						When '01' Then 'نیم سال اول'
						When '02' Then 'نیم سال اول'
						When '03' Then 'نیم سال اول'
						When '04' Then 'نیم سال دوم'
						When '05' Then 'نیم سال دوم'
						When '06' Then 'نیم سال دوم'
						When '07' Then 'نیم سال سوم'
						When '08' Then 'نیم سال سوم'
						When '09' Then 'نیم سال سوم'
						When '10' Then 'نیم سال چهارم'
						When '11' Then 'نیم سال چهارم'
						When '12' Then 'نیم سال چهارم'
						End
	 ,[isHoliday]=CASE DATEPART(DW, FullDateAlternateKey)
				WHEN 6 THEN 1 --'جمعه'
				Else 0
				End
Where [isHoliday] is null
Go
Update basic.DimDate Set MiladiDate=FullDateAlternateKey,MiladiSmallDate=FullDateAlternateKey
Where MiladiDate is null
--Where [PersianYear]='1403'
Go
Update d Set isHoliday=1
From basic.DimDate d
Join basic.DimDateOccasion do
	ON d.PersianDateKey = do.PersianDateKey
Go
ALTER INDEX [IX_DimDate_PersianDateKey] ON [basic].[DimDate] Rebuild
Go
Select *
From [Hotel].[DimHotelProvider]
Where AccountType<>1