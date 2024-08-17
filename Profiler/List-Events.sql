USE MASTER;
GO
SELECT DISTINCT
 tb.trace_event_id,
 te.[name] AS 'Event Class',
 em.package_name AS 'Package',
 em.xe_event_name AS 'XEvent Name',
 tca.[name] AS 'Profiler Category'
FROM (sys.trace_events te
 LEFT OUTER JOIN sys.trace_xe_event_map em
 ON te.trace_event_id =
 em.trace_event_id)
 LEFT OUTER JOIN sys.trace_event_bindings tb
 ON em.trace_event_id = tb.trace_event_id
 INNER JOIN sys.trace_categories tca
 ON tca.category_id = te.category_id
WHERE tb.trace_event_id IS NOT NULL
 AND tca.[name] in ('Stored Procedures',
 'TSQL',
'Performance')
ORDER BY tb.trace_event_id;