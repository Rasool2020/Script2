--spPopulatePersianDateDimension @FromDate,@untilDate
--Example: exec spPopulatePersianDateDimension '2010-01-01','2030-01-01'
if object_id('GregorianToJalali')>0
drop function [dbo].[GregorianToJalali]
GO
CREATE FUNCTION [dbo].[GregorianToJalali]
    (
      @GregorianDate DATETIME ,
      @OutputFormat AS NVARCHAR(MAX)
    )
RETURNS NVARCHAR(MAX)
    BEGIN

		/* OutputFormat Rules: (Å‰Ã‘‰»Â 7 «—œÌ»Â‘  1394)
		ChandShanbe -> Å‰Ã‘‰»Â (—Ê“ Â› Â »Â Õ—Ê›)
		ChandShanbeAdadi -> 6 (—Ê“ Â› Â »Â ⁄œœ)
		Rooz -> 7 (ç‰œ„Ì‰ —Ê“ «“ „«Â)
		Rooz2 -> 07 (ç‰œ„Ì‰ —Ê“ «“ „«Â œÊ ò«—«ò —Ì)
		Maah -> 2 (ç‰œ„Ì‰ „«Â «“ ”«·)
		Maah2 -> 02 (ç‰œ„Ì‰ „«Â «“ ”«· œÊ ò«—«ò —Ì)
		MaahHarfi -> «—œÌ»Â‘  (‰«„ „«Â »Â Õ—Ê›)
		Saal -> 1394 (”«· çÂ«— ò«—«ò —Ì)
		Saal2 -> 94 (”«· œÊ ò«—«ò —Ì)
		Saal4 -> 1394 (”«· çÂ«— ò«—«ò —Ì)
		SaalRooz -> 38 (ç‰œ„Ì‰ —Ê“ ”«·)
		Default OutputFormat -> 'ChandShanbe Rooz MaahHarfi Saal'
		*/

        DECLARE @YY SMALLINT= YEAR(@GregorianDate) ,
            @MM TINYINT= 10 ,
            @DD SMALLINT= 11 ,
            @DDCNT TINYINT ,
            @YYDD SMALLINT= 0 ,
            @SHMM NVARCHAR(8) ,
            @SHDD NVARCHAR(8)
        DECLARE @SHDATE NVARCHAR(MAX)



        IF @YY < 1000
            SET @YY += 2000

        IF ( @OutputFormat IS NULL )
            OR NOT LEN(@OutputFormat) > 0
            SET @OutputFormat = 'ChandShanbe Rooz MaahHarfi Saal'

        SET @YY -= 622

        IF @YY % 4 = 3
            AND @YY > 1371
            SET @DD = 12

        SET @DD += DATEPART(DY, @GregorianDate) - 1

        WHILE 1 = 1
            BEGIN

                SET @DDCNT = CASE WHEN @MM < 7 THEN 31
                                  WHEN @YY % 4 < 3
                                       AND @MM = 12
                                       AND @YY > 1370 THEN 29
                                  WHEN @YY % 4 <> 2
                                       AND @MM = 12
                                       AND @YY < 1375 THEN 29
                                  ELSE 30
                             END
                IF @DD > @DDCNT
                    BEGIN
                        SET @DD -= @DDCNT
                        SET @MM += 1
                        SET @YYDD += @DDCNT
                    END
                IF @MM > 12
                    BEGIN
                        SET @MM = 1
                        SET @YY += 1
                        SET @YYDD = 0
                    END
                IF @MM < 7
                    AND @DD < 32
                    BREAK
                IF @MM BETWEEN 7 AND 11
                    AND @DD < 31
                    BREAK
                IF @MM = 12
                    AND @YY % 4 < 3
                    AND @YY > 1370
                    AND @DD < 30
                    BREAK
                IF @MM = 12
                    AND @YY % 4 <> 2
                    AND @YY < 1375
                    AND @DD < 30
                    BREAK
                IF @MM = 12
                    AND @YY % 4 = 2
                    AND @YY < 1371
                    AND @DD < 31
                    BREAK
                IF @MM = 12
                    AND @YY % 4 = 3
                    AND @YY > 1371
                    AND @DD < 31
                    BREAK

            END

        SET @YYDD += @DD

        SET @SHMM = CASE WHEN @MM = 1 THEN N'›—Ê—œÌ‰'
                         WHEN @MM = 2 THEN N'«—œÌ»Â‘ '
                         WHEN @MM = 3 THEN N'Œ—œ«œ'
                         WHEN @MM = 4 THEN N' Ì—'
                         WHEN @MM = 5 THEN N'„—œ«œ'
                         WHEN @MM = 6 THEN N'‘Â—ÌÊ—'
                         WHEN @MM = 7 THEN N'„Â—'
                         WHEN @MM = 8 THEN N'¬»«‰'
                         WHEN @MM = 9 THEN N'¬–—'
                         WHEN @MM = 10 THEN N'œÌ'
                         WHEN @MM = 11 THEN N'»Â„‰'
                         WHEN @MM = 12 THEN N'«”›‰œ'
                    END
   

        SET @SHDD = CASE WHEN DATEPART(dw, @GregorianDate) = 7 THEN N'‘‰»Â'
                         WHEN DATEPART(dw, @GregorianDate) = 1 THEN N'Ìò‘‰»Â'
                         WHEN DATEPART(dw, @GregorianDate) = 2 THEN N'œÊ‘‰»Â'
                         WHEN DATEPART(dw, @GregorianDate) = 3 THEN N'”Âù‘‰»Â'
                         WHEN DATEPART(dw, @GregorianDate) = 4 THEN N'çÂ«—‘‰»Â'
                         WHEN DATEPART(dw, @GregorianDate) = 5 THEN N'Å‰Ã‘‰»Â'
                         WHEN DATEPART(dw, @GregorianDate) = 6 THEN N'Ã„⁄Â'
                    END
        SET @DDCNT = CASE WHEN @SHDD = N'‘‰»Â' THEN 1
                          WHEN @SHDD = N'Ìò‘‰»Â' THEN 2
                          WHEN @SHDD = N'œÊ‘‰»Â' THEN 3
                          WHEN @SHDD = N'”Âù‘‰»Â' THEN 4
                          WHEN @SHDD = N'çÂ«—‘‰»Â' THEN 5
                          WHEN @SHDD = N'Å‰Ã‘‰»Â' THEN 6
                          WHEN @SHDD = N'Ã„⁄Â' THEN 7
                     END


        SET @SHDATE = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@OutputFormat,
                                                                                             'MaahHarfi', @SHMM),
                                                                                         'SaalRooz', LTRIM(STR(@YYDD,3))),
                                                                                     'ChandShanbeAdadi',@DDCNT),
                                                                                 'ChandShanbe', @SHDD),
															                 'Rooz2', REPLACE(STR(@DD,2), ' ', '0')),
                                                                     'Maah2', REPLACE(STR(@MM,2), ' ', '0')),
                                                              'Saal2', SUBSTRING(STR(@YY,4), 3, 2)),
                                                     'Saal4', STR(@YY, 4)),
                                             'Saal', LTRIM(STR(@YY, 4))),
                                      'Maah', LTRIM(STR(@MM, 2))), 
							 'Rooz', LTRIM(STR(@DD, 2)))

		/* OutputFormat Samples:
		OutputFormat='ChandShanbe Rooz MaahHarfi Saal' -> Å‰Ã‘‰»Â 17 «—œÌ»Â‘  1394
		OutputFormat='Rooz MaahHarfi Saal' -> ‹ 17 «—œÌ»Â‘  1394
		OutputFormat='Rooz/Maah/Saal' -> 1394/2/17
		OutputFormat='Rooz2/Maah2/Saal2' -> 94/02/17
		OutputFormat='Rooz —Ê“ ê–‘ Â «“ MaahHarfi œ— ”«· Saal2' -> ‹ 17 —Ê“ ê–‘ Â «“ «—œÌ»Â‘  œ— ”«· 94
		*/

        RETURN @SHDATE
    END

GO
if object_id('spPopulatePersianDateDimension')>0
drop proc spPopulatePersianDateDimension
GO
CREATE PROCEDURE [dbo].[spPopulatePersianDateDimension]
    @FromDate DATETIME ,
    @ToDate DATETIME
AS
    BEGIN
        SET NOCOUNT ON;

        BEGIN TRAN
        DECLARE @dates TABLE ( FullDate DATE )

        WHILE @FromDate <= @ToDate
            BEGIN 
                INSERT  INTO @dates
                        ( FullDate )
                        SELECT  @FromDate

                SET @FromDate = DATEADD(dd, 1, @FromDate)
            END 

        INSERT  INTO dbo.dimdate
                ( DateKey ,GregorianDateKey,
                  FullDateAlternateKey ,
                  GregorianDayNumberOfWeek ,
                  GregorianDayNameOfWeek ,
                  GregorianDayNumberOfMonth ,
                  GregorianDayNumberOfYear ,
                  GregorianWeekNumberOfYear ,
                  GregorianMonthName ,
                  GregorianMonthNumberOfYear ,
                  GregorianYear ,
                  PersianDate ,
                  PersianDayNumberOfWeek ,
                  PersianDayNameOfWeek ,
                  PersianDayNumberOfMonth ,
                  --PersianDayNumberOfYear ,
                  PersianMonthName ,
                  PersianMonthNumberOfYear ,
                  PersianYear,
				  [quarter],
				  persianseasonName ,
				[isToday] ,
				[dateDescription] ,
				[Pastdate] ,
				[dimDateTypeID] 
				
                )
                SELECT  CONVERT(INT, dbo.GregorianToJalali(d.FullDate,
                                                           'SaalMaah2Rooz2')) AS DateKey ,YEAR(d.FullDate)*10000+MONTH(d.FullDate)*100+DATEPART(d, d.FullDate) ,
                        d.FullDate ,
                        DATEPART(dw, d.FullDate) AS GregorianDayNumberOfWeek ,
                        DATENAME(WEEKDAY, d.FullDate) AS GregorianDayNameOfWeek ,
                        DATEPART(d, d.FullDate) AS GregorianDayNumberOfMonth ,
                        DATEPART(dy, d.FullDate) AS GregorianDayNumberOfYear ,
                        DATEPART(wk, d.FUllDate) AS GregorianWeekNumberOfYear ,
                        DATENAME(MONTH, d.FullDate) AS GregorianMonthName ,
                        MONTH(d.FullDate) AS GregorianMonthNumberOfYear ,
                        YEAR(d.FullDate) AS GregorianYear ,
                        dbo.GregorianToJalali(d.FullDate, 'Saal/Maah2/Rooz2') AS PersianDate ,
                        CONVERT(TINYINT, dbo.GregorianToJalali(d.FullDate,
                                                              'ChandShanbeAdadi')) AS PersianDayNumberOfWeek ,
                        dbo.GregorianToJalali(d.FullDate, 'ChandShanbe') AS PersianDayNameOfWeek ,
                        CONVERT(TINYINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Rooz')) AS PersianDayNumberOfMonth ,
                        --CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                        --                                      'SaalRooz')) AS PersianDayNumberOfYear ,
                        dbo.GregorianToJalali(d.FullDate, 'MaahHarfi') AS PersianMonthName ,
                        CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Maah')) AS PersianMonthNumberOfYear ,
                        CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Saal')) AS PersianYear,
				case when CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Maah'))<4 then 1
					when CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Maah'))<7 then 2										  
					when CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Maah'))<10 then 3
					else 4 end as  [quarter] ,
				case when CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Maah'))<4 then '»Â«—'
					when CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Maah'))<7 then ' «»” «‰'										  
					when CONVERT(SMALLINT, dbo.GregorianToJalali(d.FullDate,
                                                              'Maah'))<10 then 'Å«??“'
					else '“„” «‰' end as  persianseasonName ,
				0 as [isToday] ,
				'' as [dateDescription] ,
				0 as [Pastdate] ,
				0 as [dimDateTypeID] 
				
                FROM    @dates d
                        LEFT JOIN dbo.PersianDateDimension pd ON d.FullDate = pd.FullDateAlternateKey
                WHERE   pd.FullDateAlternateKey IS NULL 

        COMMIT TRAN
    END
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[dimDate](
	[GregorianDateKey] [int] NOT NULL,
	[FullDateAlternateKey] [date] NOT NULL,
	[GregorianDayNumberOfWeek] [tinyint] NOT NULL,
	[GregorianDayNameOfWeek] [nvarchar](10) NOT NULL,
	[GregorianDayNumberOfMonth] [tinyint] NOT NULL,
	[GregorianDayNumberOfYear] [smallint] NOT NULL,
	[GregorianWeekNumberOfYear] [tinyint] NOT NULL,
	[GregorianMonthName] [nvarchar](10) NOT NULL,
	[GregorianMonthNumberOfYear] [tinyint] NOT NULL,
	[GregorianYear] [smallint] NOT NULL,
	[DateKey] [int] NOT NULL,
	[PersianDate] [nchar](10) NOT NULL,
	[PersianDayNumberOfWeek] [tinyint] NOT NULL,
	[PersianDayNameOfWeek] [nvarchar](8) NOT NULL,
	[PersianDayNumberOfMonth] [tinyint] NOT NULL,
	[PersianMonthName] [nvarchar](8) NOT NULL,
	[PersianMonthNumberOfYear] [tinyint] NOT NULL,
	[PersianYear] [smallint] NOT NULL,
	[id] [int] IDENTITY(1,1) NOT NULL,
	[quarter] [int] NULL,
	[PersianWeekNumberOfYear] [smallint] NULL,
	[isToday] [tinyint] NOT NULL,
	[dateDescription] [nvarchar](20) NOT NULL,
	[Pastdate] [tinyint] NOT NULL,
	[dimDateTypeID] [int] NOT NULL,
	[persianSeasonName] [varchar](64) NOT NULL,
	[weekNumberInMonth] [tinyint] NULL,
	[WeekNumberINYear] [tinyint] NULL,
 CONSTRAINT [PK_dimDate] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[dimDate] ADD  CONSTRAINT [DF__dimDate__persian__5944012E]  DEFAULT ('') FOR [persianSeasonName]
GO


--GO
--exec spPopulatePersianDateDimension '2010-01-01','2025-01-01'
GO
--select * from dimdate order by datekey desc
--delete from dimdate
DECLARE @Result varchar(8000)
DECLARE cur CURSOR
READ_ONLY
FOR  SELECT id,PersianDayNameOfWeek ,DateKey   FROM dimDate 
	declare @ID int
	declare @date int
	declare @weekNum int
	declare @weekNumInYear int
	DECLARE @name varchar(250)
	declare @monthPart int =0
	declare @YearPart int =0
	set @Result = ''
	OPEN cur
	
	FETCH NEXT FROM cur INTO @ID,@name,@date
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
			if @name = '‘‰»Â' 
				begin
					set @weekNum = @weekNum+1 
					set @weekNumInYear = @weekNumInYear + 1
				end
			if @YearPart<>cast(left(@date,4) as int)
				begin
					set @YearPart=cast(left(@date,4) as int)				
					set @weekNumInYear = 1
				end

			if @monthPart<>cast(left(@date,6) as int)
				begin
					set @monthPart=cast(left(@date,6) as int)				
					set @weekNum = 1
				end
			update dimDate  set WeekNumberINmonth = @weekNum,WeekNumberINYear =@weekNumInYear  where id = @ID
		FETCH NEXT FROM cur INTO @ID,@name,@date
	END
	
	CLOSE cur
	DEALLOCATE cur
select * from dimdate 


