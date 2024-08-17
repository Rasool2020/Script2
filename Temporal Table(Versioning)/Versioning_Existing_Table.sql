ALTER TABLE dbo.TbTicketFlightPassenger ADD StartTime DATETIME2
GO
ALTER TABLE dbo.TbTicketFlightPassenger ADD EndTime DATETIME2
Go
ALTER TABLE dbo.TbTicketFlightPassenger   
SET (SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TbTicketFlightPassengerChanges));
Go
UPDATE dbo.TbTicketFlightPassenger SET StartTime = '19000101 00:00:00.0000000', EndTime = '99991231 23:59:59.9999999'
GO
ALTER TABLE TbTicketFlightPassenger ALTER COLUMN StartTime DATETIME2 NOT NULL
GO
ALTER TABLE TbTicketFlightPassenger ALTER COLUMN EndTime DATETIME2 NOT NULL
GO
ALTER TABLE dbo.TbTicketFlightPassenger
ADD PERIOD FOR SYSTEM_TIME (StartTime, EndTime)
Go
ALTER TABLE dbo.TbTicketFlightPassenger
SET(SYSTEM_VERSIONING = ON (HISTORY_TABLE = dbo.TbTicketFlightPassenger_Changes, DATA_CONSISTENCY_CHECK = ON))
GO
