SELECT o.[name], o.[type], i.[name], i.[index_id], f.[name]
--i.data_space_id,'Select Count(*),''' + o.[name] + ''' From ' + o.[name]
FROM sys.indexes i
INNER JOIN sys.filegroups f
ON i.data_space_id = f.data_space_id
INNER JOIN sys.all_objects o
ON i.[object_id] = o.[object_id]
WHERE i.data_space_id = f.data_space_id
AND o.type = 'U' AND f.[name] = 'Storage3'
Order By 1

Select * From sys.objects
Select * From sysobjects
Select o.name,c.name,* 
From syscolumns c
inner join sysobjects o on c.id=o.id
Where c.xtype=34