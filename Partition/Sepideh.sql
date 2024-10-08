--����� ���� ���� ���� �� ����� ���� ���� �� ���� ��������
ALTER DATABASE SepidehTest ADD FILEGROUP FG2018
ALTER DATABASE SepidehTest ADD FILEGROUP FG2019
ALTER DATABASE SepidehTest ADD FILEGROUP FG2020
ALTER DATABASE SepidehTest ADD FILEGROUP FG2021
ALTER DATABASE SepidehTest ADD FILEGROUP FG2022
ALTER DATABASE SepidehTest ADD FILEGROUP FG2023
ALTER DATABASE SepidehTest ADD FILEGROUP FG2024
GO
Sp_helpfile
Go
ALTER DATABASE SepidehTest
	ADD FILE (NAME=Data2018,FILENAME='K:\Site2019\SepidehTest\SepidehFG2018.ndf' , SIZE = 524288KB , FILEGROWTH = 524288KB) TO FILEGROUP FG2018
GO
ALTER DATABASE SepidehTest
	ADD FILE (NAME=Data2019,FILENAME='K:\Site2019\SepidehTest\SepidehFG2019.ndf' , SIZE = 524288KB , FILEGROWTH = 524288KB) TO FILEGROUP FG2019
GO
ALTER DATABASE SepidehTest
	ADD FILE (NAME=Data2020,FILENAME='K:\Site2019\SepidehTest\SepidehFG2020.ndf' , SIZE = 524288KB , FILEGROWTH = 524288KB) TO FILEGROUP FG2020
GO
ALTER DATABASE SepidehTest
	ADD FILE (NAME=Data2021,FILENAME='K:\Site2019\SepidehTest\SepidehFG2021.ndf' , SIZE = 524288KB , FILEGROWTH = 524288KB) TO FILEGROUP FG2021
GO
ALTER DATABASE SepidehTest
	ADD FILE (NAME=Data2022,FILENAME='K:\Site2019\SepidehTest\SepidehFG2022.ndf' , SIZE = 524288KB , FILEGROWTH = 524288KB) TO FILEGROUP FG2022
GO
ALTER DATABASE SepidehTest
	ADD FILE (NAME=Data2023,FILENAME='K:\Site2019\SepidehTest\SepidehFG2023.ndf' , SIZE = 524288KB , FILEGROWTH = 524288KB) TO FILEGROUP FG2023
GO
ALTER DATABASE SepidehTest
	ADD FILE (NAME=Data2024,FILENAME='K:\Site2019\SepidehTest\SepidehFG2024.ndf' , SIZE = 524288KB , FILEGROWTH = 524288KB) TO FILEGROUP FG2024
GO
-------------
SP_HELPFILEGROUP

CREATE PARTITION FUNCTION PFDate (DATETIME)
AS RANGE RIGHT
FOR VALUES('20180101 00:00:00:000','20190101 00:00:00:000',
		   '20200101 00:00:00:000','20210101 00:00:00:000',
		   '20220101 00:00:00:000','20230101 00:00:00:000'
		  )


CREATE PARTITION SCHEME PSDate AS PARTITION PFDate
	TO (FG2018,FG2019,FG2020,FG2021,FG2022,FG2023,FG2024)
GO	

DROP TABLE IF EXISTS t00Ringlog2

SELECT * INTO t00Ringlog2 FROM t00Ringlog

--ALTER TABLE FactInternetSales2 ADD FactInternetSaleKey INT IDENTITY(1,1)

SELECT top 100 * FROM t00Ringlog2
--ALTER TABLE t00Ringlog2 ADD CONSTRAINT PK_t00Ringlog2 PRIMARY KEY NONCLUSTERED(ID ,registerdate) 
Go
SP_HELPINDEX t00Ringlog2
Go
CREATE UNIQUE CLUSTERED INDEX IX_t00Ringlog2_registerdate ON t00Ringlog2(ID ,registerdate)
ON PSDate(registerdate)

SELECT * FROM SYS.dm_db_index_physical_stats(DB_ID(),OBJECT_ID('t00Ringlog2'),1,NULL,'Detailed')
Go
SELECT ID
FROM dbo.t00RingLog
WHERE
    CID = '9368862168' AND
    DID = '54617000' AND
	registerdate>='2017/03/02 00:00:00'
Go
SELECT ID,CID,DID,registerdate
FROM dbo.t00Ringlog2
WHERE
    CID = '9368862168' AND
    DID = '54617000' AND
	registerdate>='2017/03/02 00:00:00'
Go
DBCC SHOW_STATISTICS('t00Ringlog2','IX_t00Ringlog2_registerdate') with histogram
Go
ALTER INDEX IX_t00Ringlog2_registerdate ON t00Ringlog2 REBUILD
	WITH (STATISTICS_INCREMENTAL = ON)
Go
CREATE INDEX IX_t00Ringlog2_registerdate2
ON [dbo].[t00Ringlog2] ([registerdate],[CID],[DID])
ON PSDate(registerdate)
/*
P1 : 1752-01-01   TO 2010-12-31
P2 : 2011-01-01 TO 2011-12-31
....
....
*/


SELECT 
	$PARTITION.PFDate(registerdate) AS [Partition Number]
	, MIN(registerdate) AS [Min ORDERDATE]
	, MAX(registerdate) AS [Max ORDERDATE]
	, COUNT(registerdate) AS [Rows In Partition]
FROM t00ringlog2
GROUP BY 
	$PARTITION.PFDate(registerdate)
ORDER BY 
	[Partition Number]
GO
