Create Or Alter PROCEDURE [dbo].[Sp_ReindexDB](@dbName NVARCHAR(100))
AS
Begin
	DECLARE @TableName NVARCHAR(500);
	DECLARE @SQLIndex NVARCHAR(MAX);
	DECLARE @RowCount INT;
	DECLARE @Counter INT;

	SET NOCOUNT ON
	DECLARE @IndexAnalysis TABLE
	(
		AnalysisID INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
		TableName NVARCHAR(256),
		SQLText NVARCHAR(2048),
		IndexDepth INT,
		AvgFragmentationInPercent FLOAT,
		FragmentCount BIGINT,
		AvgFragmentSizeInPages FLOAT,
		PageCount BIGINT
	);

	BEGIN
		INSERT INTO @IndexAnalysis
		SELECT [objects].name,
			   'ALTER INDEX [' + [indexes].name + '] ON [' + [schemas].name + '].[' + [objects].name + '] '
			   + (CASE
					  WHEN
					  (
						  [dm_db_index_physical_stats].avg_fragmentation_in_percent >= 10
						  AND [dm_db_index_physical_stats].avg_fragmentation_in_percent < 30
					  ) THEN
						  'REORGANIZE'
					  WHEN [dm_db_index_physical_stats].avg_fragmentation_in_percent >= 30 THEN
						  'REBUILD'
				  END +  ' With(ONLINE=ON, SORT_IN_TEMPDB=ON)'
				 ) AS zSQL,
			   [dm_db_index_physical_stats].index_depth,
			   [dm_db_index_physical_stats].avg_fragmentation_in_percent,
			   [dm_db_index_physical_stats].fragment_count,
			   [dm_db_index_physical_stats].avg_fragment_size_in_pages,
			   [dm_db_index_physical_stats].page_count
		FROM [sys].[dm_db_index_physical_stats](DB_ID(@dbName), NULL, NULL, NULL, 'LIMITED') AS [dm_db_index_physical_stats]
			INNER JOIN [sys].[objects] AS [objects]
				ON ([dm_db_index_physical_stats].[object_id] = [objects].[object_id])
			INNER JOIN [sys].[schemas] AS [schemas]
				ON ([objects].[schema_id] = [schemas].[schema_id])
			INNER JOIN [sys].[indexes] AS [indexes]
				ON (
					   [dm_db_index_physical_stats].[object_id] = [indexes].[object_id]
					   AND [dm_db_index_physical_stats].index_id = [indexes].index_id
				   )
		WHERE index_type_desc <> 'HEAP'
			  AND [dm_db_index_physical_stats].avg_fragmentation_in_percent > 30;
	END;

	SELECT @RowCount = COUNT(AnalysisID)
	FROM @IndexAnalysis;

	SET @Counter = 1;
	WHILE @Counter <= @RowCount
	BEGIN

		SELECT @SQLIndex = SQLText
		FROM @IndexAnalysis
		WHERE AnalysisID = @Counter;

		BEGIN TRY

			EXECUTE sp_executesql @SQLIndex;
			--Print @SQLIndex
			WAITFOR DELAY '00:00:02';
		END TRY
		BEGIN CATCH
		--DECLARE @ErrorMessage NVARCHAR(4000);
		--DECLARE @ErrorSeverity INT;
		--DECLARE @ErrorState INT;

		--SELECT @ErrorMessage = 'UNABLE TO CLEAN UP INDEX WITH: ' + @SQLIndex + ': MESSAGE GIVEN: ' + ERROR_MESSAGE()
		--	,@ErrorSeverity = 9 
		--	,@ErrorState = ERROR_STATE();
		END CATCH;

		SET @Counter = @Counter + 1;
	END;
End
