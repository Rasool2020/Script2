--------------------------------------------------------------------
/*
SQL Server 2017 در High Availability دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
--بررسی زمان تخمینی برای 
--چه زمانی از این حالت استفاده کنیم
USE master
GO
SELECT
	r.session_id,
	CONVERT(NVARCHAR(255),DB_NAME(r.database_id)) AS [DATABASE],
	a.text AS Query,
	CASE r.command
	WHEN 'BACKUP DATABASE' THEN 'Database Backup'
	WHEN 'RESTORE DATABASE' THEN 'Database Restore'
	WHEN 'RESTORE VERIFYON' THEN 'Database Restore Verification'
	WHEN 'RESTORE HEADERON' THEN 'Database Restore Verification - Header'
	ELSE 'LOG' END AS [type],
	start_time AS [started],
	DATEADD(SECOND,estimated_completion_time/1000,GETDATE()) AS [Est. COMPLETION TIME],
	DATEDIFF(SECOND, start_time, (DATEADD(SECOND,estimated_completion_time/1000,GETDATE()))) - wait_time/1000 AS [Seconds LEFT],
	DATEDIFF(SECOND, start_time, (DATEADD(SECOND,estimated_completion_time/1000,GETDATE()))) AS [Est. Wait TIME() Seconds],
	CONVERT(VARCHAR(5),CAST((percent_complete) AS DECIMAL (4,1))) AS [% Complete],
	GETDATE() AS [CURRENT TIME]
FROM sys.dm_exec_requests r
	CROSS APPLY sys.dm_exec_sql_text(r.sql_handle) a
WHERE 
	COMMAND IN 
		(
			'BACKUP DATABASE','BACKUP LOG',
			'RESTORE DATABASE','RESTORE VERIFYON',
			'RESTORE HEADERON'
		)
GO
--------------------------------------------------------------------
--در شبکه بکاپ بگیریم Northwind از بانک اطلاعاتی  
/*
Workgroup Model
Domain Model
*/


BACKUP DATABASE NORTHWIND 
	TO DISK ='\\192.168.1.36\Share\NORTHWIND.bak'
WITH COMPRESSION,STATS=1


--NT Service\MSSQL$SQLSERVER2017