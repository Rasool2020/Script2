SELECT OBJECT_SCHEMA_NAME(IX.OBJECT_ID) + '.' + OBJECT_NAME(IX.OBJECT_ID) Table_Name
	   ,IX.name AS Index_Name
	   ,IX.type_desc Index_Type
	   ,SUM(PS.[used_page_count]) * 8 IndexSizeKB
	   ,IXUS.user_seeks AS NumOfSeeks
	   ,IXUS.user_scans AS NumOfScans
	   ,IXUS.user_seeks + IXUS.user_scans AS TotalSeeks_Scans
	   ,IXUS.user_lookups AS NumOfLookups
	   ,IXUS.user_updates AS NumOfUpdates
	   ,IXUS.last_user_seek AS LastSeek
	   ,IXUS.last_user_scan AS LastScan
	   ,IXUS.last_user_lookup AS LastLookup
	   ,IXUS.last_user_update AS LastUpdate
	   ,'DROP INDEX ' + IX.name
		+ ' ON ' + OBJECT_SCHEMA_NAME(IX.OBJECT_ID) + '.'
		+ QUOTENAME(OBJECT_NAME(IX.OBJECT_ID)) AS 'Drop Statement'
FROM sys.indexes IX
JOIN sys.dm_db_index_usage_stats IXUS ON IXUS.index_id = IX.index_id AND IXUS.OBJECT_ID = IX.OBJECT_ID
JOIN sys.dm_db_partition_stats PS on PS.object_id=IX.object_id
WHERE 1=1 And IX.is_primary_key = 0
	--And OBJECT_NAME(IX.OBJECT_ID)='TbFlightMinimumPriceCalendar'
GROUP BY OBJECT_NAME(IX.OBJECT_ID) ,IX.name ,IX.type_desc ,IXUS.user_seeks ,IXUS.user_scans ,IXUS.user_lookups,IXUS.user_updates ,IXUS.last_user_seek ,IXUS.last_user_scan ,IXUS.last_user_lookup ,IXUS.last_user_update, OBJECT_SCHEMA_NAME(IX.OBJECT_ID)
--Having SUM(PS.[used_page_count])>20000
--Order By IXUS.user_lookups Desc
--Order By IXUS.user_seeks + IXUS.user_scans, IXUS.user_updates Desc
Order By IXUS.user_updates/(IXUS.user_seeks + IXUS.user_scans + 0.1) desc
Go

SELECT OBJECT_NAME(IXOS.OBJECT_ID)  Table_Name 
       ,IX.name  Index_Name
	   ,IX.type_desc Index_Type
	   ,SUM(PS.[used_page_count]) * 8 IndexSizeKB
       ,IXOS.LEAF_INSERT_COUNT NumOfInserts
       ,IXOS.LEAF_UPDATE_COUNT NumOfupdates
       ,IXOS.LEAF_DELETE_COUNT NumOfDeletes	   
FROM   SYS.DM_DB_INDEX_OPERATIONAL_STATS (NULL,NULL,NULL,NULL ) IXOS 
JOIN SYS.INDEXES AS IX ON IX.OBJECT_ID = IXOS.OBJECT_ID AND IX.INDEX_ID =    IXOS.INDEX_ID 
	 JOIN sys.dm_db_partition_stats PS on PS.object_id=IX.object_id
WHERE  OBJECTPROPERTY(IX.[OBJECT_ID],'IsUserTable') = 1 
	 And IX.is_primary_key = 0
	--And OBJECT_NAME(IXOS.OBJECT_ID)='tbflight'
GROUP BY OBJECT_NAME(IXOS.OBJECT_ID), IX.name, IX.type_desc,IXOS.LEAF_INSERT_COUNT, IXOS.LEAF_UPDATE_COUNT,IXOS.LEAF_DELETE_COUNT
Order By IXOS.LEAF_INSERT_COUNT +
       IXOS.LEAF_UPDATE_COUNT +
       IXOS.LEAF_DELETE_COUNT Desc
Go
