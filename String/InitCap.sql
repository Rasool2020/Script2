CREATE Or Alter FUNCTION dbo.InitCap(@v AS NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
Begin
	Declare @ResultString NVARCHAR(MAX)

	if (@v='')
		Return ''

	Select @ResultString = STRING_AGG(v, ' ')
	From (Select UPPER(LEFT(value, 1)) + SubString(value, 2, len(value)) v
		From string_split(@v, ' ')) t

	RETURN @ResultString
End
Go
Select dbo.InitCap('rasool aghajani is very talented developer!')
