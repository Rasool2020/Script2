SELECT 
    s.session_id,
    s.login_time,
    s.host_name,
    s.program_name,
    s.login_name,
    s.nt_user_name,
    s.is_user_process,
    s.database_id,
    DB_NAME(s.database_id) AS database_name,
    s.status,
    s.reads,
    s.writes,
    s.logical_reads,
    s.row_count,
    r.command,
    r.start_time,
    r.status AS request_status
FROM 
    sys.dm_exec_sessions s
LEFT JOIN 
    sys.dm_exec_requests r ON s.session_id = r.session_id
WHERE 
    s.database_id = DB_ID('DATABASENAME')
ORDER BY 
    s.login_time DESC;
