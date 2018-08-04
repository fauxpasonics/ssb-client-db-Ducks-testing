SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


/*****	Revision History

2018-08-02 by SJS	-	added SeasonTicketInterest
2018-08-02 by SAS	-	Change YES values to the date of the upload

*****/

CREATE PROC [etl].[Eloqua_DimAttribute_Fields]
AS


EXEC etl.Dimcustomer_Attributes_Pivot;

TRUNCATE TABLE ods.Eloqua_datauploaderfields;


IF OBJECT_ID('tempdb.Ducks.#datauploaderfields') IS NOT NULL
BEGIN
	DROP TABLE #datauploaderfields
END


SELECT DISTINCT m.SSB_CRMSYSTEM_CONTACT_ID
	,m.EmailPrimary
	,a.TextClubOptIn
	,a.TicketDealsOptIn
	,a.FanNewsLetterOptIn
	,a.GroupInterest
	,a.MiniPlanInterest
	,a.SingleGameTicketInterest
	,a.SuiteInterest
	,a.SeasonTicketInterest
	,a.CreatedDate
	,ROW_NUMBER() OVER(PARTITION BY m.EmailPrimary ORDER BY a.TextClubOptIn DESC, a.TicketDealsOptIn DESC, a.FanNewsLetterOptIn DESC, a.GroupInterest DESC
															,a.MiniPlanInterest, a.SingleGameTicketInterest DESC, a.SuiteInterest DESC) rowrank
INTO #rankedemails
FROM ods.Dimcustomer_Attributes_Pivot a
JOIN dbo.vwDimCustomer_ModAcctId m
ON m.DimCustomerId = a.dimcustomerid;



INSERT INTO ods.Eloqua_datauploaderfields
SELECT SSB_CRMSYSTEM_CONTACT_ID,
	EmailPrimary,
	case when TextClubOptIn				= 'Yes' then cast(createddate as date) else null END TextClubOptIn,
	case when TicketDealsOptIn			= 'Yes' then cast(createddate as date) else null end TicketDealsOptIn,
	case when FanNewsletterOptIn		= 'Yes' then cast(createddate as date) else null end FanNewsletterOptIn,
	case when GroupInterest				= 'Yes' then cast(createddate as date) else null end GroupInterest,
	case when MiniPlanInterest			= 'Yes' then cast(createddate as date) else null end MiniPlanInterest,
	case when SingleGameTicketInterest	= 'Yes' then cast(createddate as date) else null end SingleGameTicketInterest,
	case when SuiteInterest				= 'Yes' then cast(createddate as date) else null end SuiteInterest,
	case when SeasonTicketInterest		= 'Yes' then cast(createddate as date) else null end SeasonTicketInterest		
FROM #rankedemails
WHERE rowrank = 1;


GO
