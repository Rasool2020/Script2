--SQL Server لاگ 
USE MASTER
GO
EXEC xp_readerrorlog
GO
EXEC xp_readerrorlog 0, 1, N'Logging SQL Server messages in file'
GO
--مشاهده تعداد هسته های دیتکت شده
EXEC sys.xp_readerrorlog 0, 1, N'detected', N'socket';
GO
/*
SQL Server detected 2 sockets with 14 cores per socket and 28 logical processors per socket,
56 total logical processors; using 56 logical processors based on SQL Server licensing. 
This is an informational message;no user action is required.

*/
--SQLServerManager16.msc عوض کردن مسیر از طریق برنامه 
GO
--پاک کردن فایل های مربوط به خطا
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'NumErrorLogs', REG_DWORD, 6
GO
-- و پاک کردن فایل ها Object Explorer کلیک راست در 
GO
