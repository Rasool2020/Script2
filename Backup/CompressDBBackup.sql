if (1=1)
Begin
	Declare @strSQL varchar(100)

	Set @strSQL = 'sys.sp_configure N''backup compression default'''
	--print  @strSQL
 	EXEC(@strSQL)
 	RECONFIGURE WITH OVERRIDE
End
Go
EXEC sys.sp_configure N'backup compression default', N'1'
RECONFIGURE WITH OVERRIDE