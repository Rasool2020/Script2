Begin Tran
DECLARE @result int;
EXEC @result=sp_getapplock
    @DbPrincipal='public',
    @Resource='Form2',
    @LockMode='Shared',
    @LockOwner='Session';
Commit Tran
Go
DECLARE @result int;
EXEC @result=sp_getapplock
    @DbPrincipal='public',
    @Resource='Form2',
    @LockMode='Exclusive',
    @LockOwner='Session';
Print @result
Go
Declare @LockType NVARCHAR(MAX)
SELECT @LockType=APPLOCK_MODE('public', 'Form2', 'Session');
Select @LockType
GO
EXEC sp_releaseapplock @Resource='Form2', @DbPrincipal='public', @LockOwner='Session';

SELECT OBJECT_NAME(@@PROCID)

RollBack Tran
Select @@TRANCOUNT
Go


