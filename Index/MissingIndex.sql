---توليد دستورات مربوط به ايجاد ايندكس
SELECT mid.statement, mid.equality_columns, Object_NAME(mid.object_id) TableName,
	   mig.index_group_handle,mid.index_handle,migs.avg_total_user_cost AS AvgTotalUserCostThatCouldbeReduced,
       migs.avg_user_impact AS AvgPercentageBenefit,'CREATE INDEX IXM_' + Object_NAME(mid.object_id)      
       + '_' + CONVERT (varchar, mid.index_handle)+ ' ON ' + mid.statement           
       + ' (' + ISNULL (mid.equality_columns,'')+ 
       CASE WHEN mid.equality_columns IS NOT NULL AND mid.inequality_columns             
       IS NOT NULL THEN ',' ELSE ''        
       END               
       + ISNULL (mid.inequality_columns, '') + ')' + 
       ISNULL (' INCLUDE (' + mid.included_columns + ')', '') + ' WITH(ONLINE=ON, SORT_IN_TEMPDB=ON) ON [Basic]' AS create_index_statement   
FROM sys.dm_db_missing_index_groups mig 
       JOIN sys.dm_db_missing_index_group_stats migs ON migs.group_handle = mig.index_group_handle 
       JOIN sys.dm_db_missing_index_details mid ON mig.index_handle = mid.index_handle
Where 1=1 
	And migs.avg_user_impact>30
	AND mid.statement LIKE '%TbTourismInvoice]%'
	--Eavar
	--And Not Object_NAME(mid.object_id) in ('TbTicketFlightFile', 'TbAccPayment', 'TbLegationTime', 'TbLogPassengerContact', 'TbPassengerDocument', 'TbSaleContractHdr', 'TbTourHdr', 'TbPassengerDocument', 'TbAccPayment', 'TbLegationTime', 'TbLogPassengerContact', 'TbLogPassengerContact', 'TbPassengerDocument', 'TbPassengerDocument', 'TbSaleContractHdr', 'TbTourHdr', 'TbAssignment', 
	--	'TbPassengerDocumentLog', 'TbLogAccPayment', 'TbLogPaymentMoneyItm', 'TbLogContractRoom', 'TbLogSaleContractTranslationItm', 'TbFlightItinerarySegment', 'TbChangeLog', 'TbFlightAggregation', 'TbFlight', 'AspNetUsers', 'TbFlightItem', 'TbFlightMinimumPriceCalendar', 'TbHotelBooking','TbTourismInvoice','TbHotelBookingSearchLog', 'TbHotelBookingEscort', 'TbJournal', 'TbProviderHotelDestination', 'TbTourismServiceBooking', 'TbNagaHotelDestination', 'TbUserPassenger')
	--And Not Object_NAME(mid.object_id) in ('TbJournal')
	--AND mid.statement like '%userpass%'
	--AND mid.statement = '[IPA_Eavar].[dbo].[TbSaleContractHdr]'
	--AND mid.statement Like '%Ready%'
	--And mid.equality_columns like '%city%'
	And mid.equality_columns='[price]'
Order By migs.avg_total_user_cost Desc
--Order By migs.avg_user_impact Desc
GO
[IPA_booking_ir].[hotel].[TbNagaHotelDestination]
--CREATE NONCLUSTERED INDEX IX_ordered_insertUserID
--ON [dbo].[ordered] ([insertUserID])
--INCLUDE ([t08ProjectID])
--GO
--sp_helpindex '[Hotel].[TbHotelRoomCapacity]'
GO
--sp_help '[Hotel].[TbHotelRoomCapacity]'
GO
sp_help '[IPA_booking_ir].[Utility].[TbAssignment]'
Go
sp_helpIndex '[IPA_booking_ir].[basic].[TbCity]'
Go
Select count(*) From [IPA_booking_ir].[Utility].[TbAssignment]
Go
Select * From [hotel].[TbNagaHotelDestination]
Go
CREATE INDEX IXM_TbNagaHotelDestination_LocationType ON [IPA_booking_ir].[hotel].[TbNagaHotelDestination] ([LocationType], [DestinationType], [CityId]) 
INCLUDE ([CountryCode], [CityCode], [Title]) WITH(ONLINE=ON, SORT_IN_TEMPDB=ON) ON Hotel
go
CREATE INDEX IXM_TbTicket_TicketDepartmentRef ON [IPA_booking_ir].[Messaging].[TbTicket] ([TicketDepartmentRef], [CompanyRef], [Status]) 
WITH(ONLINE=ON, SORT_IN_TEMPDB=ON, OPTIMIZE_FOR_SEQUENTIAL_KEY=ON) ON [Messaging]
Go
CREATE INDEX IXM_TbCity_Title ON [IPA_booking_ir].[basic].[TbCity] ([Title],[CityID]) WITH(ONLINE=ON, SORT_IN_TEMPDB=ON) ON [basic]