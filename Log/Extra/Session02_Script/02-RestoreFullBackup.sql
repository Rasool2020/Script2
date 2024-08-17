﻿--------------------------------------------------------------------
/*
SQL Server 2017 در High Availability دوره 
Site:        http://www.NikAmooz.com
Email:       Info@NikAmooz.com
Instagram:   https://instagram.com/nikamooz/
Telegram:	 https://telegram.me/nikamooz
Created By:  Masoud Taheri 
*/
--------------------------------------------------------------------
USE master
GO
/*
تهیه فول بکاپ
بازیابی در مسیر دیگر و اسم دیگر
SSMS بررسی در 
*/
BACKUP DATABASE Northwind TO DISK='C:\temp1\Nw_Full.bak'
GO
RESTORE LABELONLY FROM  DISK='C:\temp1\Nw_Full.bak'
GO
RESTORE FILELISTONLY FROM   DISK='C:\temp1\Nw_Full.bak'
GO
RESTORE DATABASE Northwind2 FROM  DISK='C:\temp1\Nw_Full.bak' WITH 
MOVE 'Northwind' TO 'E:\DUMP\Northwind.mdf',
MOVE 'Northwind_log' TO 'E:\DUMP\Northwind_log.ldf',
STATS=1


\