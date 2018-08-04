SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE VIEW [dbo].[vw_KeyAccounts]

AS 



SELECT DISTINCT dc.dimcustomerId, dc.ssb_crmsystem_contact_id ssbid, dc.ssid
FROM Ducks_reporting.prodcopy.contact z WITH (NOLOCK) 
		JOIN ducks.dbo.dimcustomerssbid dc WITH (NOLOCK) ON CAST(z.contactid AS NVARCHAR(100)) = dc.ssid AND dc.sourcesystem = 'CRM_Contact'
		WHERE z.str_clientdonotmerge = '1'

--WITH SSBID AS (
--	SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID
--	FROM mdm.vw_TM_STH vw
--	JOIN dbo.dimcustomerssbid ssbid ON vw.dimcustomerid = ssbid.DimCustomerid
--	WHERE vw.STH = 1 OR vw.Suite = 1
--	)



--SELECT dc.DimCustomerID, ssbid.SSB_CRMSYSTEM_CONTACT_ID SSBID, dc.SSID
--FROM SSBID vw
--JOIN dbo.dimcustomerssbid ssbid ON vw.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
--JOIN dbo.dimcustomer dc ON ssbid.DimCustomerid = dc.DimCustomerId
--WHERE dc.SourceSystem = 'CRM_Contact'

--SELECT DimCustomerId, SSB_CRMSYSTEM_CONTACT_ID AS ssbid, ssid FROM dbo.vwDimCustomer_ModAcctId WHERE 1= 2




GO
