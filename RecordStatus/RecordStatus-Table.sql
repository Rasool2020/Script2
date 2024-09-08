SELECT [ID_]
      ,[TITLE_]
      ,[ISACTIVE_]
      ,[ISFIXED_]
      ,[ISCONFIRMED_]
      ,[ISHIDDEN_]
      ,[DISPLAYABLE_]
  FROM [dbo].[TBL_RecordStatusType]
GO
Create or Alter Procedure USP_ActivateRecordStatusType(@NCol int, @colName VARCHAR(MAX))
As
Begin
	--SET NOCOUNT ON
	Declare @strSQL NVARCHAR(MAX)

	Set @strSQL = N'Update [TBL_RecordStatusType] Set ' + @colName + N'=1
		Where id_ & POWER(2, ' + Cast(@NCol as NVARCHAR(MAX)) + N')=POWER(2, ' + Cast(@NCol as NVARCHAR(MAX)) + N')';
	Exec sp_executesql @strSQL

	Set @strSQL = N'Update [TBL_RecordStatusType] Set ' + @colName + N'=0
		Where id_ & POWER(2, ' + Cast(@NCol as NVARCHAR(MAX)) + N')=0';
	Exec sp_executesql @strSQL
End
Go
Delete TBL_RecordStatusType
Set Identity_insert TBL_RecordStatusType ON 
Insert TBL_RecordStatusType(ID_, TITLE_)
Select value, ''
From generate_series(6, POWER(2, 4)-1)
Set Identity_insert TBL_RecordStatusType OFF
Go
Exec USP_ActivateRecordStatusType 0, 'ISACTIVE_'
Go
Exec USP_ActivateRecordStatusType 1, 'ISFIXED_'
Go
Exec USP_ActivateRecordStatusType 2, 'ISCONFIRMED_'
Go
Exec USP_ActivateRecordStatusType 3, 'ISHIDDEN_'
Go
Select *
From TBL_RecordStatusType
Go
Create OR Alter Function dbo.GetRecordStatusType(@StatusID tinyint)
Returns NVARCHAR(MAX) 
As
Begin
	Declare @ID tinyint
	Declare @statusName NVARCHAR(MAX) 

	Set @statusName = ''

	Set @ID = POWER(2, 0)
	if(@statusID & @ID=@ID)
		Set @statusName = N'فعال' 

	Set @ID = POWER(2, 1)
	if(@statusID & @ID=@ID)
	Begin
		if (Len(@statusName)>0)
			Set @statusName = @statusName + N', '
		
		Set @statusName = @statusName + N'ثابت'
	End

	Set @ID = POWER(2, 2)
	if(@statusID & @ID=@ID)
	Begin
		if (Len(@statusName)>0)
			Set @statusName = @statusName + N', '
		
		Set @statusName = @statusName + N'تایید شده'
	End

	Set @ID = POWER(2, 3)
	if(@statusID & @ID=@ID)
	Begin
		if (Len(@statusName)>0)
			Set @statusName = @statusName + N', '
		
		Set @statusName = @statusName + N'پنهان'
	End
	if(Len(@statusName)=0)
		Return N'غیر فعال'

	Return @statusName
End
Go
Select *--,dbo.GetRecordStatusType(id_)
From TBL_RecordStatusType
Go
Update TBL_RecordStatusType Set Title_=dbo.GetRecordStatusType(id_)
Go
--Delete TBL_RecordStatusType Where ID_>15