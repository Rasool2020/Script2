Select f.name
  , parentTable = o.name
  , parentColumn = c.name
  , foreignTable = ofr.name
  , foreignColumn = cfr.name
  , script = 'ALTER TABLE [dbo].[' + o.name + '] DROP CONSTRAINT [' + f.name + ']'
From sys.foreign_keys f
Join sys.foreign_key_columns fc on f.object_id = fc.constraint_object_id
Join sys.objects o on fc.parent_object_id = o.object_id
Join sys.columns c on fc.parent_column_id = c.column_id	And o.object_id = c.object_id
Join sys.objects ofr on fc.referenced_object_id = ofr.object_id
Join sys.columns cfr on fc.referenced_column_id = cfr.column_id	And ofr.object_id = cfr.object_id
Join sys.indexes i on ofr.object_id = i.object_id
Where i.name = 'IX_detailfactor_back'
Go
--DROP INDEX if Exists [IX_detailfactor] ON [dbo].[detailfactor]