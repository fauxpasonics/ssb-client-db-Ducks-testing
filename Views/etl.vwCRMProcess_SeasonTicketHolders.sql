SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [etl].[vwCRMProcess_SeasonTicketHolders]
AS

--updateme if using STH functionality
SELECT DISTINCT dc.SSID
, NULL SeasonYear
, NULL SeasonYr
FROM ro.vw_FactTicketSales ts
INNER JOIN dbo.DimCustomer dc ON dc.ssid = ts.ETL__SSID_TM_acct_id AND dc.sourcesystem = 'tm' AND dc.CustomerType = 'Primary'
WHERE 0=1
GO
