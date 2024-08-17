Declare @ProjectTypeID int
Declare @ProjectName varchar(64)
Declare @ProjectCode varchar(32)
Declare @WorkFlowID int
Declare @SourceUserID int
Declare @DestinationUserID int
Declare @EntityTypeID int
Declare @EntityID int
Declare @stateID int

--sp00RegisterProcessActiveBranchTest 1
if not exists(Select * From t08ProjectType Where id=2)
Begin
	Set IDENTITY_INSERT t08ProjectType on
	Insert into t08ProjectType(id,name) Values(2,'—÷«Ì ')
	Set IDENTITY_INSERT t08ProjectType off
End

Set @ProjectTypeID = 1
Set @ProjectName = '»—œ«‘  ﬁ—‰ÌÂ'
Set @ProjectCode = 'BZ62378462405'
Set @WorkFlowID = 1007
Set @SourceUserID = 1
Set @DestinationUserID = 2
Set @EntityTypeID = 98
Set @EntityID = 6
Set @stateID = 2042
select * From t00
Exec sp00InsertProjectForEntity @ProjectTypeID,@ProjectName,@ProjectCode,@WorkFlowID,@SourceUserID,	@DestinationUserID,@EntityTypeID,@EntityID,@stateID
Go
select * From t08WorkFlowDetail 