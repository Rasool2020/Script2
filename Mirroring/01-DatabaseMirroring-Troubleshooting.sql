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
--Database Mirroring عیب یابی 
USE master
GO
--Database Mirroring پیدا کردن پورت های مرتبط با 
SELECT 
	type_desc, port 
FROM sys.tcp_endpoints
GO
--------------------------------------------------------------------
--ها Endpoint اطمینان از راه اندازی 
SELECT 
	name,state_desc 
FROM sys.database_mirroring_endpoints
GO
--------------------------------------------------------------------
--خطای شماره 1418
--انجام تمامی مراحل پیش نیاز
--تنظیمات فایروال
GO
--------------------------------------------------------------------
--Endpoint سرویس اکانت های به Connect چک کردن مجوز
SELECT 
	EP.name, SP.STATE,
	CONVERT(nvarchar(38), suser_name(SP.grantor_principal_id)) AS GRANTOR,
	SP.TYPE AS PERMISSION,
	CONVERT(nvarchar(46),suser_name(SP.grantee_principal_id)) AS GRANTEE
FROM sys.server_permissions SP
INNER JOIN sys.endpoints EP
	ON SP.major_id = EP.endpoint_id
ORDER BY 
	Permission, grantor, grantee;
GO
--------------------------------------------------------------------
--و نحوه رفع خطای آن Timeout مشاهده مقدار
SELECT 
	database_id,DB_NAME(database_id)  AS DatabaseName,
	mirroring_connection_timeout
FROM sys.database_mirroring
GO
ALTER DATABASE xxxxxx SET PARTNER TIMEOUT 15
GO
--مقدار پیش فرض  ثانیه است
--بررسی تایم اوت با پینگ است
GO