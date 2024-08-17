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
--Restoring to a Point in Time
--ساعت به 9 صبح تغيير داده شود
USE master
GO
DROP DATABASE NEWDB
GO
CREATE DATABASE NEWDB
GO
USE newdb
GO
CREATE TABLE T1
(
	F1 INT PRIMARY KEY,
	F2 NVARCHAR(20) 
)
GO
DELETE FROM T1
GO
INSERT INTO T1 VALUES (1,'A')
INSERT INTO T1 VALUES (2,'B')
INSERT INTO T1 VALUES (3,'C')
INSERT INTO T1 VALUES (4,'D')
SELECT * FROM T1
GO
BACKUP DATABASE NEWDB TO DISK='C:\TEMP1\NEWDB.BAK' 
	WITH NAME='FULL' ,DESCRIPTION=N'Restoring to a Point in Time',FORMAT

RESTORE HEADERONLY FROM DISK='C:\TEMP1\NEWDB.BAK' --مشاهده بكاپ ست
--مجموعه مثال هاي فوق ساعت تنظيم گردد
--مجموعه تغييرات اول در ساعت 11
UPDATE T1 SET F2='*11*'
SELECT * FROM T1
GO
--مجموعه مثال هاي فوق ساعت تنظيم گردد
--مجموعه تغييرات اول در ساعت 12
UPDATE T1 SET F2='*12*'
SELECT * FROM T1
--مجموعه مثال هاي فوق ساعت تنظيم گردد
--مجموعه تغييرات اول در ساعت 12:30
UPDATE T1 SET F2='*12:30*'
SELECT * FROM T1
GO
--مجموعه مثال هاي فوق ساعت تنظيم گردد
--مجموعه تغييرات اول در ساعت 13
UPDATE T1 SET F2='*13*'
SELECT * FROM T1
GO
--در ساعت 13:30 لاگ بكاپ داريم
BACKUP LOG NEWDB TO DISK='C:\TEMP1\NEWDB.BAK' WITH NAME='LOG-13:30' ,DESCRIPTION=N'ساعت 13:30'
RESTORE HEADERONLY FROM DISK='C:\TEMP1\NEWDB.BAK' --مشاهده بكاپ ست
GO
--مي خواهيم برگرديم به ساعت 12:45
USE master
RESTORE DATABASE NEWDB FROM DISK ='C:\TEMP1\NEWDB.BAK' WITH FILE=1,STATS=5,REPLACE,
STANDBY='C:\TEMP1\NEWDB.UNDO' --به وضعيت بانك توجه شود

RESTORE DATABASE NEWDB FROM DISK ='C:\TEMP1\NEWDB.BAK' --به وضعيت بانك توجه شود
	WITH FILE=2,STATS=2,STANDBY='C:\TEMP1\NEWDB.UNDO' ,
		STOPAT='2017-10-20 12:45:00'		
GO		
RESTORE DATABASE NEWDB FROM DISK ='C:\TEMP1\NEWDB.BAK' WITH RECOVERY
GO