Select 'GRANT EXECUTE ON [' + OBJECT_SCHEMA_NAME(OBJECT_ID) + '].[' + name + '] TO [ReadOnlyUser]'
From sys.procedures
Where name like '%Sp_showHideContract%'
And OBJECT_SCHEMA_NAME(OBJECT_ID) = 'dbo'
Go
Select 'DENY INSERT, UPDATE, DELETE ON [' + OBJECT_SCHEMA_NAME(OBJECT_ID) + '].[' + name + '] TO [ReadOnlyUser2]'
From sys.tables
Where OBJECT_SCHEMA_NAME(OBJECT_ID) = 'dbo'
	And name like '%TbSaleContractHdr%'
Go
Select Distinct 'Deny EXECUTE ON [' + OBJECT_SCHEMA_NAME(OBJECT_ID) + '].[' + name + '] TO [ReadOnlyUser]'
from syscomments c
join sys.procedures p 
	ON p.object_id = c.id
Where 1=1
	--and text like '%Insert%'
	--or text like '%update%'
	--or text like '%delete%'
	and p.name like '%add%'
And OBJECT_SCHEMA_NAME(p.OBJECT_ID) = 'dbo'