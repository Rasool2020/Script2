--	ForeignKey Index
Select o.name TableName,c.Name columnName,'if Not Exists(Select * From sysindexes Where name=''IX_' + o.name + '_' + c.Name + ''') CREATE NONCLUSTERED INDEX IX_' + o.name + '_' + c.Name + ' ON ' + o.name + '(' + c.Name + ') ON Index1'
From syscolumns c
Inner join sysobjects o on c.id=o.id
Where c.name like '%id' and c.name<>'id' And o.xType='U' 
	and o.name like '%order%' --and o.name like 't33%' 
	and not o.name like '%sett%'
	And c.name <> 'insertUserID'
	And not c.name like '%Repair%'
	And not c.name like '%GUID%'
	And not c.name like '%ActionID%'
	And not c.name like '%DBID%'
	And not c.name like '%enterance%'
 And not c.colid in (Select k.colid From sysindexes i join sysindexkeys k on i.id=k.id Where i.id=o.id and k.colid=c.colid)
Order By o.name,c.colid
Go
--	Unique Index
Select o.name TableName,c.Name columnName,'if Not Exists(Select * From sysindexes Where name=''IX_' + o.name + '_' + c.Name + ''') CREATE UNIQUE NONCLUSTERED INDEX IX_' + o.name + '_' + c.Name + ' ON ' + o.name + '(' + c.Name + ') ON Index1'
From syscolumns c
Inner join sysobjects o on c.id=o.id
Where c.name like '%name' and c.name<>'id' And o.xType='U' 
	--and o.name like '%order%' --and o.name like 't33%' 
	and not o.name like '%sett%'
	And c.name <> 'insertUserID'
	And not c.name like '%Repair%'
	And not c.name like '%GUID%'
	And not c.name like '%ActionID%'
	And not c.name like '%DBID%'
	And not c.name like '%enterance%'
 And not c.colid in (Select k.colid From sysindexes i join sysindexkeys k on i.id=k.id Where i.id=o.id and k.colid=c.colid)
Order By o.name,c.colid
Go
--	Unique Index
Select o.name TableName,c.Name columnName,'if Not Exists(Select * From sysindexes Where name=''IX_' + o.name + '_' + c.Name + ''') CREATE UNIQUE NONCLUSTERED INDEX IX_' + o.name + '_' + c.Name + ' ON ' + o.name + '(' + c.Name + ') ON Index1'
From syscolumns c
Inner join sysobjects o on c.id=o.id
Where c.name like '%Code%' and c.name<>'id' And o.xType='U' 
	--and o.name like '%order%' --and o.name like 't33%' 
	and not o.name like '%sett%'
	And c.name <> 'insertUserID'
	And not c.name like '%Repair%'
	And not c.name like '%GUID%'
	And not c.name like '%ActionID%'
	And not c.name like '%DBID%'
	And not c.name like '%enterance%'
 And not c.colid in (Select k.colid From sysindexes i join sysindexkeys k on i.id=k.id Where i.id=o.id and k.colid=c.colid)
Order By o.name,c.colid
