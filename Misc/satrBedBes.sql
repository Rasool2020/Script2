IF NOT EXISTS(SELECT * FROM syscolumns WHERE id = OBJECT_ID('record_pay') AND name='satrBedID')
ALTER TABLE dbo.record_pay ADD satrBedID int NULL
Go
IF NOT EXISTS(SELECT * FROM syscolumns WHERE id = OBJECT_ID('record_pay') AND name='satrBesID')
ALTER TABLE dbo.record_pay ADD satrBesID int NULL
GO

IF NOT EXISTS(SELECT * FROM item_eza WHERE code=-7)
INSERT INTO dbo.item_eza
        ( code, name )
VALUES  ( -7, -- code - int
          '”‰Ê« '  -- name - varchar(50)
          )
GO
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[vw04Record_PayAccounts]') and OBJECTPROPERTY(id, N'IsView') = 1)
drop view [dbo].[vw04Record_PayAccounts]
GO
CREATE VIEW dbo.vw04Record_PayAccounts
AS
SELECT     dbo.item_eza.code, dbo.t04SalaryItemAccount.workCenterCode, dbo.t04SalaryItemAccount.rlink, dbo.t04SalaryItemAccount.tafzilicode, 
                      dbo.t04SalaryItemAccount.markazid, dbo.t04SalaryItemAccount.extendedAccountID, dbo.t04SalaryItemAccount.personnelTafziliIsUsed, 
                      dbo.t04SalaryItemAccount.PersonnelMarkazhazinehIsUsed
FROM         dbo.item_eza INNER JOIN
                      dbo.t04SalaryItem ON dbo.item_eza.code = dbo.t04SalaryItem.code LEFT OUTER JOIN
                      dbo.t04SalaryItemAccount ON dbo.t04SalaryItem.id = dbo.t04SalaryItemAccount.salaryItemID
WHERE     (dbo.item_eza.code = - 7)
GO


