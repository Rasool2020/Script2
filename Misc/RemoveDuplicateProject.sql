While exists(Select top 1 t08ProjectID*10000+previousID
	From t08Projecthistory
	Where not ID in (Select t08ProjectHistoryID From t08ProjectHistoryOperation)
	And not ID in (Select t08ProjectHistoryID From t08ProjectHistoryOperation)
	Group by t08ProjectID,previousID
	Having count(*)>1)
Delete t08Projecthistory
Where t08ProjectID*10000+previousID in 
	(--Select max(id),t08ProjectID,previousID
	Select top 25 t08ProjectID*10000+previousID
	From t08Projecthistory
	Group by t08ProjectID,previousID
	Having count(*)>1)
	and not ID in 
	(Select max(id)
	From t08Projecthistory
	Group by t08ProjectID,previousID
	Having count(*)>1)
	And not ID in (Select t08ProjectHistoryID From t08ProjectHistoryOperation)
Go
Exec sp08RepairProject
Go
