--------------------------------------------------------------------
/*
SQL Server 2017 در High Availability دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
--ساخت بانک اطلاعاتی برای بررسی فایل های مربوط به آن
--DBServer1,DBServer2 در این سناریو دو تا ماشین به نام 
--باید باشد Witness داریم ، لپ تاپ من به عنوان سرور
--------------------------------------------------------------------
--انجام مراحل زیر در سرور
GO
--تنظیم اکانت های راه نداز سرویس
/*
Windows Accounts
UserName : U_Mirror
Password : Aa123456
*/
GO
--FQDN تنظیم 
GO
--etc Hosts تنظیم 
--c:\windows\system32\drivers\etc
GO
/*
DBServer1 : Principal
DBServer2 : Mirror
Laptop : Witness
*/
--------------------------------------------------------------------
--ساخت بانک اطلاعاتی مثال
USE master
GO
IF DB_ID('NikAmoozDB2017_Mirror')>0
BEGIN
	ALTER DATABASE NikAmoozDB2017_Mirror SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2017_Mirror
END
GO
CREATE DATABASE NikAmoozDB2017_Mirror
GO
USE NikAmoozDB2017_Mirror
GO
--بانک های اطلاعاتی سیستمیRecovery Model مشاهده 
SELECT 
	database_id,name,recovery_model_desc 
FROM SYS.databases
WHERE name='NikAmoozDB2017_Mirror'
GO
--------------------------------------------------------------------
--Principal Server تهیه نسخه پشتیبان از بانک اطلاعاتی 
USE master
GO
--تهیه فول بکاپ
BACKUP DATABASE NikAmoozDB2017_Mirror TO DISK ='C:\DUMP\NikAmoozDB2017_Mirror_Full.bak'
	WITH COMPRESSION,FORMAT
GO
--تهیه لاگ بکاپ
BACKUP LOG NikAmoozDB2017_Mirror TO DISK ='C:\DUMP\NikAmoozDB2017_Mirror_Logs.bak'
	WITH COMPRESSION,FORMAT
GO
--------------------------------------------------------------------
--Mirror Server بازیابی نسخه پشتیبان در 
--کپی شود Mirror حتما بانک اطلاعاتی به سرور 
USE master
GO
RESTORE FILELISTONLY FROM  DISK ='C:\DUMP\NikAmoozDB2017_Mirror_Full.bak'
GO
--بازیابی فول بکاپ
RESTORE DATABASE NikAmoozDB2017_Mirror FROM DISK ='C:\DUMP\NikAmoozDB2017_Mirror_Full.bak' 
WITH
	MOVE 'NikAmoozDB2017_Mirror' TO 'C:\Dump\NikAmoozDB2017_Mirror.mdf',
	MOVE 'NikAmoozDB2017_Mirror_log' TO 'C:\Dump\NikAmoozDB2017_Mirror_log.ldf',
	NORECOVERY
GO
--بازیابی لاگ بکاپ
RESTORE DATABASE NikAmoozDB2017_Mirror FROM DISK ='C:\DUMP\NikAmoozDB2017_Mirror_Logs.bak'
	 WITH NORECOVERY
GO
--------------------------------------------------------------------
--Database Mirroring شروع راه اندازی 
GO
--Principal Instance اجرا بر روی 
GO
USE Master
GO
--و حذف آن Endpoint بررسی جهت وجود 
IF  EXISTS (SELECT 1 FROM sys.endpoints e WHERE e.name = N'Mirroring') 
	DROP ENDPOINT Mirroring
GO
--جدید Endpoint ساخت یک 
CREATE ENDPOINT [Mirroring] 
    AUTHORIZATION SA
    STATE=STARTED
    AS TCP (LISTENER_PORT = 5022, LISTENER_IP = ALL)
    FOR DATA_MIRRORING (ROLE = PARTNER, AUTHENTICATION = WINDOWS NEGOTIATE
, ENCRYPTION = REQUIRED ALGORITHM AES)
GO
--SQL Server را استارت کرده به لاگین های مجاز  SQL Server اضافه کردن اکانتی که سرویس 
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'DBServer1\U_Mirror')
	DROP LOGIN [DBServer1\U_Mirror]
GO
--ایجاد لاگین مورد نظر 
CREATE LOGIN [DBServer1\U_Mirror] FROM WINDOWS
GO
--Endpoint دسترسی اتصال لاگین مورد نظر  به 
GRANT CONNECT ON ENDPOINT::Mirroring TO [DBServer1\U_Mirror] 
GO
--------------------------------------------------------------------
--Mirror Instance اجرا بر روی 
GO
USE Master
GO
--و حذف آن Endpoint بررسی جهت وجود 
IF  EXISTS (SELECT 1 FROM sys.endpoints e WHERE e.name = N'Mirroring') 
	DROP ENDPOINT Mirroring
GO
--جدید Endpoint ساخت یک 
CREATE ENDPOINT [Mirroring] 
    AUTHORIZATION SA
    STATE=STARTED
    AS TCP (LISTENER_PORT = 5023, LISTENER_IP = ALL)
    FOR DATA_MIRRORING (ROLE = PARTNER, AUTHENTICATION = WINDOWS NEGOTIATE
, ENCRYPTION = REQUIRED ALGORITHM AES)
GO
--SQL Server را استارت کرده به لاگین های مجاز  SQL Server اضافه کردن اکانتی که سرویس 
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'DBServer2\U_Mirror')
	DROP LOGIN [DBServer2\U_Mirror]
GO
--ایجاد لاگین مورد نظر 
CREATE LOGIN [DBServer2\U_Mirror] FROM WINDOWS
GO
--Endpoint دسترسی اتصال لاگین مورد نظر  به 
GRANT CONNECT ON ENDPOINT::Mirroring TO [DBServer2\U_Mirror] 
GO
--------------------------------------------------------------------
--Witness Instance اجرا بر روی 
GO
USE Master
GO
--و حذف آن Endpoint بررسی جهت وجود 
IF  EXISTS (SELECT * FROM sys.endpoints e WHERE e.name = N'Mirroring') 
	DROP ENDPOINT Mirroring
GO
--جدید Endpoint ساخت یک 
CREATE ENDPOINT [Mirroring] 
    AUTHORIZATION SA
    STATE=STARTED
    AS TCP (LISTENER_PORT = 5024, LISTENER_IP = ALL)
    FOR DATA_MIRRORING (ROLE = PARTNER, AUTHENTICATION = WINDOWS NEGOTIATE
, ENCRYPTION = REQUIRED ALGORITHM AES)
GO
--SQL Server را استارت کرده به لاگین های مجاز  SQL Server اضافه کردن اکانتی که سرویس 
IF  EXISTS (SELECT * FROM sys.server_principals WHERE name = N'MasoudTaheri\U_Mirror')
	DROP LOGIN [MasoudTaheri\U_Mirror]
GO
--ایجاد لاگین مورد نظر 
CREATE LOGIN [MasoudTaheri\U_Mirror] FROM WINDOWS
GO
--Endpoint دسترسی اتصال لاگین مورد نظر  به 
GRANT CONNECT ON ENDPOINT::Mirroring TO [MasoudTaheri\U_Mirror] 
GO
--------------------------------------------------------------------
--Mirror Instance اجرا بر روی 
-- On Mirror Instance, set the Principal
ALTER DATABASE NikAmoozDB2017_Mirror SET PARTNER = 'TCP://DBServer1.NikAmoozFQDN.com:5022'
GO
--------------------------------------------------------------------
--Principal Instance اجرا بر روی 
-- On Principal Instance, set the mirror
ALTER DATABASE NikAmoozDB2017_Mirror SET PARTNER = 'TCP://DBServer2.NikAmoozFQDN.com:5023'
GO
--------------------------------------------------------------------
--Principal Instance اجرا بر روی 
-- On Principal Instance, set the witness
ALTER DATABASE NikAmoozDB2017_Mirror SET WITNESS = 'TCP://MasoudTaheri.NikAmoozFQDN.com:5024'
GO

GO
--------------------------------------------------------------------
--پس از راه اندازی این تنظیمات اعمال شود
USE NikAmoozDB2017_Mirror
GO
DROP TABLE IF EXISTS TestTable
GO
CREATE TABLE TestTable
(
	C1 INT IDENTITY PRIMARY KEY,
	C2 NVARCHAR(10),
	C3 NVARCHAR(10)
)
GO
INSERT TestTable(C2,C3) VALUES (N'T1',N'T11')
GO












