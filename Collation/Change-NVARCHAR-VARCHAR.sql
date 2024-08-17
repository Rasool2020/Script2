Use [BPMS]
Go
Select 
	'Alter Table [' + o.name + 
		'] Alter Column [' + c.name +
		'] VARCHAR(' + Case When c.max_length>=0 then Cast(c.max_length as varchar(MAX)) Else 'MAX' End + ')' +
		' Collate Persian_100_CI_AI ' + 
		Case When c.is_nullable = 1 Then 'Null' Else ' Not Null' End,
		c.system_type_id
From sys.columns c With(nolock)
Join sys.objects o With(nolock)
	ON o.object_id = c.object_id
Join sys.schemas s With(nolock)
	ON o.schema_id = s.schema_id
Where OBJECT_SCHEMA_NAME(c.object_id)<>'sys'
	--And o.name='business'
	--And c.system_type_id in (167, 175)
	--And c.collation_name<>@CollationName
	And c.column_id>1
	--And c.name = N'beneficiary_branch_name'
	And c.system_type_id in (231)
		--	167	=> VARCHAR
		--	231 => NVARCHAR
Go
