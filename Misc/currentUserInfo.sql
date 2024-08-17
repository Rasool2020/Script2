if (OBJECT_ID('tempdb..#currentUserInfo') is null)
Create Table #currentUserInfo(userID int,user_code int,changeByUser bit,stationID int,updateMode int,enteranceID int)
Go
Delete #currentUserInfo
insert #currentUserInfo(userID,user_code,changeByUser,stationID,updateMode,enteranceID)
Select top 1 1,1,1,1,1,id from t00EnteranceLog
if not exists(Select * from #currentUserInfo)
insert #currentUserInfo(userID,user_code,changeByUser,stationID,updateMode,enteranceID)
Values(1,1,1,1,1,-1)
Go
if not exists(Select 1 From t00ProcessActiveBranch where spID=@@spID)
insert t00ProcessActiveBranch(spid,branchID,userID,enteranceID,Web,registerDate,user_code,changeByUser,stationID,updateMode)
Select top 1 @@spID,0,t00UserID,id,1,getDate(),1,1,-1,1 From t00EnteranceLog
Go
