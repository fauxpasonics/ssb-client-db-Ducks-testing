SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [mdm].[vw_TM_STH]
AS

SELECT
	  dc.dimcustomerid
	, MAX(CASE WHEN dc.CustomerType = 'Primary' THEN 1 ELSE 0 END) AS PrimaryCustomer
	, MAX(CASE WHEN a.ETL__SSID_TM_ACCT_ID IS NOT NULL AND a.DimTicketTypeId IN (2,8,10) THEN 1 ELSE NULL END) AS sth
	, MAX(CASE WHEN a.ETL__SSID_TM_ACCT_ID IS NOT NULL AND a.DimTicketTypeId IN (2,8,10) THEN dd.CalDate ELSE NULL END) AS MaxSTHPurchaseDate
	, MAX(dc.UpdatedDate) AS MaxUpdatedDate
	, MAX(CASE WHEN a.ETL__SSID_TM_ACCT_ID IS NOT NULL AND a.DimTicketTypeId IN (3,4,6,9) THEN 1 ELSE NULL END) AS Grp
	, dc.accountid
	, MAX(CASE WHEN a.ETL__SSID_TM_ACCT_ID IS NOT NULL AND a.DimTicketTypeId IN (3,4,6,9) THEN dd.CalDate ELSE NULL END) AS MaxGRPPurchaseDate
	, MAX(CASE WHEN a.ETL__SSID_TM_ACCT_ID IS NOT NULL AND a.DimTicketTypeId IN (5) THEN 1 ELSE NULL END) AS Single
	, MAX(CASE WHEN a.ETL__SSID_TM_ACCT_ID IS NOT NULL AND a.DimTicketTypeId IN (5) THEN dd.CalDate ELSE NULL END) AS MaxSGLPurchaseDate
FROM	dbo.dimcustomer AS dc WITH (NOLOCK)
	LEFT OUTER JOIN dbo.FactTicketSales_V2 AS a WITH (NOLOCK) ON a.ETL__SSID_TM_acct_id = dc.AccountId AND dc.SourceSystem = 'TM'
	LEFT OUTER JOIN dbo.dimdate AS dd WITH (NOLOCK) ON a.DimDateId = dd.DimDateId
GROUP BY dc.dimcustomerid, dc.accountid;

GO
