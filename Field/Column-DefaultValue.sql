use sSepidehCRM0724
Go
if object_id('f00CurrentUserID4')>0
Drop FUNCTION dbo.f00CurrentUserID4
Go
Create FUNCTION dbo.f00CurrentUserID4()    
RETURNS int    
AS    
BEGIN    
 DECLARE @s AS int    
 SELECT @s = userID 
 From t00ProcessActiveBranch With(snapshot)
 Where spID = @@spID    
 RETURN ISNull(@s ,1)  
END
Go
if object_id('f00CurrentEnteranceID4')>0
Drop FUNCTION dbo.f00CurrentEnteranceID4
Go
Create FUNCTION dbo.f00CurrentEnteranceID4()
RETURNS int        
AS        
BEGIN        
 DECLARE @s AS int        
 SELECT @s = enteranceID 
 From t00ProcessActiveBranch With(snapshot)
 Where spID = @@spID        
 RETURN Isnull(@s,-1)    
END
Go
SELECT  
        --b.name AS TABLE_NAME,
        --d.name AS COLUMN_NAME,
        --a.name AS CONSTRAINT_NAME,
        --c.text AS DEFAULT_VALUE,
		--'DROP CONSTRAINT' as #2,
		--'ADD CONSTRAINT' as #3,
		'#1 ' + b.name + ' #2 ' + a.name + char(13) + char(10) +
		'#1 ' + b.name + ' #3 ' + a.name + ' DEFAULT ([dbo].[f00CurrentEnteranceID4]()) FOR ' + d.name
FROM sys.sysobjects a JOIN
        (SELECT name, id
         FROM sys.sysobjects 
         WHERE xtype = 'U') b on (a.parent_obj = b.id)
                      JOIN sys.syscomments c ON (a.id = c.id)
                      JOIN sys.syscolumns d ON (d.cdefault = a.id)
 WHERE a.xtype = 'D' 
	--And b.name = 'ordered' 
	And c.text like '%f00Currenten%'
 ORDER BY b.name, a.name
 Go
 SELECT  
        --b.name AS TABLE_NAME,
        --d.name AS COLUMN_NAME,
        --a.name AS CONSTRAINT_NAME,
        --c.text AS DEFAULT_VALUE,
		--'Alter Table' as #1,
		--'DROP CONSTRAINT' as #2,
		--'ADD CONSTRAINT' as #3,
		'#1 ' + b.name + ' #2 ' + a.name + char(13) + char(10) +
		'#1 ' + b.name + ' #3 ' + a.name + ' DEFAULT ([dbo].[f00CurrentUserID4]()) FOR ' + d.name
FROM sys.sysobjects a JOIN
        (SELECT name, id
         FROM sys.sysobjects 
         WHERE xtype = 'U') b on (a.parent_obj = b.id)
                      JOIN sys.syscomments c ON (a.id = c.id)
                      JOIN sys.syscolumns d ON (d.cdefault = a.id)
 WHERE a.xtype = 'D' 
	--And b.name = 'ordered' 
	And c.text like '%f00Currentus%'
 ORDER BY b.name, a.name
 Go
 