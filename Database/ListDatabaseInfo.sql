SELECT
    D.Name as [Database Name],
    F.state_desc AS OnlineStatus,
    Convert(VARCHAR(12),CAST((sum(
    Case when f.physical_name like '%ldf' then 0 else f.size end)*8.0)/1024.0 AS numeric(8,2))) AS [Data File Size MB],
    Convert(VARCHAR(12),CAST((sum(
    Case When f.physical_name like '%ldf' then f.size else 0 end)*8.0)/1024.0 AS numeric(8,2))) AS [Log File Size MB], 
	D.compatibility_level, D.user_access_desc, D.is_read_only, D.is_auto_shrink_on, D.delayed_durability_desc, 
	D.is_accelerated_database_recovery_on, D.is_memory_optimized_enabled, D.is_ledger_on
    --,CAST(F.size*8 AS VARCHAR(32)) + ' Bytes' as SizeInBytes
FROM 
    sys.master_files F
    INNER JOIN sys.databases D ON D.database_id = F.database_id
Group By D.name,F.state_desc, D.compatibility_level, D.user_access_desc, D.is_read_only, D.is_auto_shrink_on, D.delayed_durability_desc, D.is_accelerated_database_recovery_on, D.is_memory_optimized_enabled, D.is_ledger_on
ORDER BY
	--Sum(case when f.physical_name like '%ldf'then 0 else f.size end) Desc
	Sum(case when f.physical_name like '%ldf'then f.size else 0 end) Desc
    --,D.name
Go
SELECT
    D.name,
    F.Name AS FileType,
    F.physical_name AS PhysicalFile,
    F.state_desc AS OnlineStatus,
    CAST((F.size*8)/1024 AS VARCHAR(26)) + ' MB' AS FileSize,
    CAST(F.size*8 AS VARCHAR(32)) + ' Bytes' as SizeInBytes
FROM 
    sys.master_files F
    INNER JOIN sys.databases D ON D.database_id = F.database_id
ORDER BY
    --D.name
	F.size Desc
Go
exec sp_databases
Go
