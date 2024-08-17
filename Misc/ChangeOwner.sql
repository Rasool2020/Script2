if exists (select * from sysobjects where id = object_id(N'[dbo].[chObjOwner]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[chObjOwner]
GO

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

CREATE proc chObjOwner( @usrName varchar(20), @newUsrName varchar(50))
as
-- @usrName is the current user
-- @newUsrName is the new user

set nocount on
declare @uid int                   -- UID of the user
declare @objName varchar(50)       -- Object name owned by user
declare @currObjName varchar(50)   -- Checks for existing object owned by new user 
declare @outStr varchar(256)       -- SQL command with 'sp_changeobjectowner'
set @uid = user_id(@usrName)

declare chObjOwnerCur cursor static
for
select name from sysobjects where uid = @uid

open chObjOwnerCur
if @@cursor_rows = 0
begin
  print 'Error: No objects owned by ' + @usrName
  close chObjOwnerCur
  deallocate chObjOwnerCur
  return 1
end

fetch next from chObjOwnerCur into @objName

while @@fetch_status = 0
begin
  set @currObjName = @newUsrName + "." + @objName
  if (object_id(@currObjName) > 0)
    print 'WARNING *** ' + @currObjName + ' already exists ***'
  set @outStr = "sp_changeobjectowner '" + @usrName + "." + @objName + "','" + @newUsrName + "'"
  print @outStr
  print 'go'
  fetch next from chObjOwnerCur into @objName
end

close chObjOwnerCur
deallocate chObjOwnerCur
set nocount off
return 0


GO
SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO
exec chObjOwner 'sarafi','dbo'