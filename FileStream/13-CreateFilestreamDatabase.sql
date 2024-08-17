--------------------------------------------------------------------
/*
Performance & Tuning in SQL Serve دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
--Filestream ایجاد یک بانک اطلاعاتی با پشتیبانی از ویژگی 
USE master
GO
IF DB_ID('NikAmoozDB2022')>0
BEGIN
	ALTER DATABASE NikAmoozDB2022 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2022
END
GO
-------------------------------
--Filestream ایجاد بانک اطلاعاتی جدید به همراه فایل گروه 
USE master
GO
CREATE DATABASE NikAmoozDB2022
ON PRIMARY 
(
	NAME = NikAmoozDB2022,FILENAME = 'D:\Dump\TestFS\NikAmoozDB2022.mdf'
),
FILEGROUP FG_FileStream CONTAINS FILESTREAM
(
	NAME = NikAmoozDB2022_FSG,FILENAME ='D:\Dump\TestFS\NikAmoozDB2022_FSG'
)
LOG ON 
(
	NAME = NikAmoozDB2022_Log,FILENAME = 'D:\Dump\TestFS\NikAmoozDB2022_Log.ldf'
)
GO
--NTFS مشاهده فایل ها در 
GO
--Object Explorer بررسی نحوه ایجاد بانک اطلاعاتی در 
GO
USE NikAmoozDB2022
GO
--مشاهده فایل های مربوط به بانک اطلاعاتی
SP_HELPFILE
SELECT * FROM sys.database_files
GO
--مشاهده فایل گروه های مربوط به بانک اطلاعاتی
SP_HELPFILEGROUP
SELECT * FROM SYS.filegroups
GO
-------------------------------
--فرض کنید بانک اطلاعاتی از قبل وجود دارد و قرار است ما 
--به آن اضافه کنیم Filestream
GO
USE master
GO
IF DB_ID('NikAmoozDB2022')>0
BEGIN
	ALTER DATABASE NikAmoozDB2022 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2022
END
GO
CREATE DATABASE NikAmoozDB2022
ON PRIMARY 
(
	NAME = NikAmoozDB2022,FILENAME = 'D:\Dump\TestFS\NikAmoozDB2022.mdf'
)
LOG ON 
(
	NAME = NikAmoozDB2022_Log,FILENAME = 'D:\Dump\TestFS\NikAmoozDB2022_Log.ldf'
)
GO
USE NikAmoozDB2022
GO
--مشاهده فایل های مربوط به بانک اطلاعاتی
SP_HELPFILE
SELECT * FROM sys.database_files
GO
--مشاهده فایل گروه های مربوط به بانک اطلاعاتی
SP_HELPFILEGROUP
SELECT * FROM SYS.filegroups
GO
--Filestream اضافه کردن فایل گروه از نوع
ALTER DATABASE NikAmoozDB2022 ADD 
	FILEGROUP FG_FileStream CONTAINS FILESTREAM
GO
ALTER DATABASE NikAmoozDB2022 ADD FILE
(
	NAME = NikAmoozDB2022_FSG,FILENAME ='D:\Dump\TestFS\NikAmoozDB2022_FSG'
) TO FILEGROUP FG_FileStream
GO
--مشاهده فایل های مربوط به بانک اطلاعاتی
SP_HELPFILE
SELECT * FROM sys.database_files
GO
--مشاهده فایل گروه های مربوط به بانک اطلاعاتی
SP_HELPFILEGROUP
SELECT * FROM SYS.filegroups
GO
--Object Explorer بررسی در 
GO
