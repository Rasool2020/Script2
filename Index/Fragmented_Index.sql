SELECT OBJECT_Schema_name(ind.OBJECT_ID) SchemaName, OBJECT_NAME(ind.OBJECT_ID) AS TableName, 
Replace(ind.name,'dbo.', '') AS IndexName, indexstats.index_type_desc AS IndexType, 
indexstats.avg_fragmentation_in_percent ,
'Alter Index [' + ind.name + '] on ' + OBJECT_SCHEMA_NAME(ind.OBJECT_ID) + '.' + OBJECT_NAME(ind.OBJECT_ID) + ' Rebuild WITH(ONLINE=ON,SORT_IN_TEMPDB=ON)'
FROM sys.dm_db_index_physical_stats(DB_ID(), NULL, NULL, NULL, NULL) indexstats
INNER JOIN sys.indexes ind  with(nolock) ON ind.object_id = indexstats.object_id 
AND ind.index_id = indexstats.index_id 
WHERE 1=1
	And indexstats.avg_fragmentation_in_percent > 30 
	And ind.name is not null
	--And OBJECT_NAME(ind.OBJECT_ID) ='TbHotelHotelFacility'
	--And OBJECT_NAME(ind.OBJECT_ID) ='t08projectHistory'
ORDER BY indexstats.avg_fragmentation_in_percent DESC
Go
Alter Index [IX_HotelRef] on hotel.TbHotelHotelFacility Rebuild WITH(ONLINE=ON,SORT_IN_TEMPDB=ON)
Go
Select count(*) from tourismService.TbTravelServiceItem
Go

