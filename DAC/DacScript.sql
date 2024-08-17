EXEC sp_configure 'remote admin connections', 1;
GO
RECONFIGURE
GO
Select *
From  sys.configurations
Where name='Remote admin connections'
Go
SELECT
CASE
WHEN ses.session_id= @@SPID THEN 'It''s me! '
ELSE '' END 
+ coalesce(ses.login_name,'???') as WhosGotTheDAC,
ses.session_id,
ses.login_time,
ses.status,
ses.original_login_name
From sys.endpoints as en
Join sys.dm_exec_sessions ses on
En.endpoint_id=ses.endpoint_id
Where en.name='Dedicated Admin Connection'
