--------------------------------------------------------------------
/*
SQL Server 2016 دوره امنیت در 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
GO
--ایجاد بانک اطلاعاتی
USE master
GO
IF DB_ID('Northwind')>0
BEGIN
	ALTER DATABASE Northwind SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE Northwind
END
GO
CREATE DATABASE Northwind
GO
--------------------------------------------------------------------
/*
SELECT D.name,D.is_encrypted FROM sys.DATABASES D
SELECT * FROM SYS.certificates
SELECT * FROM sys.dm_database_encryption_keys

DROP MASTER KEY 
DROP CERTIFICATE NorthwindBackupEncryptCert 
*/
USE master
GO
BACKUP DATABASE Northwind TO DISK = N'C:\Dump\Northwind\NorthwindSimple.bak'
	 WITH FORMAT,STATS=1
GO
--Check File In Notepad & Search Orders

--DMK ایجاد
CREATE MASTER KEY ENCRYPTION 
	BY PASSWORD = 'Master_Key_Password'; 
GO 
 --Certificate ایجاد یک 
 CREATE CERTIFICATE NorthwindBackupEncryptCert 
	WITH SUBJECT = 'Northwind Backup Encryption Certificate';
 GO
 --هاCertificate مشاهده لیست 
SELECT * FROM SYS.certificates
	WHERE name='NorthwindBackupEncryptCert'
GO
--کردن آن Encrypt تهیه بکاپ و 
BACKUP DATABASE Northwind TO DISK = N'C:\Dump\Northwind\Northwind_Normal.bak' 
WITH ENCRYPTION 
( 
	ALGORITHM = AES_256, 
	SERVER CERTIFICATE = NorthwindBackupEncryptCert 
),STATS =1,FORMAT
GO
--Check File In Notepad & Search Orders
GO
--کردن آن به همراه فشرده سازی Encrypt تهیه بکاپ و 
BACKUP DATABASE Northwind TO DISK = N'C:\Dump\Northwind\Northwind_Compression.bak' 
WITH ENCRYPTION 
( 
	ALGORITHM = AES_256, 
	SERVER CERTIFICATE = NorthwindBackupEncryptCert 
),STATS =1,COMPRESSION,FORMAT
GO
/*
--دیگر Instance انتقال به یک 
--** Source Instance **--
1: BACKUP MASTER KEY
2: BACKUP CERTIFICATE

--** Destination Instance **--
1: Restore Master Key 
2: Restore Certificate
3: Restore Database
*/
--------------------------------------------------------------------
--** Source Instance **--

--1: BACKUP MASTER KEY
BACKUP MASTER KEY TO FILE = 'C:\Dump\Northwind\MasterKey.key' 
	ENCRYPTION BY PASSWORD = 'p@ssw0rd';
GO
--2: BACKUP CERTIFICATE
BACKUP CERTIFICATE NorthwindBackupEncryptCert 
TO FILE = 'C:\Dump\Northwind\NorthwindBackupEncryptCert.cert' 
WITH PRIVATE KEY 
	(
		FILE = 'C:\Dump\Northwind\NorthwindBackupEncryptCert.key', 
		ENCRYPTION BY PASSWORD = 'p@ssw0rd'
	);
--------------------------------------------------------------------
USE master
GO
DROP CERTIFICATE NorthwindBackupEncryptCert 
DROP MASTER KEY
GO
--تلاش برای بازیابی بانک اطلاعاتی
RESTORE DATABASE Northwind FROM DISK = 'C:\Dump\Northwind_Normal.bak'
	WITH REPLACE
--------------------------------------------------------------------
--CREATE MASTER  / Restore Master Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Master_Key_Password';
GO
/*
RESTORE MASTER KEY 
    FROM FILE = 'c:\Dump\Northwind\MasterKey.key' 
    DECRYPTION BY PASSWORD = 'p@ssw0rd' 
    ENCRYPTION BY PASSWORD = 'Master_Key_Password';
GO
OPEN MASTER KEY DECRYPTION BY PASSWORD = 'Master_Key_Password'
GO
*/
CREATE CERTIFICATE NorthwindBackupEncryptCert
FROM FILE = 'C:\Dump\Northwind\NorthwindBackupEncryptCert.cert'
	WITH PRIVATE KEY 
	(
		FILE = 'C:\Dump\Northwind\NorthwindBackupEncryptCert.key',
		DECRYPTION BY PASSWORD = 'p@ssw0rd'
	);

--تلاش برای بازیابی بانک اطلاعاتی
RESTORE DATABASE Northwind FROM DISK = 'C:\Dump\Northwind_Normal.bak'
	WITH REPLACE
