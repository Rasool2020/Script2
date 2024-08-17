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
--SQL Windows و بازیابی آن در SQL Linux تهیه نسخه پشتیبان در 
GO
--SQL Linux اتصال به 
USE master
GO
PRINT @@version
GO
--------------------------------------------------------------------
--ساخت بانک اطلاعاتی برای بررسی فایل های مربوط به آن
USE master
GO
IF DB_ID('NikAmoozDB2017_Linux')>0
BEGIN
	ALTER DATABASE NikAmoozDB2017_Linux SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2017_Linux
END
GO
CREATE DATABASE NikAmoozDB2017_Linux
GO
USE NikAmoozDB2017_Linux
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
	(1,N'مسعود طاهری*Linux'),
	(2,N'فرید طاهری*Linux'),
	(3,N'علیرضا طاهری*Linux')
GO
SELECT * FROM Employees
GO
--------------------------------------------------------------------
--SQL Linux تهیه نسخه پشتیبان در 
USE master
GO
BACKUP DATABASE NikAmoozDB2017_Linux TO DISK ='/var/opt/mssql/data/NikAmoozDB2017_Linux.bak'
	WITH FORMAT
GO
/*
کپی فایل از لینوکس به ویندوز

--باز کردن ترمینال 
-----
--Sudo اجرای 
sudo su
-----
--کپی فایل بکاپ به مسیری که دسترسی داریم
cp /var/opt/mssql/data/NikAmoozDB2017_Linux.bak /home/taheri
-----
--برداشتن دسترسی
chmod 777 NikAmoozDB2017_Linux.bak
--SQL Server انتقال فایل به ویندوز و بازیابی آن در 
*/
--------------------------------------------------------------------
USE master
GO
--SQL Windows تغییر اتصال به 
GO
PRINT @@VERSION
GO
RESTORE HEADERONLY FROM DISK='C:\Dump\NikAmoozDB2017_Linux.bak'  
GO
--Backupset Header
RESTORE HEADERONLY FROM DISK='C:\Dump\NikAmoozDB2017_Linux.bak'  
GO
--مشاهده فایل های موجود در بکاپ ست
RESTORE FILELISTONLY FROM DISK='C:\Dump\NikAmoozDB2017_Linux.bak'  
GO
USE master
GO
IF DB_ID('NikAmoozDB2017_Linux')>0
BEGIN
	ALTER DATABASE NikAmoozDB2017_Linux SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE NikAmoozDB2017_Linux
END
GO
RESTORE DATABASE NikAmoozDB2017_Linux FROM DISK='C:\Dump\NikAmoozDB2017_Linux.bak' WITH 
MOVE 'NikAmoozDB2017_Linux' TO 'C:\Dump\NikAmoozDB2017_Linux.mdf',
MOVE 'NikAmoozDB2017_Linux_log' TO 'C:\Dump\NikAmoozDB2017_Linux_log.ldf',
STATS=1
GO
USE NikAmoozDB2017_Linux
GO
SELECT * FROM Employees
GO


	

