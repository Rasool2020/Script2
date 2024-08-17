CREATE OR ALTER FUNCTION [dbo].[fn_DistinctStringAgg]
(
  @String NVARCHAR(MAX),
  @Delimiter NVARCHAR(5)
)
RETURNS NVARCHAR(MAX)
WITH SCHEMABINDING
AS
BEGIN
  DECLARE @Result NVARCHAR(MAX)

  if (@String='')
	Return ''

  ;WITH MY_CTE AS (SELECT Distinct(Value) FROM STRING_SPLIT(@String, @Delimiter))
  SELECT @Result = STRING_AGG(Value, @Delimiter) FROM MY_CTE
  RETURN @Result
END