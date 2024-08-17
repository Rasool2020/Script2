Select top 110 DATEDIFF(minute,CreationDate, GETDATE()), * from [dbo].[Exceptions]
--Delete [dbo].[Exceptions]
where 1=1
	And (url like '%hotel%' OR (url like '%search%' and id%5<>1))
	And DATEDIFF(minute,CreationDate, GETDATE())<=600
order by CreationDate desc
Go
Delete [dbo].[Exceptions]
where 1=1
	And (url like '%hotel%' OR url like '%search%')
	And DATEDIFF(minute,CreationDate, GETDATE())<=430
	and id%3=1
Waitfor delay '00:00:02'
Go 11000