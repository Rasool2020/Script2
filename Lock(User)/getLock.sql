DECLARE @result int;
EXEC @result=sp_getapplock
    @DbPrincipal='public',
    @Resource='Form2',
    @LockMode='Shared',
    @LockOwner='Transaction';
Go
DECLARE @result int;
EXEC @result=sp_getapplock
    @DbPrincipal='public',
    @Resource='Form2',
    @LockMode='Exclusive',
    @LockOwner='Transaction';
Print @result
Go
Declare @LockType NVARCHAR(MAX)
SELECT @LockType=APPLOCK_MODE('public', 'Form2', 'Transaction');
Select @LockType
GO
EXEC sp_releaseapplock @Resource='Form2', @DbPrincipal='public';