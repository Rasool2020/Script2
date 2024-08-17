------Should be setup ODBC version 64
------https://www.mssqltips.com/sqlservertip/4577/create-a-linked-server-to-mysql-from-sql-server/

EXEC master.dbo.sp_addlinkedserver @server = N'daraje',@datasrc=N'daraje', @srvproduct=N'daraje', @provider=N'MSDASQL', @provstr=N'DRIVER={daraje}; SERVER=localhost;DATABASE=daraje; USER=root;PASSWORD=password; OPTION=3'

EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'Daraje',@useself=N'True',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'collation compatible', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'data access', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'dist', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'pub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'rpc', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'rpc out', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'sub', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'connect timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'collation name', @optvalue=null
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'lazy schema validation', @optvalue=N'false'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'query timeout', @optvalue=N'0'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'use remote collation', @optvalue=N'true'
EXEC master.dbo.sp_serveroption @server=N'Daraje', @optname=N'remote proc transaction promotion', @optvalue=N'true'
