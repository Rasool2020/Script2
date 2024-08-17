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
--اجرای دستی جاب ها
--------------------------------------------------------------------
Hide   Copy Code
--Run on principal
USE master
GO

ALTER DATABASE dbName SET SAFETY FULL
GO
ALTER DATABASE dbName SET PARTNER FAILOVER
GO
--Run on new principal
USE master
GO

ALTER DATABASE dbName SET SAFETY OFF
GO




Doing a Forced Failover using T-SQL

Hide   Copy Code
--Run on mirror if principal isn't available
USE
master
GO

ALTER DATABASE dbName SET PARTNER FORCE_SERVICE_ALLOW_DATA_LOSS
GO



<sessionState mode="SQLServer" allowCustomSqlDatabase="true"

   sqlConnectionString="data source=[PRINCIPALSERVER];
   failover partner=[MIRRORSERVER];initial catalog=ASPState;user id=[DBUSER];
   password=[DBPWD];network=dbmssocn;" cookieless="false" timeout="180" />



   
/*
*  Execute this against the Mirror Instance.
*/
ALTER DATABASE NikAmoozDB2017_Mirror
    SET PARTNER = 'TCP://DBServer1.NikAmoozFQDN.com:5022'
GO
/*
*  Execute this against the Principal Instance.
*/

ALTER DATABASE NikAmoozDB2017_Mirror
    SET PARTNER = 'TCP://DBServer2.NikAmoozFQDN.com:5022'
GO

ALTER DATABASE NikAmoozDB2017_Mirror
    SET WITNESS = 'TCP://MasoudTaheri.NikAmoozFQDN.com:5022'
GO

https://sqlserverperformance.wordpress.com/2009/03/01/scripts-for-database-mirroring-presentation-at-rocky-mountain-tech-trifecta/

ALTER DATABASE NikAmoozDB2017_Mirror SET PARTNER OFF  


/*

-- Check Mirroring Status
SELECT DB_NAME(database_id) AS 'database_name', mirroring_safety_level_desc, 
mirroring_witness_name, mirroring_witness_state_desc 
FROM sys.database_mirroring
WHERE database_id > 4

-- Check Mirroring Connections
SELECT *
FROM sys.dm_db_mirroring_connections

-- Manual Failover
-- Switch to current Principal instance  *************************
ALTER DATABASE AdventureWorks SET PARTNER FAILOVER; 


-- Automatic Failover
-- Stop SQL Server Service on Default Instance

-- Switch to current Principal instance (green) *************************
-- On Principal Instance, turn off Transaction Safety (Asynchronous Mode)
ALTER DATABASE AdventureWorks SET PARTNER SAFETY OFF

-- On Principal Instance, turn on Transaction Safety (Synchronous Mode)
ALTER DATABASE AdventureWorks SET PARTNER SAFETY FULL


-- Check Mirroring Status
SELECT DB_NAME(database_id) AS 'database_name', mirroring_safety_level_desc, 
mirroring_witness_name, mirroring_witness_state_desc 
FROM sys.database_mirroring
WHERE database_id > 4


-- On either partner, remove the Witness
ALTER DATABASE AdventureWorks SET WITNESS OFF


-- Add the Witness back
-- Switch to Witness instance (blue) *************************
-- On Witness instance, check to see if endpoint exists
SELECT role_desc, state_desc
FROM sys.database_mirroring_endpoints

-- Switch to Principal instance (green) *************************
ALTER DATABASE AdventureWorks SET WITNESS = 'TCP://techtrifecta:5024'
GO

USE AdventureWorks
GO

-- Get cached SPs by execution count (to look at workload)
SELECT TOP (10) qt.text AS 'SP Name', qs.execution_count AS 'Execution Count',  
qs.execution_count/DATEDIFF(Second, qs.creation_time, GetDate()) AS 'Calls/Second',
qs.total_worker_time/qs.execution_count AS 'AvgWorkerTime',
qs.total_worker_time AS 'TotalWorkerTime',
qs.total_elapsed_time/qs.execution_count AS 'AvgElapsedTime',
qs.max_logical_reads, qs.max_logical_writes, qs.total_physical_reads, 
DATEDIFF(Minute, qs.creation_time, GetDate()) AS 'Age in Cache'
FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
WHERE qt.dbid = db_id() -- Filter by current database
ORDER BY qs.execution_count DESC


-- Remove Mirroring *******
-- Switch to Principal instance (green) *************************
ALTER DATABASE AdventureWorks SET PARTNER OFF;


-- Switch to Mirror instance (red) ******************************
-- Recover Mirror
RESTORE DATABASE AdventureWorks WITH RECOVERY;

-- Drop database and delete files
DROP DATABASE AdventureWorks;


-- Force Service with possible data loss
-- Switch to Mirror instance *************************
ALTER DATABASE AdventureWorks SET PARTNER FORCE_SERVICE_ALLOW_DATA_LOSS

*/