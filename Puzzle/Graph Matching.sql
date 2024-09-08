/*
	https://www.itprotoday.com/devops/puzzle-challenge-graph-matching-with-t-sql-part-1-concepts
*/

SET NOCOUNT ON;
USE tempdb;

-- Cleanup
DROP TABLE IF EXISTS dbo.M, dbo.G, dbo.X, dbo.Y;
GO

-- Set X, e.g., Applicants
CREATE TABLE dbo.X
(
  x VARCHAR(10) NOT NULL CONSTRAINT PK_X PRIMARY KEY,
  moreonx VARCHAR(20) NOT NULL
);

INSERT INTO dbo.X(x, moreonx) VALUES
  ('A', 'Applicant A'),
  ('B', 'Applicant B'),
  ('C', 'Applicant C'),
  ('D', 'Applicant D');

-- Set Y, e.g., Jobs
CREATE TABLE dbo.Y
(
  y INT NOT NULL CONSTRAINT PK_Y PRIMARY KEY,
  moreony VARCHAR(20) NOT NULL
);

INSERT INTO dbo.Y(y, moreony) VALUES
  (1, 'Job 1'),
  (2, 'Job 2'),
  (3, 'Job 3'),
  (4, 'Job 4');

-- Graph G = (X, Y, E), e.g., possible applicant-job connections
CREATE TABLE dbo.G
(
  x VARCHAR(10) NOT NULL
    CONSTRAINT FK_G_X FOREIGN KEY REFERENCES dbo.X,
  y INT NOT NULL
    CONSTRAINT FK_G_Y FOREIGN KEY REFERENCES dbo.Y,
  CONSTRAINT PK_G PRIMARY KEY (x, y)
);

INSERT INTO dbo.G(x, y) VALUES
  ('A', 1),
  ('A', 2),
  ('B', 1),
  ('B', 3),
  ('C', 3),
  ('C', 4),
  ('D', 3);

Go
SELECT
  X.x AS applicantid, X.moreonx AS applicantname,
  Y.y AS jobid, Y.moreony AS jobname
FROM dbo.X
 JOIN dbo.G
    ON X.x = G.x
 JOIN dbo.Y
    ON G.y = Y.y;
Go

-- M is a matching in G

DROP TABLE IF EXISTS dbo.M;

CREATE TABLE dbo.M
(
  x VARCHAR(10) NOT NULL
    CONSTRAINT UQ_M_x UNIQUE,
  y INT NOT NULL
    CONSTRAINT UQ_M_y UNIQUE,
  CONSTRAINT PK_M PRIMARY KEY (x, y),
  CONSTRAINT FK_M_G FOREIGN KEY (x, y) REFERENCES dbo.G(x, y)
);

-- Helper function dbo.GetNums
DROP FUNCTION IF EXISTS dbo.GetNums;
GO
CREATE FUNCTION dbo.GetNums(@low AS BIGINT, @high AS BIGINT) RETURNS TABLE
AS
RETURN
  WITH
    L0   AS (SELECT c FROM (SELECT 1 UNION ALL SELECT 1) AS D(c)),
    L1   AS (SELECT 1 AS c FROM L0 AS A CROSS JOIN L0 AS B),
    L2   AS (SELECT 1 AS c FROM L1 AS A CROSS JOIN L1 AS B),
    L3   AS (SELECT 1 AS c FROM L2 AS A CROSS JOIN L2 AS B),
    L4   AS (SELECT 1 AS c FROM L3 AS A CROSS JOIN L3 AS B),
    L5   AS (SELECT 1 AS c FROM L4 AS A CROSS JOIN L4 AS B),
    Nums AS (SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS rownum
             FROM L5)
  SELECT TOP(@high - @low + 1) @low + rownum - 1 AS n
  FROM Nums
  ORDER BY rownum;
GO

-- Larger set of sample data to test performance
DROP TABLE IF EXISTS dbo.M, dbo.G, dbo.X, dbo.Y;
GO

CREATE TABLE dbo.G
(
  x VARCHAR(10) NOT NULL,
  y INT NOT NULL,
  CONSTRAINT PK_G PRIMARY KEY (x, y)
);

CREATE TABLE dbo.M
(
  x VARCHAR(10) NOT NULL
    CONSTRAINT UQ_M_x UNIQUE,
  y INT NOT NULL
    CONSTRAINT UQ_M_y UNIQUE,
  CONSTRAINT PK_M PRIMARY KEY (x, y),
  CONSTRAINT FK_M_G FOREIGN KEY (x, y) REFERENCES dbo.G(x, y)
);

DECLARE @n AS INT = 10000000; -- ~ total num rows
SET @n = SQRT(@n * 2); -- num members of arithmetic sequence

INSERT INTO dbo.G WITH (TABLOCK) (x, y)
  SELECT RIGHT('000000000' + CAST(X.n AS VARCHAR(10)), 10) AS x, Y.n AS y
  FROM dbo.GetNums(1, @n) AS X
    CROSS APPLY (SELECT TOP (@n - X.n + 1) n
                 FROM dbo.GetNums(1, @n)
                 ORDER BY NEWID()) AS Y;