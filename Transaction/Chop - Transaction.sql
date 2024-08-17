DECLARE @done bit = 0;
WHILE (@done = 0)
BEGIN
    DELETE TOP(1000) FROM LogMessages WHERE LogDate < '20210102';
    IF @@rowcount < 1000 SET @done = 1;
END;