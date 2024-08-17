Declare @StrSQL as NVARCHAR(MAX)

While Exists(Select top 1 1
	From sys.columns c
	Join sys.objects o
		ON o.object_id = c.object_id
	Join sys.schemas s
		ON o.schema_id = s.schema_id
	Where OBJECT_SCHEMA_NAME(c.object_id)<>'sys'
		And c.name in ('CreateTime', 'UpdateTime')
		And c.system_type_id = 41
		And c.scale<>0
		)
Begin
	Select Top 1 @StrSQL = 'Alter Table ' + s.name + '.' + o.name
		+ ' Alter Column ' + c.name + ' '
		+ 'Time(0) '
		+ Case c.is_nullable When 1 Then 'Null' Else 'Not Null ' End
	From sys.columns c
	Join sys.objects o
		ON o.object_id = c.object_id
	Join sys.schemas s
		ON o.schema_id = s.schema_id
	Where OBJECT_SCHEMA_NAME(c.object_id)<>'sys'
		And c.name in ('CreateTime', 'UpdateTime')
		And c.system_type_id = 41
		And c.scale<>0
	Print @StrSQL
	Exec sp_executesql @StrSQL
End
Go
