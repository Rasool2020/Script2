sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'Database Mail XPs', 1;  
GO  
RECONFIGURE  
GO  
IF EXISTS (
    SELECT 1 FROM sys.configurations 
    WHERE NAME = 'Database Mail XPs' AND VALUE = 0)
BEGIN
  PRINT 'Enabling Database Mail XPs'
  EXEC sp_configure 'show advanced options', 1;  
  RECONFIGURE
  EXEC sp_configure 'Database Mail XPs', 1;  
  RECONFIGURE  
END
Go
/*
Incoming Mail (IMAP) Server	
imap.gmail.com

Requires SSL: Yes

Port: 993

Outgoing Mail (SMTP) Server	
smtp.gmail.com

Requires SSL: Yes

Requires TLS: Yes (if available)

Requires Authentication: Yes

Port for SSL: 465

Port for TLS/STARTTLS: 587
*/


/*
Live.com (Outlook.com) SMTP Server	smtp.office365.com
SMTP port	587
SMTP security	STARTTLS
SMTP username	Your full email address
SMTP password	Your Live.com password
*/

R.Aghajani@Gmail.com
LV
Bing123456
Go

EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = 'Mudassar_Mail_Account'
   ,@description = 'Send emails using SQL Server Stored Procedure'
   ,@email_address = 'youremail@gmail.com'
   ,@display_name = 'Mudassar Ahmed Khan'
   ,@replyto_address = 'youremail@gmail.com'
   ,@mailserver_name = 'smtp.gmail.com'
   ,@username = 'youremail@gmail.com'
   ,@password = 'GMAIL PASSWORD'
   ,@port = 587
   ,@enable_ssl = 1
GO

--	Adding Profile

EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'Mudassar_Email_Profile'
   ,@description = 'Send emails using SQL Server Stored Procedure'
GO

--	Adding Account to Profile for sending email in SQL Server

EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'Mudassar_Email_Profile'
   ,@account_name = 'Mudassar_Mail_Account'
   ,@sequence_number = 1
GO

--	List Mailing Profile

Select * From msdb.dbo.sysmail_profile
Go
EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Mai-Booking'
   ,@recipients = 'R.Aghajani@gmail.com'
   ,@subject = 'Email from SQL Server Test'
   ,@body = 'This is my First Email sent from SQL Server :)'
   ,@importance ='HIGH'
Go
sp_helptext 'msdb.dbo.sysmail_verify_profile_sp'