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
--Full Backups تهیه 
-----------------------------------
USE master
GO
BACKUP DATABASE Northwind TO DISK='C:\Temp1\Northwind_Full.bak' 
	WITH STATS=1
GO
USE msdb
GO
SELECT * FROM backupset
SELECT * FROM backupfile
GO
