Drop TABLE [dbo].[DimTime]
Go
CREATE TABLE [dbo].[DimTime](
[FullTime] [TIME](0) Not NULL,
[TimeKey] [int] NOT NULL,
[Hour24] [TINYINT] Not NULL,
[Hour24ShortString] [CHAR](2) Not NULL,
[Hour24MinString] [CHAR](5) Not NULL,
[Hour24FullString] [CHAR](8) Not NULL,
[Hour12] [TINYINT] Not NULL,
[Hour12ShortString] [CHAR](2) Not NULL,
[Hour12MinString] [CHAR](5) Not NULL,
[Hour12FullString] [CHAR](8) Not NULL,
[AmPmCode] [TINYINT] Not NULL,
[AmPmString] [CHAR](2) NOT NULL,
[Minute] [TINYINT] Not NULL,
[MinuteCode] [SMALLINT] Not NULL,
[MinuteShortString] [CHAR](2) Not NULL,
[MinuteFullString24] [CHAR](8) Not NULL,
[MinuteFullString12] [CHAR](8) Not NULL,
[HalfHour] [TINYINT] Not NULL,
[HalfHourCode] [SMALLINT] Not NULL,
[HalfHourShortString] [CHAR](2) Not NULL,
[HalfHourFullString24] [CHAR](8) Not NULL,
[HalfHourFullString12] [CHAR](8) Not NULL,
[Second] [TINYINT] Not NULL,
[SecondShortString] [CHAR](2) Not NULL,
[FullTimeString24] [CHAR](8) Not NULL,
[FullTimeString12] [CHAR](8) Not NULL,
[TimeBucket1] [TIME](0) Not NULL,
[TimeBucket5] [TIME](0) Not NULL,
[TimeBucket15] [TIME](0) Not NULL,
[TimeBucket30] [TIME](0) Not NULL,
[TimeBucket60] [TIME](0) Not NULL
) ON [PRIMARY]
Go

DECLARE @HOUR INT
DECLARE @MINUTE INT
DECLARE @SECOND INT
DECLARE @pFullTime Time(0)

SET @HOUR=0

WHILE @HOUR < 24
  BEGIN
      SET @MINUTE=0

      WHILE @MINUTE < 60
        BEGIN
            SET @SECOND=0

            WHILE @SECOND < 60
              BEGIN
				  Set @pFullTime = CONVERT(TIME, RIGHT('0'+CONVERT(VARCHAR(2), @HOUR), 2)
                                       + ':'
                                       + RIGHT('0'+CONVERT(VARCHAR(2), @MINUTE),
                                       2
                                       )
                                       + ':'
                                       + RIGHT('0'+CONVERT(VARCHAR(2), @SECOND),
                                       2
                                       ))
                  INSERT INTO [dbo].[dimtime]
                              ([FullTime],
							   [timekey],
                               [hour24],
                               [hour24shortstring],
                               [hour24minstring],
                               [hour24fullstring],
                               [hour12],
                               [hour12shortstring],
                               [hour12minstring],
                               [hour12fullstring],
                               [ampmcode],
                               [ampmstring],
                               [minute],
                               [minutecode],
                               [minuteshortstring],
                               [minutefullstring24],
                               [minutefullstring12],
                               [halfhour],
                               [halfhourcode],
                               [halfhourshortstring],
                               [halfhourfullstring24],
                               [halfhourfullstring12],
                               [second],
                               [secondshortstring],
                               [fulltimestring24],
                               [fulltimestring12],
							   [TimeBucket1],
							   [TimeBucket5],
							   [TimeBucket15],
							   [TimeBucket30],
							   [TimeBucket60]
							   )
                  SELECT @pFullTime,
						 (@HOUR * 10000 ) + ( @MINUTE * 100 ) + @SECOND
                         AS
                         TimeKey,
                         @HOUR
                         AS
                         [Hour24],
                         RIGHT('0' + CONVERT(VARCHAR(2), @HOUR), 2)
                         [Hour24ShortString],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR), 2)
                         + ':00'
                         [Hour24MinString],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR), 2)
                         + ':00:00'
                         [Hour24FullString],
                         @HOUR%12
                         AS
                         [Hour12],
                         RIGHT('0' + CONVERT(VARCHAR(2), @HOUR%12), 2)
                         [Hour12ShortString],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR%12), 2)
                         + ':00'
                         [Hour12MinString],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR%12), 2)
                         + ':00:00'
                         [Hour12FullString],
                         @HOUR / 12
                         AS
                         [AmPmCode]
                         ,
                         CASE
                           WHEN @HOUR < 12 THEN 'AM'
                           ELSE 'PM'
                         END
                         AS
                         [AmPmString],
                         @MINUTE
                         AS
                         [Minute],
                         ( @HOUR * 100 ) + ( @MINUTE )
                         [MinuteCode],
                         RIGHT('0' + CONVERT(VARCHAR(2), @MINUTE), 2)
                         [MinuteShortString],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR), 2)
                         + ':'
                         + RIGHT('0'+CONVERT(VARCHAR(2), @MINUTE), 2)
                         + ':00'
                         [MinuteFullString24],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR%12), 2)
                         + ':'
                         + RIGHT('0'+CONVERT(VARCHAR(2), @MINUTE), 2)
                         + ':00'
                         [MinuteFullString12],
                         @MINUTE / 30
                         AS
                         [HalfHour]
                         ,
                         ( @HOUR * 100 ) + ( ( @MINUTE / 30 ) * 30 )
                         [HalfHourCode],
                         RIGHT('0'
                               + CONVERT(VARCHAR(2), ((@MINUTE/30)*30)), 2)
                         [HalfHourShortString],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR), 2)
                         + ':'
                         + RIGHT('0'+CONVERT(VARCHAR(2), ((@MINUTE/30)*30)), 2)
                         + ':00'
                         [HalfHourFullString24],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR%12), 2)
                         + ':'
                         + RIGHT('0'+CONVERT(VARCHAR(2), ((@MINUTE/30)*30)), 2)
                         + ':00'
                         [HalfHourFullString12],
                         @SECOND
                         AS
                         [Second],
                         RIGHT('0' + CONVERT(VARCHAR(2), @SECOND), 2)
                         [SecondShortString],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR), 2)
                         + ':'
                         + RIGHT('0'+CONVERT(VARCHAR(2), @MINUTE), 2)
                         + ':'
                         + RIGHT('0'+CONVERT(VARCHAR(2), @SECOND), 2)
                         [FullTimeString24],
                         RIGHT('0'+CONVERT(VARCHAR(2), @HOUR%12), 2)
                         + ':'
                         + RIGHT('0'+CONVERT(VARCHAR(2), @MINUTE), 2)
                         + ':'
                         + RIGHT('0'+CONVERT(VARCHAR(2), @SECOND), 2)
                         [FullTimeString12],
						 DATE_BUCKET(Minute, 1, @pFullTime) TimeBucket1,
						 DATE_BUCKET(Minute, 5, @pFullTime) TimeBucket5,
						 DATE_BUCKET(Minute, 15, @pFullTime) TimeBucket15,
						 DATE_BUCKET(Minute, 30, @pFullTime) TimeBucket30,
						 DATE_BUCKET(Minute, 60, @pFullTime) TimeBucket60

                  SET @SECOND=@SECOND + 1
              END

            SET @MINUTE=@MINUTE + 1
        END

      SET @HOUR=@HOUR + 1
  END
Go 
CREATE INDEX IX_DimTime_TimeBucket1
ON [dbo].[DimTime] ([TimeBucket5],[TimeBucket15],[TimeBucket30],[TimeBucket60])
INCLUDE ([FullTime],[TimeBucket1])
Go
CREATE CLUSTERED COLUMNSTORE INDEX [IXC_DimTime] ON [dbo].[DimTime] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
Go
Select * From [DimTime]
Order By FullTime
--Truncate Table [DimTime]
Go
