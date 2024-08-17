DROP TABLE If Exists #IndexRebuild
Go
CREATE TABLE #IndexRebuild
(
 DatabaseName SYSNAME,
 SchemaName SYSNAME,
 TableName SYSNAME,
 IndexName SYSNAME,
 [Fragmentation%] FLOAT
)
INSERT INTO #IndexRebuild
SELECT
 DB_NAME(DB_ID()) AS DatabaseName,
 ss.name AS SchemaName,
 OBJECT_NAME (s.object_id) AS TableName,
 i.name AS IndexName,
 s.avg_fragmentation_in_percent AS [Fragmentation%]
FROM sys.dm_db_index_physical_stats(db_id(),NULL, NULL, NULL, 'SAMPLED') s
INNER JOIN sys.indexes i ON s.[object_id] = i.[object_id]
AND s.index_id = i.index_id
INNER JOIN sys.objects o ON s.object_id = o.object_id
INNER JOIN sys.schemas ss ON ss.[schema_id] = o.[schema_id]
WHERE s.database_id = DB_ID()
	AND i.index_id != 0
	AND s.record_count > 0
	AND o.is_ms_shipped = 0
	AND s.avg_fragmentation_in_percent > 10
	AND OBJECT_NAME (s.object_id) like '%aspnet%'
	And not s.object_id in (SELECT c.OBJECT_ID TableName
		FROM sys.columns AS c
		JOIN sys.types AS t ON c.user_type_id=t.user_type_id
		WHERE t.name = 'text'  or t.name = 'image')
DECLARE @RebuildSQL NVARCHAR(MAX)
SET @RebuildSQL = ''
SELECT
 @RebuildSQL = @RebuildSQL +
CASE
 WHEN [Fragmentation%] > 20
   THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
      + QUOTENAME(SchemaName) + '.'
      + QUOTENAME(TableName) + ' REBUILD with(online=on);'
 WHEN [Fragmentation%] > 5
    THEN CHAR(10) + 'ALTER INDEX ' + QUOTENAME(IndexName) + ' ON '
    + QUOTENAME(SchemaName) + '.'
    + QUOTENAME(TableName) + ' REORGANIZE;'
END
FROM #IndexRebuild
WHERE [Fragmentation%] > 5
DECLARE @StartOffset INT
DECLARE @Length INT
SET @StartOffset = 0
SET @Length = 4000
WHILE (@StartOffset < LEN(@RebuildSQL))
BEGIN
 PRINT SUBSTRING(@RebuildSQL, @StartOffset, @Length)
 SET @StartOffset = @StartOffset + @Length
END
PRINT SUBSTRING(@RebuildSQL, @StartOffset, @Length)
--EXECUTE sp_executesql @RebuildSQL
DROP TABLE #IndexRebuild
go




