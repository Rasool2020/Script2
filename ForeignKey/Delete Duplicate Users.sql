--------------------------------------------------------------------
------ Update Phonenumbers -------
--------------------------------------------------------------------

SELECT PhoneNumber,
       IIF(PhoneNumber IS NULL OR LEN(PhoneNumber) < 2, PhoneNumber, CONCAT('+', dbo.ClearPhoneNumber(PhoneNumber)))
FROM dbo.AspNetUsers
WHERE LEN(PhoneNumber) <= 13
      AND
      (
          PhoneNumber LIKE '0%'
          OR PhoneNumber LIKE '98%'
          OR PhoneNumber LIKE '+98%'
      );



UPDATE dbo.AspNetUsers
SET PhoneNumber = IIF(PhoneNumber IS NULL OR LEN(PhoneNumber) < 2,
                      PhoneNumber,
                      CONCAT('+', dbo.ClearPhoneNumber(PhoneNumber))),
    CountryCode = N'IR'
WHERE LEN(PhoneNumber) <= 13
      AND
      (
          PhoneNumber LIKE '0%'
          OR PhoneNumber LIKE '98%'
          OR PhoneNumber LIKE '+98%'
      );



SELECT *
FROM basic.TbContact
WHERE LEN(Mobile) <= 13
      AND
      (
          Mobile LIKE '0%'
          OR Mobile LIKE '98%'
          OR Mobile LIKE '+98%'
      );


UPDATE basic.TbContact
SET Mobile = IIF(Mobile IS NULL OR LEN(Mobile) < 2 AND LEN(Mobile) > 13,
                 Mobile,
                 CONCAT('+', dbo.ClearPhoneNumber(Mobile))),
    CountryCode = 'IR'
WHERE LEN(Mobile) <= 13
      AND
      (
          Mobile LIKE '0%'
          OR Mobile LIKE '98%'
          OR Mobile LIKE '+98%'
      );


-- chack duplicate 

SELECT PhoneNumber, COUNT(1) total FROM dbo.AspNetUsers
GROUP BY PhoneNumber
HAVING COUNT(1) > 1

SELECT *
FROM dbo.AspNetUsers
WHERE PhoneNumber IN
      (
          SELECT PhoneNumber
          FROM dbo.AspNetUsers
          GROUP BY PhoneNumber
          HAVING COUNT(1) > 1
      );
--------------------------------------------------------------------
--------------------------------------------------------------------


--------------------------------------------------------------------
------ Merge & Delete Duplicate Users -------
--------------------------------------------------------------------

DROP TABLE IF EXISTS #tblUsers;
DROP TABLE IF EXISTS #tblMergerdUser;
GO


SELECT PhoneNumber,
       ISNULL(MAX(TB1.FF), MAX(TB1.UserName)) UserName,
       MAX(TB1.Email) Email,
       MAX(IIF(TB1.EmailConfirmed = 1, 1, 0)) EmailConfirmed,
       MAX(IIF(TB1.PhoneNumberConfirmed = 1, 1, 0)) PhoneNumberConfirmed,
       MAX(TB1.Gender) Gender,
       MAX(TB1.FirstName) FirstName,
       MAX(TB1.LastName) LastName,
       MAX(TB1.PasswordHash) PasswordHash,
       MIN(TB1.Source) Source
INTO #tblMergerdUser
FROM
(
    SELECT IIF(LEN(u.UserName) = LEN(NEWID()), NULL, u.UserName) AS FF,
           u.UserName,
           u.PhoneNumber,
           u.Email,
           u.EmailConfirmed,
           u.PhoneNumberConfirmed,
           u.Gender,
           u.FirstName,
           u.LastName,
           u.PasswordHash,
           u.Source
    FROM dbo.AspNetUsers u
    WHERE EXISTS
    (
        SELECT 1
        FROM dbo.AspNetUsers t
        WHERE t.PhoneNumber IS NOT NULL
			  AND t.PhoneNumber = u.PhoneNumber
			  AND LEN(t.PhoneNumber) > 2
			  AND LEN(u.UserName) > 20
        GROUP BY t.PhoneNumber
        HAVING COUNT(1) > 1
    )
	--ORDER BY PhoneNumber

) AS TB1
GROUP BY TB1.PhoneNumber
--SELECT * FROM #tblMergerdUser order by len(username)

GO


SELECT u.Id,
       u.PhoneNumber,
       u.UserName,
       ROW_NUMBER() OVER (PARTITION BY u.PhoneNumber ORDER BY u.CreateDate) RowNum
INTO #tblUsers
FROM dbo.AspNetUsers u
WHERE EXISTS
(
    SELECT 1 FROM #tblMergerdUser tp WHERE tp.PhoneNumber = u.PhoneNumber
);

--SELECT * FROM #tblUsers order by PhoneNumber

GO


UPDATE u 
SET u.Email = MergerdUser.Email,
    u.EmailConfirmed = MergerdUser.EmailConfirmed,
    u.PhoneNumberConfirmed = MergerdUser.PhoneNumberConfirmed,
    u.Gender = MergerdUser.Gender,
    u.FirstName = MergerdUser.FirstName,
    u.LastName = MergerdUser.LastName,
    u.PasswordHash = MergerdUser.PasswordHash,
    u.Source = MergerdUser.Source
FROM dbo.AspNetUsers u
    INNER JOIN #tblMergerdUser AS MergerdUser
        ON MergerdUser.PhoneNumber = u.PhoneNumber
WHERE EXISTS
(
    SELECT 1 FROM #tblMergerdUser tp WHERE tp.PhoneNumber = u.PhoneNumber
);
GO


/* declare variables */
DECLARE @phone NVARCHAR(15);

DECLARE userCursor CURSOR FAST_FORWARD READ_ONLY FOR
SELECT PhoneNumber
FROM #tblMergerdUser;

OPEN userCursor;

FETCH NEXT FROM userCursor
INTO @phone;

WHILE @@FETCH_STATUS = 0
BEGIN

    DECLARE @UserId NVARCHAR(128);
    SELECT @UserId = Id
    FROM #tblUsers
    WHERE PhoneNumber = @phone
          AND RowNum = 1;

    DECLARE @Ids NVARCHAR(MAX);
    SELECT @Ids = CONCAT('''', STRING_AGG(t.Id, ''','''), '''')
    FROM #tblUsers t
    WHERE t.RowNum > 1
          AND t.PhoneNumber = @phone;

    DROP TABLE IF EXISTS #tblCommands;
    SELECT CONCAT(
                     N'UPDATE ',
                     s.name,
                     N'.',
                     t.name,
                     N' SET [',
                     c.name,
                     N'] = N''',
                     @UserId,
                     N''' WHERE [',
                     c.name,
                     N'] IN (',
                     @Ids,
                     ')'
                 ) AS Command
    INTO #tblCommands
    FROM sys.foreign_key_columns AS fk
        INNER JOIN sys.tables AS t
            ON fk.parent_object_id = t.object_id
        INNER JOIN sys.columns AS c
            ON fk.parent_object_id = c.object_id
               AND fk.parent_column_id = c.column_id
        INNER JOIN sys.schemas s
            ON s.schema_id = t.schema_id
    WHERE fk.referenced_object_id =
    (
        SELECT object_id FROM sys.tables WHERE name = 'AspNetUsers'
    );


    DECLARE @command NVARCHAR(MAX);
    DECLARE cur_Commands CURSOR FAST_FORWARD READ_ONLY FOR
    SELECT *
    FROM #tblCommands;
    OPEN cur_Commands;
    FETCH NEXT FROM cur_Commands
    INTO @command;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXECUTE (@command);
        FETCH NEXT FROM cur_Commands
        INTO @command;
    END;

    CLOSE cur_Commands;
    DEALLOCATE cur_Commands;


    EXECUTE (N'DELETE FROM dbo.AspNetUsers WHERE Id IN ( ' + @Ids + ' )');

	UPDATE u 
	SET u.UserName = m.UserName
	FROM dbo.AspNetUsers u 
	INNER JOIN #tblMergerdUser m ON m.PhoneNumber = u.PhoneNumber


    FETCH NEXT FROM userCursor
    INTO @phone;
END;

CLOSE userCursor;
DEALLOCATE userCursor;