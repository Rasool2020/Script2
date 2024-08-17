--ALTER DATABASE TicketNew  
--    COLLATE Persian_100_CI_AI ;  
--GO  
--ALTER DATABASE TicketNew SET MULTI_USER
--Go
--Declare @STRSQL as NVARCHAR(MAX)
--Declare @CollationName as VARCHAR(MAX)
--Set @CollationName = 'Persian_100_CI_AI'

--While Exists(Select 1 From sys.columns c
--	Where OBJECT_SCHEMA_NAME(c.object_id)<>'sys'
--		And c.system_type_id in (167, 175)
--		And c.collation_name<>@CollationName)
--Begin
	
--	Select Top 1 @STRSQL='Alter Table ' + s.name + '.' + o.name
--		+ ' Alter Column ' + c.name + ' '
--		+ Case c.system_type_id When 167 Then 'VARCHAR' Else 'CHAR' End +
--			'(' + Cast(c.max_length as VARCHAR(MAX)) + ') '
--		+ 'Collate ' + @CollationName + ' '
--		+ Case c.is_nullable When 1 Then 'Null ' Else 'Not Null ' End
--	From sys.columns c
--	Join sys.objects o
--		ON o.object_id = c.object_id
--	Join sys.schemas s
--		ON o.schema_id = s.schema_id
--	Where OBJECT_SCHEMA_NAME(c.object_id)<>'sys'
--		And c.system_type_id in (167, 175)
--		And c.collation_name<>@CollationName
--		And c.column_id>1
--	Print @STRSQL
--	--Execute sp_executesql @STRSQL
--End


--Go
Use Test

Declare @CollationName as VARCHAR(MAX)
Set @CollationName = 'Persian_100_CI_AI'

Select 'Alter Table ' + s.name + '.' + o.name
	+ ' Alter Column [' + c.name + '] '
	+ Case c.system_type_id When 167 Then 'VARCHAR' Else 'CHAR' End +
		'(' + Case When c.max_length>=0 then Cast(c.max_length as varchar(MAX)) Else 'MAX' End + ') '
	+ 'Collate ' + @CollationName + ' '
	+ Case c.is_nullable When 1 Then 'Null ' Else 'Not Null ' End STRSQL
From sys.columns c
Join sys.objects o
	ON o.object_id = c.object_id
Join sys.schemas s
	ON o.schema_id = s.schema_id
Where OBJECT_SCHEMA_NAME(c.object_id)<>'sys'
	And c.is_computed = 0	--	Not Computed
	And c.system_type_id in (167, 175)
	And c.collation_name<>@CollationName
	And c.column_id>1
	--And c.name='TEST3_'
Go

