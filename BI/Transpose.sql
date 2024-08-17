/****** Object:  StoredProcedure [dbo].[SQLTranspose]    Script Date: 11/10/2015 7:08:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      Paco Zarate
-- Create date: 2015-11-10
-- Description: SQLTranspose dynamically changes a table to show rows as headers. It needs that all the values are numeric except for the field using for     transposing.
-- Parameters: @TableName - Table to transpose
--             @FieldNameTranspose - Column that will be the new headers
-- Usage: exec SQLTranspose <table>, <FieldToTranspose>
--        table and FIeldToTranspose should be written using single quotes
-- =============================================
Create Or ALTER PROCEDURE [dbo].[SQLTranspose] 
  -- Add the parameters for the stored procedure here
  @TableName NVarchar(MAX) = '', 
  @FieldNameTranspose NVarchar(MAX) = ''
AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with Select statements.
  SET NOCOUNT ON;

  DECLARE @colsUnpivot AS NVARCHAR(MAX),
  @query  AS NVARCHAR(MAX),
  @queryPivot  AS NVARCHAR(MAX),
  @colsPivot as  NVARCHAR(MAX),
  @columnToPivot as NVARCHAR(MAX),
  @tableToPivot as NVARCHAR(MAX), 
  @colsResult as xml

  Select @tableToPivot = @TableName;
  Select @columnToPivot = @FieldNameTranspose


  Select @colsUnpivot = Stuff((Select ','+quotename(C.name)
       From sys.columns as C
       Where C.object_id = object_id(@tableToPivot) and
             C.name <> @columnToPivot 
       for xml path('')), 1, 1, '')

  set @queryPivot = 'Select @colsResult = (Select  '','' 
                    + quotename('+@columnToPivot+')
                  From '+@tableToPivot+' t
                  Where '+@columnToPivot+' <> ''''
          FOR XML PATH(''''), TYPE)'

  --exec sp_executesql @queryPivot, N'@colsResult xml out', @colsResult out

  --Select @colsPivot = STUFF(@colsResult.value('.', 'NVARCHAR(MAX)'),1,1,'')

  --set @query 
  --  = 'Select name, rowid, '+@colsPivot+'
  --      From
  --      (
  --        Select '+@columnToPivot+' , name, value, ROW_NUMBER() over (partition by '+@columnToPivot+' order by '+@columnToPivot+') as rowid
  --        From '+@tableToPivot+'
  --        Unpivot
  --        (
  --          value for name in ('+@colsUnpivot+')
  --        ) unpiv
  --      ) src
  --      pivot
  --      (
  --        Sum(value)
  --        for '+@columnToPivot+' in ('+@colsPivot+')
  --      ) piv
  --      order by rowid'
  --exec(@query)
END
Go
Exec SQLTranspose 'TbSalesPrice', 'Single'