SELECT TOP 100 PERCENT document.code + 1 AS Code, document.fiscalyearid, fiscalyear.name as fiscalyearName
FROM document INNER JOIN fiscalyear ON document.fiscalyearid = fiscalyear.id LEFT OUTER JOIN
 document document_1 ON document.fiscalyearid = document_1.fiscalyearid AND document.code + 1 = document_1.code
WHERE (document_1.code IS NULL) ORDER BY Doument.code