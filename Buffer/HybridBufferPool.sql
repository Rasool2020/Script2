USE master
GO
--Hybrid Buffer Pool بررسی فعال بودن
SELECT 
	* 
FROM sys.server_memory_optimized_hybrid_buffer_pool_configuration
GO
--Buffer Pool تنظیم کردن 
ALTER SERVER CONFIGURATION SET MEMORY_OPTIMIZED HYBRID_BUFFER_POOL = ON;
GO
USE master
GO
--برای یک دیتابیس خاص HBP فعال کردن 
ALTER DATABASE <databaseName> SET MEMORY_OPTIMIZED = ON;
GO 
----برای یک دیتابیس خاص HBP غیر فعال کردن کردن  
ALTER DATABASE <databaseName> SET MEMORY_OPTIMIZED = OFF;