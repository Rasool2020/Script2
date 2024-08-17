sp_updatestats 
Go
--EXEC sp_MSForEachTable 'UPDATE STATISTICS ? WITH FULLSCAN;'
Go
Select *
From sys.tables
Where 1=1
	--and name like '%branch%'
	and is_memory_optimized=0
Go
Declare @TABLE_NAME varchar(64)
Declare @id int
DECLARE curConstraint CURSOR FOR
Select name, object_id
From sys.tables
Where 1=1
	--and name like '%branch%'
	and is_memory_optimized=0

OPEN curConstraint
FETCH NEXT From curConstraint into @TABLE_NAME, @id
WHILE @@Fetch_Status<>-1
BEGIN
 Print('UPDATE STATISTICS [' + object_schema_name(@id) + '].[' + @TABLE_NAME + '] WITH FULLSCAN;')
 Print('Print ''UPDATING ' + @TABLE_NAME + ' IS Done''')
 Print('Go')
 FETCH NEXT From curConstraint into @TABLE_NAME, @id
End
Close curConstraint
Deallocate curConstraint
Go