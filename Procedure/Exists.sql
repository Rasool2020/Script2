select Distinct 'sp_helptext ''' + Quotename(OBJECT_SCHEMA_NAME(id)) + '.' +  Quotename(object_name(id)) + ''''
from syscomments
where text like '%exists (SELECT *%'
Go
sp_helptext '[Utility].[Sp_GetUserReviews]'