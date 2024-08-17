sp_configure 'show advanced options', 1 ;  
GO  
RECONFIGURE ;  
GO  
sp_configure 'blocked process threshold', 5 ;  
GO  
RECONFIGURE ;  
GO  
/*
	Extended View Events
Category Errors:
Attention
Blocked_process_report**
Error_reported (Channel Admin)
Exchange_spill
Execution_warning

*/

