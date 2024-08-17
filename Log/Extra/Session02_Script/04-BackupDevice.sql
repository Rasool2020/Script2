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
USE master
GO
--بر روي ديسكBackupDeviceايجاد
--هنوز فايل ايجاد نشده است و هنگام تهيه نسخه پشتيبان فايل ايجاد مي شود
EXEC sp_addumpdevice  'disk', 'mydiskdump', 'c:\TEMP1\dump.bak'
GO
--بر روي تيپBackupDeviceايجاد
EXEC sp_addumpdevice 'tape', 'tapedump1', '\\.\tape0'
GO
--بر روي شبكهBackupDeviceايجاد
EXEC sp_addumpdevice 'disk', 'networkdevice',
    '\\192.168.80.94\New folder\TEST.BAK'
GO
--ها BackupDeviceاستخراج اطلاعاتي درباره
SP_HELPDEVICE
GO
SP_HELPDEVICE 'mydiskdump'
GO
SELECT * FROM SYS.backup_devices
GO
--بدون فايلBackupDeviceحرف
EXEC sp_dropdevice   'mydiskdump'
GO
--با فايلBackupDeviceحرف
EXEC sp_dropdevice   'mydiskdump','DELFILE'
GO
BACKUP DATABASE Northwind TO DISK ='mydiskdump'
BACKUP DATABASE Northwind TO mydiskdump
BACKUP DATABASE msdb TO mydiskdump

RESTORE LABELONLY FROM mydiskdump
RESTORE HEADERONLY FROM mydiskdump

RESTORE HEADERONLY FROM DISK='C:\TEMP1\dump.bak'






/*
--Media Header
RESTORE LABELONLY FROM DISK=..... 

--Backupset Header
RESTORE HEADERONLY FROM DISK=..... WITH FILE=N

--Backupset File
RESTORE FILELISTONLY FROM DISK=.... WITH FILE=N
*/
--برای این موضوع فراهم شود SSMS استفاده از 
GO
