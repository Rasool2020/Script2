/*
Use Master
Go
Drop database dbtest3
*/
Go
/*
Create database dbtest3
Go
Use dbtest3
Go
Create Schema Basic
*/
--			Section 1 : Create Structure

Drop TABLE if Exists [basic].[DimDate]

Go
CREATE TABLE [basic].[DimDate](
	[DateKey] [Date] NOT NULL,
	[DateINTKey] [int] NOT NULL,
	[PersianDateKey] [int] NULL,
	[PersianDate] [Char](10) Collate Persian_100_CI_AI NULL,
	[GregorianDayNumberOfWeek] [tinyint] NULL,
	[GregorianDayNumberOfMonth] [tinyint] NULL,
	[GregorianDayNumberOfYear] [smallint] NULL,
	[GregorianWeekNumberOfYear] [tinyint] NULL,
	[GregorianMonthNumberOfYear] [tinyint] NULL,
	[GregorianYear] [smallint] NULL,
	[PersianDayNumberOfWeek] [tinyint] NULL,
	[PersianDayNumberOfMonth] [tinyint] NULL,
	[PersianWeekNumberOfYear] [tinyint] NULL,
	[PersianMonthNumberOfYear] [tinyint] NULL,
	[PersianYear] [smallint] NULL,
	[Quarter] [tinyint] NULL,
	[MiladiDate] [smalldatetime] NULL,
	[PersianDayNumberOfWeekDesc] [tinyint] NULL,
	[isHoliday] [tinyint] NULL
	--, CONSTRAINT [PK_DimDate] PRIMARY KEY CLUSTERED (DateKey ASC) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF,Data_Compression=Page)
	)-- ON [Basic]) ON [Basic]
GO
CREATE CLUSTERED COLUMNSTORE INDEX [PXC_DimDate] ON [basic].[DimDate] Order([DateKey]) 
WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
Go
CREATE Unique INDEX [IXU_dimDate_DateKey] ON [Basic].[DimDate]([DateKey] ASC)
INCLUDE([DateINTKey], [GregorianDayNumberOfWeek], [GregorianDayNumberOfMonth], [GregorianDayNumberOfYear], [GregorianWeekNumberOfYear], [GregorianMonthNumberOfYear], [GregorianYear], [PersianDateKey], [PersianDate], [PersianDayNumberOfWeek], [PersianDayNumberOfMonth], [PersianWeekNumberOfYear], [PersianMonthNumberOfYear], [PersianYear], [Quarter], [MiladiDate], [PersianDayNumberOfWeekDesc], [isHoliday]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF,Data_Compression=Page) --ON [Basic]
GO
CREATE UNIQUE INDEX [IXU_dimDate_Date] ON [Basic].[DimDate]([MiladiDate] ASC)
INCLUDE([GregorianWeekNumberOfYear], [GregorianMonthNumberOfYear], [GregorianYear], [PersianDateKey], [PersianDate], [PersianDayNumberOfWeek], [PersianDayNumberOfMonth], [PersianWeekNumberOfYear]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF,Data_Compression=Page) --ON [Basic]
GO
CREATE INDEX [IX_DimDate_persianYear] ON [Basic].[DimDate]([PersianYear] ASC)
INCLUDE([PersianDateKey],[PersianDate]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, FillFactor=100,Data_Compression=Page) --ON [Basic]
GO
--CREATE COLUMNSTORE INDEX [IXC_DimDate] ON [Basic].[DimDate]
--(
--	[DateINTKey]
--    ,[DateKey]
--    ,[GregorianDayNumberOfWeek]
--    ,[GregorianDayNumberOfMonth]
--    ,[GregorianDayNumberOfYear]
--    ,[GregorianWeekNumberOfYear]
--    ,[GregorianMonthNumberOfYear]
--    ,[GregorianYear]
--    ,[PersianDateKey]
--    ,[PersianDate]
--    ,[PersianDayNumberOfWeek]
--    ,[PersianDayNumberOfMonth]
--    ,[PersianWeekNumberOfYear]
--    ,[PersianMonthNumberOfYear]
--    ,[PersianYear]
--    ,[Quarter]
--    ,[MiladiDate]
--    ,[PersianDayNumberOfWeekDesc]
--    ,[isHoliday]
--)WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0, DATA_COMPRESSION = COLUMNSTORE) --ON [Basic]
Go
CREATE TABLE Basic.DimDateOccasionType
	(
	id TINYINT NOT NULL,
	Title VARCHAR(32) Collate Persian_100_CI_AI NOT NULL
	) -- ON Basic
GO
Insert Basic.DimDateOccasionType(id, Title) Values(1, 'عمومی'),(2, 'خاص')
Go
CREATE CLUSTERED COLUMNSTORE INDEX [PXC_DimDateOccasionType] ON [basic].DimDateOccasionType Order([id]) 
WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
Go
Create Index IXU_DimDateOccasionType ON [basic].DimDateOccasionType ([id]) --ON Basic
Go
--Drop TABLE Basic.DimDateOccasion
Go
CREATE TABLE Basic.DimDateOccasion
	(
	DateKey DATE NOT NULL,
	DimDateOccasionTypeID TINYINT NOT NULL Default(1),
	Title VARCHAR(128) Collate Persian_100_CI_AI NOT NULL,
	isHoliday TINYINT NOT NULL
	)  --ON Basic
GO
ALTER TABLE Basic.DimDateOccasion ADD CONSTRAINT
	DF_DimDateOccasion_isHoliday DEFAULT 0 FOR isHoliday
GO
ALTER TABLE Basic.DimDateOccasionType ADD CONSTRAINT
 PK_DimDateOccasionType PRIMARY KEY NONCLUSTERED (id) 
 WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) --ON [Basic]

GO
ALTER TABLE Basic.DimDateOccasion ADD CONSTRAINT
FK_DimDateOccasion_DimDateOccasionType FOREIGN KEY
(DimDateOccasionTypeID) REFERENCES Basic.DimDateOccasionType(id) 
ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
Go
CREATE CLUSTERED COLUMNSTORE INDEX [PXC_DimDateOccasion] ON [basic].DimDateOccasion Order([DateKey]) 
WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
Go
CREATE INDEX [IX_DimDateOccasion_DateKey] ON [basic].[DimDateOccasion]
([DateKey] ASC) INCLUDE([Title],[isHoliday]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, FillFactor=100)
GO
ALTER TABLE Basic.DimDateOccasion ADD CONSTRAINT
	FK_DimDateOccasion_DimDate FOREIGN KEY
	(DateKey) REFERENCES Basic.DimDate
	(DateKey) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
Go
CREATE INDEX [IXU_DimDateOccasion_DateKey] ON [basic].[DimDateOccasion]
(
	[DateKey] ASC,
	[DimDateOccasionTypeID] ASC
)
INCLUDE([isHoliday], [Title]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF,FillFactor=100)
Go
CREATE TABLE [Basic].[DimDayNameOfWeek](
	[ID] [tinyint] NOT NULL,
	[GregorianDayNameOfWeek] [varchar](16) Collate Persian_100_CI_AI NOT NULL,
	[PersianDayNameOfWeek] [varchar](16) Collate Persian_100_CI_AI NOT NULL
 --,CONSTRAINT [PK_DimDayNameOfWeek] PRIMARY KEY CLUSTERED ([ID] ASC)
 --WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF,FillFactor=100) ON [Basic]
) 
--ON [Basic]
Go
CREATE CLUSTERED COLUMNSTORE INDEX [PXC_DimDayNameOfWeek] ON [basic].DimDayNameOfWeek Order(ID) 
WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
Go
CREATE UNIQUE INDEX [IXU_DimDayNameOfWeek_ID] ON [basic].[DimDayNameOfWeek]([ID] ASC)
INCLUDE([GregorianDayNameOfWeek],[PersianDayNameOfWeek]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, FILLFACTOR=100) --ON [BASIC]
GO
CREATE TABLE [Basic].[DimGregorianMonth](
	[ID] [tinyint] NOT NULL,
	[Title] [varchar](16) Collate Persian_100_CI_AI NOT NULL
	--, CONSTRAINT [PK_DimGregorianMonth] PRIMARY KEY CLUSTERED ([ID] ASC)
	--WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, FillFactor=100) ON [Basic]
) 
--ON [Basic]
Go
CREATE CLUSTERED COLUMNSTORE INDEX [PXC_DimGregorianMonth] ON [basic].DimGregorianMonth Order(ID) 
WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
Go
CREATE Unique INDEX [IXU_DimGregorianMonth_ID] ON [basic].[DimGregorianMonth]([ID] ASC)INCLUDE([Title]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, FILLFACTOR=100)
Go
ALTER TABLE basic.DimDate ADD CONSTRAINT FK_DimDate_DimDayNameOfWeek FOREIGN KEY
	(GregorianDayNumberOfWeek) REFERENCES basic.DimDayNameOfWeek
	(ID) ON UPDATE  NO ACTION ON DELETE  NO ACTION 
Go
CREATE TABLE [Basic].[DimPersianMonth](
	[ID] [tinyint] NOT NULL,
	[MonthName] [varchar](16) Collate Persian_100_CI_AI NOT NULL,
	[HalfYearName] [varchar](16) Collate Persian_100_CI_AI NOT NULL,
	[QuarterYearName] [varchar](16) Collate Persian_100_CI_AI NOT NULL,
	[SeasonName] [varchar](16) Collate Persian_100_CI_AI NOT NULL
	--, CONSTRAINT [PK_DimPersianMonth] PRIMARY KEY CLUSTERED ([ID] ASC)
  --WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, FILLFactor=100) ON [Basic]
) 
--ON [Basic]
Go
CREATE CLUSTERED COLUMNSTORE INDEX [PXC_DimPersianMonth] ON [basic].DimPersianMonth Order(ID) 
WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
Go
CREATE UNIQUE INDEX [IXU_DimPersianMonth] ON [basic].[DimPersianMonth]([ID] ASC)
INCLUDE([MonthName],[HalfYearName],[QuarterYearName],[SeasonName]) 
WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF, FillFactor=100)
Go
ALTER TABLE Basic.DimDate ADD CONSTRAINT
 FK_DimDate_DimPersianMonth FOREIGN KEY(PersianMonthNumberOfYear) 
 REFERENCES Basic.DimPersianMonth (ID) 
 ON UPDATE  NO ACTION 
 ON DELETE  NO ACTION 
Go

--			ُSection 1.5 : Fill Basic Data

INSERT INTO [Basic].[DimDayNameOfWeek]
           ([ID]
           ,[GregorianDayNameOfWeek]
           ,[PersianDayNameOfWeek])
     VALUES
           (1, 'Sunday', N'یکشنبه'), 
		   (2, N'Monday', N'دوشنبه'), 
		   (3, N'Tuesday', N'سه شنبه'), 
		   (4, N'Wednesday', N'چهارشنبه'), 
		   (5, N'Thursday', N'پنجشنبه'), 
		   (6, N'Friday', N'جمعه'), 
		   (7, N'Saturday', N'شنبه')
Go
--Select * From Basic.DimGregorianMonth

Insert Basic.DimGregorianMonth(ID, Title)
Select DATEPART(MONTH, DATEADD(MONTH, Value, Getdate())), FORMAT(DATEADD(MONTH, Value, Getdate()), 'MMMM')
From Generate_Series(0, 11)

Insert Basic.DimPersianMonth([ID],[MonthName],[HalfYearName],[QuarterYearName],[SeasonName])
Values(1, N'فروردین', N'نیمسال اول', N'سه ماهه اول', N'بهار'),
(2, N'اردیبهشت', N'نیمسال اول', N'سه ماهه اول', N'بهار'),
(3, N'خرداد', N'نیمسال اول', N'سه ماهه اول', N'بهار'),
(4, N'تیر', N'نیمسال اول', N'سه ماهه دوم', N'تابستان'),
(5, N'مرداد', N'نیمسال اول', N'سه ماهه دوم', N'تابستان'),
(6, N'شهریور', N'نیمسال اول', N'سه ماهه دوم', N'تابستان'),
(7, N'مهر', N'نیمسال دوم', N'سه ماهه سوم', N'پاییز'),
(8, N'آبان', N'نیمسال دوم', N'سه ماهه سوم', N'پاییز'),
(9, N'آذر', N'نیمسال دوم', N'سه ماهه سوم', N'پاییز'),
(10, N'دی', N'نیمسال دوم', N'سه ماهه چهارم', N'زمستان'),
(11, N'بهمن', N'نیمسال دوم', N'سه ماهه چهارم', N'زمستان'),
(12, N'اسفند', N'نیمسال دوم', N'سه ماهه چهارم', N'زمستان')
Go
ALTER TABLE Basic.DimDate ADD CONSTRAINT
FK_DimDate_DimGregorianMonth FOREIGN KEY(GregorianMonthNumberOfYear) 
REFERENCES Basic.DimGregorianMonth(ID) 
ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
Go

--	Adding Primary Key Constraint

ALTER TABLE basic.DimGregorianMonth ADD CONSTRAINT
	PK_DimGregorianMonth PRIMARY KEY (ID) 
	WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) --ON [Basic]

ALTER TABLE basic.DimDayNameOfWeek ADD CONSTRAINT
	PK_DimDayNameOfWeek PRIMARY KEY (ID) 
	WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) --ON [Basic]

ALTER TABLE basic.DimPersianMonth ADD CONSTRAINT
	PK_DimPersianMonth PRIMARY KEY (ID) 
	WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) --ON [Basic]

Go


--			Section 2 : Create Function


CREATE or Alter FUNCTION [Basic].[MiladiTOShamsi] (@MDate DateTime) 
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
CREATE Or Alter FUNCTION [dbo].[Shamsi_DateOnly](@Date_Var DATETIME)
Returns NVARCHAR(50)
WITH SCHEMABINDING
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

	SELECT @yearNumber = Convert(SMALLINT, Left(@mDate, 4))

	SELECT @monthNumber = Convert(SMALLINT, Substring(@mDate, 6, 2))

	SELECT @dayNumber = Convert(SMALLINT, Right(@mDate, 2))

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
		SELECT @tedDays = @tedDays + ASCII(SUBSTRING(@arrShamsiMonth, @num, 1))

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
		IF (@tedDays <= ASCII(SUBSTRING(@arrMiladiMonth, @miladiMonth, 1)) - @miladiDay)
		BEGIN
			SELECT @miladiDay = @miladiDay + @tedDays

			SELECT @tedDays = 0
		END
		ELSE
		BEGIN
			SELECT @tedDays = @tedDays - (ASCII(SUBSTRING(@arrMiladiMonth, @miladiMonth, 1)) - @miladiDay)

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
Create Or Alter function Basic.GetShamsiWeekNumber(@Date_Var Datetime)
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

Select Min(DateKey), Min(PersianDate),
	Max(DateKey), Max(PersianDate)
From basic.dimdate

--			Section 3 : Fill DimDate

--ALTER INDEX [IX_DimDate_PersianDateKey] ON [basic].[DimDate] DISABLE
--Truncate Table basic.dimdate

Declare @tDate as Date = '1990/01/01'
Insert [basic].[DimDate](DateINTKey, DateKey, MiladiDate,PersianDate,PersianDateKey)
Select Format(DATEADD(Day, Value, @tDate), 'yyyyMMdd', 'en-US'), DATEADD(Day, Value, @tDate), 
	DATEADD(Day, Value, @tDate), Basic.[MiladiTOShamsi](DATEADD(Day, Value, @tDate)), Replace(Basic.[MiladiTOShamsi](DATEADD(Day, Value, @tDate)), '/', '')
From GENERATE_SERIES(0, 10000)
Go
Select top(10) * From Basic.DimDate
--Select DATENAME(DW, getdate())
Update [basic].[DimDate] Set 
       [GregorianDayNumberOfWeek]=DATEPART(DW, DateKey)
      ,[GregorianDayNumberOfMonth]=Day(DateKey)
      ,[GregorianDayNumberOfYear]=DATEPART(dayofyear, DateKey)
      ,[GregorianWeekNumberOfYear]=DATEPART(WEEK, DateKey)
      --,[GregorianMonthName]=FORMAT(DateKey, 'MMMM')
      ,[GregorianMonthNumberOfYear]=Month(DateKey)
      ,[GregorianYear]=Year(DateKey)
      --,[PersianDateKey]=Replace([dbo].[MiladiTOShamsi](FullDateAlternateKey), '/', '')
      --,[PersianDate]=[dbo].[MiladiTOShamsi](FullDateAlternateKey)
      ,[PersianDayNumberOfWeek]=Case When DATEPART(DW, DateKey)=7 Then 1 ELSE DATEPART(DW, DateKey)+1 End
	  ,[PersianDayNumberOfWeekDesc]=7-(Case When DATEPART(DW, DateKey)=7 Then 1 ELSE DATEPART(DW, DateKey)+1 End)
      ,[PersianDayNumberOfMonth]=Substring(Basic.[MiladiTOShamsi](DateKey), 9, 2)
	  ,[PersianWeekNumberOfYear]=Basic.GetShamsiWeekNumber(DateKey)
      ,[PersianMonthNumberOfYear]=Substring(Basic.[MiladiTOShamsi](DateKey), 6, 2)
      ,[PersianYear]=Substring(Basic.[MiladiTOShamsi](DateKey), 1, 4)
      ,[Quarter]=Case Substring(Basic.[MiladiTOShamsi](DateKey), 6, 2)
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
	 ,[isHoliday]=CASE DATEPART(DW, DateKey)
				WHEN 6 THEN 1 --'جمعه'
				Else 0
				End
Where [isHoliday] is NULL

Go
Select DATEPART(DW, DateAdd(Day, Value, GETDATE()))
From Generate_Series(0, 8)
Go
Select * 
From basic.DimDayNameOfWeek
Go
Select * 
From basic.DimDate
Where [isHoliday] is null
Go
sp_spaceused 'basic.DimDate'
Go
Update d Set isHoliday=do.isHoliday
From basic.DimDate d
Join basic.DimDateOccasion do
	ON d.DateKey = do.DateKey
Where do.isHoliday=1
Go
SELECT
    name AS data_type,
    max_length AS max_bytes
FROM sys.types; 
Go
ALTER INDEX IXU_dimDate_DateKey ON [basic].[DimDate] Rebuild
With(ONLINE=ON, FillFactor=100)
Go
Update d set isHoliday=1
From basic.DimDate d
Join basic.DimDateOccasion do
	ON d.DateKey = do.DateKey
Where do.isHoliday=1
Go
--Select v.ID, v.CreateDate, d.PersianDate, dp.MonthName, dp.SeasonName
--From [finance].[Invoice] v
--Join dbtest3.basic.DimDate d 
--	ON d.DateKey = v.CreateDate
--Join dbtest3.[basic].[DimPersianMonth] dp
--	ON d.PersianMonthNumberOfYear = dp.ID
--Go
--Select * From [dbo].[tbl_fact_financial_payment]
--Go
--Select * From [basic].[DimDate]
Go
Alter Table [basic].[DimDate] Rebuild 
Go
sp_spaceused '[basic].[DimDate]'
