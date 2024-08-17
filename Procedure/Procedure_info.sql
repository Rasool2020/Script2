SELECT 
    p.name AS [SP Name], qs.execution_count,
    ISNULL(qs.execution_count/DATEDIFF(Second, qs.cached_time, GETDATE()), 0) AS [Calls/Second],
    qs.total_worker_time/qs.execution_count AS [AvgWorkerTime], qs.total_worker_time AS [TotalWorkerTime],  
    qs.total_elapsed_time, qs.total_elapsed_time/qs.execution_count AS [avg_elapsed_time],
    qs.cached_time,
    isr.ROUTINE_DEFINITION
FROM sys.procedures AS p
INNER JOIN sys.dm_exec_procedure_stats AS qs
ON p.[object_id] = qs.[object_id]
Inner Join INFORMATION_SCHEMA.ROUTINES as ISR
on p.name = isr.SPECIFIC_NAME
WHERE qs.database_id = DB_ID()
    and isr.ROUTINE_DEFINITION like '%ringlog%'  -- name of something you are looking for in the stored procedure

ORDER BY qs.execution_count DESC OPTION (RECOMPILE);