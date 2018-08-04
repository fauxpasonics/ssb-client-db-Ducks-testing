SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[Eloqua_Ticket_Transactions_Outbound] AS
--max etl created date
SELECT ETL__SSID_TM_acct_id
	  ,f.ETL__CreatedDate
	  ,f.FactTicketSalesId
	  ,m.EmailPrimary	
	  ,m.AccountRep
	  ,t.TicketTypeName
	  ,e.EventCode
	  ,e.EventDate
	  ,e.EventDateTime
	  ,s.SeatTypeName
	  , CONCAT(se.SectionName, + ':', + se.RowName, + ':', + se.Seat) AS SeatLocation
	  ,f.QtySeat
--select count (*)
FROM dbo.FactTicketSales_V2 f WITH (NOLOCK)--443617
JOIN dbo.DimTicketType_V2 t WITH (NOLOCK)
ON t.DimTicketTypeId = f.DimTicketTypeId--443617
JOIN dbo.DimEvent_V2 e WITH (NOLOCK)
ON e.DimEventId = f.DimEventId
JOIN dbo.DimSeatType_V2 s WITH (NOLOCK)
ON s.DimSeatTypeId = f.DimSeatTypeId
JOIN dbo.DimSeat_V2 se WITH (NOLOCK)
ON se.ETL__SSID_TM_section_id = f.ETL__SSID_TM_section_id AND se.ETL__SSID_TM_row_id = f.ETL__SSID_TM_row_id AND se.ETL__SSID_TM_seat = f.ETL__SSID_TM_seat_num
JOIN dbo.vwDimCustomer_ModAcctId m WITH (NOLOCK)
ON f.ETL__SSID_TM_acct_id = m.AccountId AND m.SourceSystem = 'TM' AND m.CustomerType = 'Primary' 
WHERE f.ETL__SSID_TM_acct_id <> -1
AND f.DimSeasonId IN (27,10,35)
--AND f.ETL__CreatedDate > = (GETDATE() - 1)
GO
