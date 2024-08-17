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
--SQL Linux و بازیابی آن در SQL Windows تهیه نسخه پشتیبان در 
GO
--SQL Windows اتصال به 
USE master
GO
PRINT @@version
GO
--------------------------------------------------------------------
--ساخت بانک اطلاعاتی برای بررسی فایل های مربوط به آن
USE master
GO
IF DB_ID('NikAmoozDB2017_Widnows')>0
BEGIN
	ALTER DATABASE NikAmoozDB2017_Widnows SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2017_Widnows
END
GO
CREATE DATABASE NikAmoozDB2017_Widnows
GO
USE NikAmoozDB2017_Widnows
GO
--مشاهده مسیر قرار گرفتن فایل ها 
SP_HELPFILE
GO
DROP TABLE IF EXISTS Employees
GO
CREATE TABLE Employees
(
	ID INT PRIMARY KEY,
	FullName NVARCHAR(100)
)
GO
INSERT INTO Employees (ID,FullName) VALUES 
	(1,N'مسعود طاهری*Windows'),
	(2,N'فرید طاهری*Windows'),
	(3,N'علیرضا طاهری*Windows')
GO
SELECT * FROM Employees
GO
--------------------------------------------------------------------
--SQL Windows تهیه نسخه پشتیبان در 
USE master
GO
BACKUP DATABASE NikAmoozDB2017_Widnows TO DISK ='C:\Dump\NikAmoozDB2017_Widnows.bak'
	WITH FORMAT
GO
/*
Home کپی فایل بکاپ از ویندوز به لینوکس در شاخه  

--باز کردن ترمینال 
-----
--Sudo اجرای 
sudo su
-----
--کپی فایل بکاپ به مسیری که دسترسی داریم
cp /home/taheri/NikAmoozDB2017_Widnows.bak /var/opt/mssql/data
-----
--برداشتن دسترسی
cd /var/opt/mssql/data
chmod 777 NikAmoozDB2017_Widnows.bak
chmod mssql:mssql NikAmoozDB2017_Widnows.bak
*/
--------------------------------------------------------------------
USE master
GO
--SQL Linux تغییر اتصال به 
GO
PRINT @@VERSION
GO
RESTORE HEADERONLY FROM DISK='/var/opt/mssql/data/NikAmoozDB2017_Widnows.bak'  
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='/var/opt/mssql/data/NikAmoozDB2017_Widnows.bak'  
GO
--مشاهده فایل های موجود در بکاپ ست
RESTORE FILELISTONLY FROM DISK='/var/opt/mssql/data/NikAmoozDB2017_Widnows.bak'  
GO
USE master
GO
IF DB_ID('NikAmoozDB2017_Widnows')>0
BEGIN
	ALTER DATABASE NikAmoozDB2017_Widnows SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2017_Widnows
END
GO
RESTORE DATABASE NikAmoozDB2017_Widnows FROM  DISK = N'/var/opt/mssql/data/NikAmoozDB2017_Widnows.bak' WITH  
	MOVE N'NikAmoozDB2017_Widnows' TO N'/var/opt/mssql/data/NikAmoozDB2017_Widnows.mdf',  
	MOVE N'NikAmoozDB2017_Widnows_log' TO N'/var/opt/mssql/data/NikAmoozDB2017_Widnows_log.ldf', 
	STATS=1
GO
USE NikAmoozDB2017_Widnows
GO
SELECT * FROM Employees
GO


	

http://linuxihaa.ir/samba/
http://ubuntunews.ir/samba-file-sharing/

http://asklinux.ir/8698/%D9%86%D8%B5%D8%A8-%D8%B3%D8%A7%D9%85%D8%A8%D8%A7-%D8%A8%D8%B5%D9%88%D8%B1%D8%AA-%DA%AF%D8%B1%D8%A7%D9%81%DB%8C%DA%A9%DB%8C