USE master
GO
IF DB_ID('testDB2022')>0
BEGIN
	ALTER DATABASE testDB2022 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE testDB2022
END
GO
CREATE DATABASE testDB2022
ON PRIMARY 
(
	NAME = testDB2022,FILENAME = 'D:\Dump\TestFS\testDB2022.mdf'
),
FILEGROUP FG_FileStream CONTAINS FILESTREAM
(
	NAME = testDB2022_FSG,FILENAME ='D:\Dump\TestFS\testDB2022_FSG'
)
LOG ON 
(
	NAME = testDB2022_Log,FILENAME = 'D:\Dump\TestFS\testDB2022_Log.ldf'
)
GO
--Filestream ایجاد یک جدول برای استفاده از ویژگی 
GO
USE testDB2022
GO
--ایجاد فایل 
DROP TABLE IF EXISTS TestTable
GO
--ایجاد جدول
CREATE TABLE TestTable
(
	ID INT	IDENTITY PRIMARY KEY,
	FileID  UNIQUEIDENTIFIER NOT NULL ROWGUIDCOL UNIQUE DEFAULT(NEWSEQUENTIALID()),
	Title	NVARCHAR(255) NOT NULL,
	Content	VARBINARY(MAX) FILESTREAM NULL
)    
ON [PRIMARY] FILESTREAM_ON FG_FileStream
GO
--------------------------------------------------------------------
/*
--عمیات درج
--است Filestream درج رکورد در جدولی که دارای 
*/
USE testDB2022
GO
INSERT INTO TestTable(Title,Content)
	VALUES ('Masoud Taheri',CAST(REPLICATE('Masoud Taheri*',10) AS VARBINARY(MAX)))
GO
SELECT * FROM TestTable
GO
SELECT *,CAST(Content AS VARCHAR(MAX)) FROM TestTable
GO
--NTFS مشاهده فایل در
GO
--درج یک تصویر در جدول
INSERT INTO TestTable(Title,Content)
	SELECT 
		'Performance Tuning', BulkColumn 
	FROM OPENROWSET
		(
			BULK N'C:\Temp\Image1.png', 
			SINGLE_BLOB, Single_Blob
		) AS tmp
GO
SELECT * FROM TestTable
GO
SELECT *,CAST(Content AS VARCHAR(MAX)) FROM TestTable
GO
--PathName بررسی متد 
SELECT ID,FILEID,Title,Content.PathName() FROM TestTable
GO
--------------------------------------------------------------------
--Filestream کردن رکوردها در Update بررسی عملیات 
USE testDB2022
GO
SELECT *,CAST(Content AS VARCHAR(MAX)) FROM TestTable
GO
UPDATE TestTable SET 
	Content= CAST('Hello NikAmooz!' AS VARBINARY(MAX))
WHERE ID=1
GO
SELECT *,CAST(Content AS VARCHAR(MAX)) FROM TestTable
GO
UPDATE TestTable SET 
	Content= NULL
WHERE ID=1
GO
SELECT *,CAST(Content AS VARCHAR(MAX)) FROM TestTable
GO
UPDATE TestTable SET 
	Content= 0x
WHERE ID=1
GO
SELECT *,CAST(Content AS VARCHAR(MAX)) FROM TestTable
GO
--------------------------------------------------------------------
USE testDB2022
GO
--Filestream کردن رکوردها در Delete بررسی عملیات 
INSERT INTO TestTable(Title,Content) VALUES
	('Farid Taheri',CAST(REPLICATE('Farid Taheri*',10) AS VARBINARY(MAX))),
	('Ali Taheri',CAST(REPLICATE('Ali Taheri*',10) AS VARBINARY(MAX))),
	('Alireza Taheri',CAST(REPLICATE('Alireza Taheri*',10) AS VARBINARY(MAX)))
GO
SELECT *,CAST(Content AS VARCHAR(MAX)) FROM TestTable
GO
DELETE FROM TestTable WHERE ID=1
GO
--فايل ركوردهاي مورد نظر به زودي از ديسك پاك نمي شود
CHECKPOINT 
GO
--اجبار برای پاک کردن فایل های فایل استریم
EXEC sp_filestream_force_garbage_collection @dbname = N'testDB2022'
GO
EXEC sp_filestream_force_garbage_collection  
	@dbname =   'testDB2022'  , @filename = 'testDB2022_FSG' 
GO
--Tuncate امکان استفاده از دستور 
TRUNCATE TABLE TestTable
GO
/*
--بررسی پاک کردن دستی خود فایل ها
واکشی داده از جدول و مشاهده خطای مربوط به آن
*/
