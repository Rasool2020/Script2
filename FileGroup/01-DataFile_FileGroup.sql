IF DB_ID('ClinicDW2')>0
BEGIN
	ALTER DATABASE ClinicDW2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE ClinicDW2
END
GO
--ایجاد یک بانک اطلاعاتی ساده
CREATE DATABASE ClinicDW2
GO
USE ClinicDW2
GO
--مشاهده فایل های بانک اطلاعاتی 
SP_HELPFILE
GO
SELECT FILE_ID,name,size,max_size,growth FROM sys.database_files
GO
--------------------------------------------------------------------
USE master
GO
IF DB_ID('ClinicDW2')>0
BEGIN
	ALTER DATABASE ClinicDW2 SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE ClinicDW2
END
GO
--ایجاد بانک اطلاعاتی موجود در اسلاید
CREATE DATABASE ClinicDW2 
	ON  PRIMARY
	(
		NAME=ClinicDW2_Primary,FILENAME='D:\Database\ClinicDW2_Primary.mdf',SIZE=100MB
	),
	FILEGROUP FG_Dimension
	(
		NAME=Data_Dimension1,FILENAME='D:\Database\Data_Dimension1.ndf',SIZE=1GB,FILEGROWTH=1GB
	),
	(
		NAME=Data_Dimension2,FILENAME='D:\Database\Data_Dimension2.ndf',SIZE=1GB,FILEGROWTH=1GB
	),
	FILEGROUP FG_Fact
	(
		NAME=Data_Fact1,FILENAME='D:\Database\Data_Fact1.ndf',SIZE=1GB,FILEGROWTH=1GB
	),
	(
		NAME=Data_Fact2,FILENAME='D:\Database\Data_Fact2.ndf',SIZE=1GB,FILEGROWTH=1GB
	)
	LOG ON
	(
		NAME=ClinicDW2_Log,FILENAME='D:\Database\ClinicDW2_Log.LDF',SIZE=1GB,FILEGROWTH=512MB
	)
GO
--در نظر می گیریمUniform Extent حالا بانک را 
--این مدل به طور پیش فرض در نسخه 2016 مورد استفاده قرار می گیرد
--1118
ALTER DATABASE ClinicDW2 SET MIXED_PAGE_ALLOCATION OFF;
GO
--تنظیم نحوه رشد دیتا فایل ها
--1117
ALTER DATABASE ClinicDW2 MODIFY FILEGROUP FG_Fact AUTOGROW_ALL_FILES
ALTER DATABASE ClinicDW2 MODIFY FILEGROUP FG_Dimension AUTOGROW_ALL_FILES
GO
--بررسی ارسال جدول به فایل گروه