--With Booking\avuser1
USE master
GO
--جهت ساختن DMK کد زیر را اجرا کنید
IF NOT EXISTS (SELECT 1 FROM sys.symmetric_keys where name ='##MS_DatabaseMasterKey##')
	CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Vf94^%#1SDnh84'
GO
--DMK مشاهده 
SELECT * FROM sys.symmetric_keys 
GO
---------------------------------
--Primary Replica
--Server Certificate قدم دوم ساخت 

Use master
GO
IF NOT EXISTS (SELECT 1 FROM sys.certificates WHERE name = 'Cert4AlwaysON_FANAVADB02')
	CREATE CERTIFICATE Cert4AlwaysON_FANAVADB02
	WITH SUBJECT = 'Certificate for Always-ON**FANAVADB02',
	START_DATE = '01/01/2023',
	EXPIRY_DATE = '01/01/2030'
GO
--Certificate مشاهده
SELECT * FROM sys.certificates 
GO
-- Backup the public key of the certificate to the filesystem
BACKUP CERTIFICATE Cert4AlwaysON_FANAVADB02
	TO FILE = 'D:\DB\Cert2\Cert4AlwaysON_FANAVADB02_Public.cert' 
GO
/*
Public Key For Encrypt
Private Key For Decrypt
*/
GO
--DROP CERTIFICATE Cert4AlwaysON_FANAVADB02
---------------------------------
--Primary Replica
USE master
GO
IF NOT EXISTS (SELECT 1 FROM SYS.endpoints WHERE name='Hadr_endpoint')
DROP ENDPOINT Hadr_endpoint
Go
CREATE ENDPOINT Hadr_endpoint 
STATE = STARTED 
AS TCP 
(
	LISTENER_PORT = 5022, LISTENER_IP = ALL
)  
	FOR DATABASE_MIRRORING 
(
	AUTHENTICATION = CERTIFICATE Cert4AlwaysON_FANAVADB02, 
	ENCRYPTION = REQUIRED ALGORITHM AES,
	ROLE = ALL 
)
GO
--Endpoint مشاهده 
SELECT * FROM SYS.endpoints
GO
--DROP ENDPOINT Hadr_endpoint 
GO
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
/*
اجرا شود Secondary Replica اسکریپت های زیر بر روی 
*/
GO
--Secondary Replica
USE master
GO
--جهت ساختن DMK کد زیر را اجرا کنید
IF NOT EXISTS (SELECT 1 FROM sys.symmetric_keys where name ='##MS_DatabaseMasterKey##')
	CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Vf94^%#1SDnh84'
GO
--DMK مشاهده 
SELECT * FROM sys.symmetric_keys 
GO
---------------------------------
--Secondary Replica
--Server Certificate قدم دوم ساخت 
--جهت ساخت سرتیفیکیتی با اسم مثالی Cert4AlwaysON_AsiaTechDB01  کد زیر را اجرا کنید
Use master
GO
IF NOT EXISTS (SELECT 1 FROM sys.certificates WHERE name = 'Cert4AlwaysON_AsiaTechDB01')
	CREATE CERTIFICATE Cert4AlwaysON_AsiaTechDB01
	WITH SUBJECT = 'Certificate for Always-ON**ASIATechDB01',
	START_DATE = '01/01/2023',
	EXPIRY_DATE = '01/01/2030'
GO
--Certificate مشاهده
SELECT * FROM sys.certificates 
GO
-- Backup the public key of the certificate to the filesystem
BACKUP CERTIFICATE Cert4AlwaysON_AsiaTechDB01
	TO FILE = 'D:\DB\Cert2\Cert4AlwaysON_AsiaTechDB01_Public.cert' 
GO
/*
Public Key For Encrypt
Private Key For Decrypt
*/
GO
--DROP CERTIFICATE Cert4AlwaysON_AsiaTechDB01
---------------------------------
--Secondary Replica
USE master
GO
IF NOT EXISTS (SELECT 1 FROM SYS.endpoints WHERE name='Hadr_endpoint')
	CREATE ENDPOINT Hadr_endpoint 
	STATE = STARTED 
	AS TCP 
	(
	   LISTENER_PORT = 5022, LISTENER_IP = ALL
	)  
	   FOR DATABASE_MIRRORING 
	(
	   AUTHENTICATION = CERTIFICATE Cert4AlwaysON_AsiaTechDB01, 
	   ENCRYPTION = REQUIRED ALGORITHM AES,
	   ROLE = ALL 
	)
GO
--Endpoint مشاهده 
SELECT * FROM SYS.endpoints
GO
--DROP ENDPOINT Hadr_endpoint 
GO
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
/*
هاCertificate کپی کردن
*/
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
/*
اجرا شود Primary Replica اسکریپت های زیر بر روی 
*/
USE master
GO
--ایجاد یک لاگین در سرور اصلی 
IF EXISTS(SELECT * FROM SYS.sql_logins WHERE name='Alwayson_User')
BEGIN
	DROP CERTIFICATE Cert4AlwaysON_AsiaTechDB01_Public
	DROP USER IF EXISTS Alwayson_User
END
--ایجاد لاگین 
CREATE LOGIN Alwayson_User WITH PASSWORD = 'Vf94^%#1SDnh84'
--مشاهده لاگین مورد نظر
SELECT * FROM  SYS.sql_logins 
GO
---------------------------------
--بررسی جهت وجود یوزر و حذف
DROP USER IF EXISTS Alwayson_User
GO
--ایجاد یوزر به ازای لاگین
CREATE USER Alwayson_User FOR LOGIN Alwayson_User
GO
SELECT * FROM SYS.sysusers
GO
---------------------------------
-- Import the public key portion of the certificate from the other node
--User , Certificate ارتباط مابین  
CREATE CERTIFICATE Cert4AlwaysON_AsiaTechDB01_Public
AUTHORIZATION Alwayson_User
FROM FILE = 'D:\DB\Cert2\Cert4AlwaysON_AsiaTechDB01_Public.cert'
GO
--برای لاگین مورد نظر Endpoint به  CONNECT اعمال پرمیژن 
GRANT CONNECT ON ENDPOINT::Hadr_endpoint TO Alwayson_User
GO
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
/*
اجرا شود Secondary Replica اسکریپت های زیر بر روی 
*/
USE master
GO
--ایجاد یک لاگین در سرور اصلی 
IF EXISTS(SELECT * FROM SYS.sql_logins WHERE name='Alwayson_User')
BEGIN
	DROP CERTIFICATE Cert4AlwaysON_FANAVADB02_Public
	DROP USER IF EXISTS Alwayson_User
END
--ایجاد لاگین 
CREATE LOGIN Alwayson_User WITH PASSWORD = 'Vf94^%#1SDnh84'
--مشاهده لاگین مورد نظر
SELECT * FROM  SYS.sql_logins 
GO
---------------------------------
--بررسی جهت وجود یوزر و حذف
DROP USER IF EXISTS Alwayson_User
GO
--ایجاد یوزر به ازای لاگین
CREATE USER Alwayson_User FOR LOGIN Alwayson_User
GO
SELECT * FROM SYS.sysusers
GO
---------------------------------
-- Import the public key portion of the certificate from the other node
--User , Certificate ارتباط مابین  
CREATE CERTIFICATE Cert4AlwaysON_FANAVADB02_Public
AUTHORIZATION Alwayson_User
FROM FILE = 'D:\DB\Cert4AlwaysON_FANAVADB02_Public.cert'
GO
--برای لاگین مورد نظر Endpoint به  CONNECT اعمال پرمیژن 
GRANT CONNECT ON ENDPOINT::Hadr_endpoint TO Alwayson_User
GO
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
/*
اجرا شود Primary Replica کارهای های زیر بر روی 
*/
/*
Always-ON اعمال تنظیمات 
Wizard
*/
GO
--------------------------------------------------------------------
--------------------------------------------------------------------
--------------------------------------------------------------------
/*
اجرا شود Primary Replica اسکریپت های زیر بر روی 
*/
--Static IP با استفاده از Listener ایجاد  
ALTER AVAILABILITY GROUP AG1
ADD LISTENER N'L1' (
WITH IP
((N'192.168.159.50', N'255.255.255.0')
)
, PORT=1433);
GO
--Listener مشاهده مشخصات مربوط به 
SELECT * FROM SYS.availability_group_listeners
GO
SELECT	AV.name AS AVGName
	, AVGLis.dns_name AS ListenerName
	, AVGLis.ip_configuration_string_from_cluster AS ListenerIP
FROM	sys.availability_group_listeners AVGLis
JOIN sys.availability_groups AV on AV.group_id = AV.group_id
GO
---------------------------------
--Readonly Routing URL ایجاد 
USE master
GO
ALTER AVAILABILITY GROUP AG1
 MODIFY REPLICA ON
N'SQLServer2022-1' WITH 
(SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'TCP://FanavaDB02.booking.local:1433'));
GO
ALTER AVAILABILITY GROUP AG1
 MODIFY REPLICA ON
N'SQLServer2022-2' WITH 
(SECONDARY_ROLE (READ_ONLY_ROUTING_URL = N'TCP://AsiaTechDB01.booking.local:1433'));
GO
---Wizard ادامه کار با 
--  یا
ALTER AVAILABILITY GROUP AlwatsOn1 ADD DATABASE [IPA_booking_ir]
GO
USE [master]
GO
ALTER AVAILABILITY GROUP [AlwatsOn1]
ADD LISTENER N'DBListner2' (
WITH IP
((N'192.168.159.51', N'255.255.255.0'),
(N'192.168.160.51', N'255.255.255.0')
)
, PORT=1433);