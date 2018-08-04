SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE PROCEDURE [etl].[Load_Eloqua_EmailSummary_MSCRM]
AS


---Deletes any records less than 6 months old
DELETE FROM etl.Eloqua_EmailSummary_MSCRM_Limited
WHERE etl_updateddate < (GETDATE() -180)


/*========================================================================================================
	Create distinct list of SSB_CRMSYSTEM_CONTACT_IDs and Email Addresses
========================================================================================================*/
SELECT DISTINCT dc.SSB_CRMSYSTEM_CONTACT_ID, dc.EmailPrimary
INTO #EmailMatches
FROM dbo.vwDimCustomer_ModAcctId dc
WHERE dc.SSB_CRMSYSTEM_CONTACT_ID IS NOT NULL
	AND dc.EmailPrimary IS NOT NULL
	AND dc.EmailPrimary <> ''
	AND dc.EmailPrimaryIsCleanStatus = 'Valid'

CREATE NONCLUSTERED INDEX idx_EmailMatches ON #EmailMatches(EmailPrimary);

/*========================================================================================================
	Map SSBID to mailing summary on email address
========================================================================================================*/
/*		edited by DCH on 2017-09-01

SELECT match.SSB_CRMSYSTEM_CONTACT_ID
	, em.MemberID
	, em.Email
	, emd.MailingID
	, emd.[Name] MailingName
	, emd.PublicWebviewURL
	, ed.Result DeliveryResult
	, COUNT(ed.ETL__ID) DeliveryCount
	, MIN(ed.[Timestamp]) MinDeliveryTime
	, COUNT(eo.ETL__ID) OpenCount
	, MIN(eo.[Timestamp]) MinOpenTime
	, COUNT(ec.ETL__ID) ClickCount
	, MIN(ec.[Timestamp]) MinClickTime
INTO #MappedGUIDs
FROM  ods.Emma_Members em (NOLOCK)
JOIN ods.Emma_MailingDetails_Members emm (NOLOCK)
	ON em.MemberID = emm.MemberID
JOIN ods.Emma_MailingDetails emd (NOLOCK)
	ON emd.MailingID = emm.MailingID
LEFT JOIN ods.Emma_Deliveries ed (NOLOCK)
	ON ed.Mailing = emm.MailingID
LEFT JOIN ods.Emma_Opens eo (NOLOCK)
	ON eo.mailing = emm.MailingID
LEFT JOIN ods.Emma_Clicks ec (NOLOCK)
	ON ec.Mailing = emm.MailingID
LEFT JOIN #EmailMatches match
	ON match.EmailPrimary = em.Email
GROUP BY match.SSB_CRMSYSTEM_CONTACT_ID, em.MemberID, em.Email, emd.MailingID, emd.[Name], emd.PublicWebviewURL, ed.Result

*/


SELECT DISTINCT assetname 
INTO  #CRMAssetnames
FROM ods.Eloqua_ActivityEmailSend
WHERE AssetName like '%CRM%'


-----------------------------------------------------------------------------------------------

--	first step
SELECT match.SSB_CRMSYSTEM_CONTACT_ID
	, c.ID AS MemberID
	, c.Emailaddress AS Email
	, s.AssetID AS MailingID
	, s.AssetName AS MailingName
	, s.EmailWebLink AS PublicWebViewURL
	, s.AssetType AS DeliveryResult
	, COUNT(s.ID) DeliveryCount
	, MIN(s.CreatedAt) MinDeliveryTime
	, MAX(s.CreatedAt) MaxDeliveryTime
INTO #MappedGUIDs_1
FROM  ods.Eloqua_Contact c (NOLOCK)
JOIN ods.Eloqua_ActivityEmailSend s (NOLOCK)
	ON c.id= s.ContactId
JOIN ods.eloqua_flagged_emails fs
ON fs.assetname = s.AssetName		-- OR s.AssetName LIKE '%CRM%'		this will not work
--LEFT JOIN #CRMAssetnames CRM
--ON crm.assetname = s.AssetName 
LEFT JOIN #EmailMatches match
	ON match.EmailPrimary = c.EmailAddress
WHERE s.CreatedAt >= GETDATE()-180
GROUP BY match.SSB_CRMSYSTEM_CONTACT_ID, c.ID, c.EmailAddress, s.AssetID, s.AssetName, s.EmailWebLink, s.AssetType

UNION ALL

--	first step
SELECT match.SSB_CRMSYSTEM_CONTACT_ID
	, c.ID AS MemberID
	, c.Emailaddress AS Email
	, s.AssetID AS MailingID
	, s.AssetName AS MailingName
	, s.EmailWebLink AS PublicWebViewURL
	, s.AssetType AS DeliveryResult
	, COUNT(s.ID) DeliveryCount
	, MIN(s.CreatedAt) MinDeliveryTime
	, MAX(s.CreatedAt) MaxDeliveryTime
FROM  ods.Eloqua_Contact c (NOLOCK)
JOIN ods.Eloqua_ActivityEmailSend s (NOLOCK)
	ON c.id= s.ContactId
JOIN #CRMAssetnames fs
ON fs.assetname = s.AssetName --OR s.AssetName LIKE '%CRM%'
--LEFT JOIN #CRMAssetnames CRM
--ON crm.assetname = s.AssetName 
LEFT JOIN #EmailMatches match
	ON match.EmailPrimary = c.EmailAddress
WHERE s.CreatedAt >= GETDATE()-180
GROUP BY match.SSB_CRMSYSTEM_CONTACT_ID, c.ID, c.EmailAddress, s.AssetID, s.AssetName, s.EmailWebLink, s.AssetType;


-----------------------------------------------------------------------------------------------

--	add opens
SELECT EL.SSB_CRMSYSTEM_CONTACT_ID
	, EL.MemberID
	, EL.Email
	, EL.MailingID
	, EL.MailingName
	, EL.PublicWebviewURL
	, EL.DeliveryResult
	, EL.DeliveryCount
	, EL.MinDeliveryTime
	, EL.MaxDeliveryTime
	, COUNT(o.ID) OpenCount
	, MIN(o.CreatedAt) MinOpenTime
INTO #MappedGUIDs_2
FROM #MappedGUIDs_1 EL
JOIN ods.eloqua_flagged_emails fs
ON fs.assetname = el.MailingName
--LEFT JOIN #CRMAssetnames CRM
--ON crm.assetname = el.MailingName 
LEFT JOIN ods.Eloqua_ActivityEmailOpen o (NOLOCK)
	ON o.contactID = el.memberID AND o.assetid = el.MailingID
GROUP BY el.SSB_CRMSYSTEM_CONTACT_ID, EL.MemberID, EL.Email, EL.MailingID, EL.MailingName, EL.PublicWebviewURL
	, EL.DeliveryResult, EL.DeliveryCount, EL.MinDeliveryTime, EL.MaxDeliveryTime
	
UNION ALL

SELECT EL.SSB_CRMSYSTEM_CONTACT_ID
	, EL.MemberID
	, EL.Email
	, EL.MailingID
	, EL.MailingName
	, EL.PublicWebviewURL
	, EL.DeliveryResult
	, EL.DeliveryCount
	, EL.MinDeliveryTime
	, EL.MaxDeliveryTime
	, COUNT(o.ID) OpenCount
	, MIN(o.CreatedAt) MinOpenTime
FROM #MappedGUIDs_1 EL
JOIN #CRMAssetnames fs
ON fs.assetname = el.MailingName
LEFT JOIN ods.Eloqua_ActivityEmailOpen o (NOLOCK)
	ON o.contactID = el.memberID AND o.assetid = el.MailingID
GROUP BY el.SSB_CRMSYSTEM_CONTACT_ID, EL.MemberID, EL.Email, EL.MailingID, EL.MailingName, EL.PublicWebviewURL
	, EL.DeliveryResult, EL.DeliveryCount, EL.MinDeliveryTime, EL.MaxDeliveryTime;


-----------------------------------------------------------------------------------------------

--	add clicks
SELECT EL.SSB_CRMSYSTEM_CONTACT_ID
	, EL.MemberID
	, EL.Email
	, EL.MailingID
	, EL.MailingName
	, EL.PublicWebviewURL
	, EL.DeliveryResult
	, EL.DeliveryCount
	, EL.MinDeliveryTime
	, EL.MaxDeliveryTime
	, EL.OpenCount
	, EL.MinOpenTime
	, COUNT(cl.id) ClickCount
	, MIN(cl.CreatedAt) MinClickTime
INTO #MappedGUIDs
FROM #MappedGUIDs_2 el
JOIN ods.eloqua_flagged_emails fs
ON fs.assetname = el.MailingName
--LEFT JOIN #CRMAssetnames CRM
--ON crm.assetname = el.MailingName 
LEFT JOIN ods.Eloqua_ActivityEmailClickThrough cl (NOLOCK)
	ON cl.contactid = el.MemberID AND cl.AssetId = el.mailingID
GROUP BY el.SSB_CRMSYSTEM_CONTACT_ID, el.MemberID, el.Email, el.MailingID, el.MailingName, el.PublicWebviewURL
	, el.DeliveryResult, el.DeliveryCount, el.MinDeliveryTime, el.MaxDeliveryTime, el.OpenCount, el.MinOpenTime

UNION ALL

SELECT EL.SSB_CRMSYSTEM_CONTACT_ID
	, EL.MemberID
	, EL.Email
	, EL.MailingID
	, EL.MailingName
	, EL.PublicWebviewURL
	, EL.DeliveryResult
	, EL.DeliveryCount
	, EL.MinDeliveryTime
	, EL.MaxDeliveryTime
	, EL.OpenCount
	, EL.MinOpenTime
	, COUNT(cl.id) ClickCount
	, MIN(cl.CreatedAt) MinClickTime
FROM #MappedGUIDs_2 el
JOIN #CRMAssetnames fs
ON fs.assetname = el.MailingName
--LEFT JOIN #CRMAssetnames CRM
--ON crm.assetname = el.MailingName 
LEFT JOIN ods.Eloqua_ActivityEmailClickThrough cl (NOLOCK)
	ON cl.contactid = el.MemberID AND cl.AssetId = el.mailingID
GROUP BY el.SSB_CRMSYSTEM_CONTACT_ID, el.MemberID, el.Email, el.MailingID, el.MailingName, el.PublicWebviewURL
	, el.DeliveryResult, el.DeliveryCount, el.MinDeliveryTime, el.MaxDeliveryTime, el.OpenCount, el.MinOpenTime;

-----------------------------------------------------------------------------------------------






CREATE NONCLUSTERED INDEX idx_MappedGUIDs ON #MappedGUIDs(SSB_CRMSYSTEM_CONTACT_ID,MemberID,Email,MailingID,MailingName);

/*========================================================================================================
	Merge into 
========================================================================================================*/

BEGIN

	MERGE etl.Eloqua_EmailSummary_MSCRM_Limited AS TARGET
	USING #MappedGUIDs AS SOURCE
	ON (TARGET.SSB_CRMSYSTEM_CONTACT_ID = SOURCE.SSB_CRMSYSTEM_CONTACT_ID
		AND TARGET.MemberID = SOURCE.MemberID
		AND TARGET.EmailAddress = SOURCE.Email
		AND TARGET.MailingID = SOURCE.MailingID
		AND TARGET.MailingName = SOURCE.MailingName
		AND TARGET.PublicWebviewURL = SOURCE.PublicWebviewURL
		)
	WHEN MATCHED AND (TARGET.DeliveryResult <> SOURCE.DeliveryResult
						OR TARGET.DeliveryCount <> SOURCE.DeliveryCount
						OR TARGET.MinDeliveryTime <> SOURCE.MinDeliveryTime
						OR TARGET.MaxDeliveryTime <> SOURCE.MaxDeliveryTime
						OR TARGET.OpenCount <> SOURCE.OpenCount
						OR TARGET.MinOpenTime <> SOURCE.MinOpenTime
						OR TARGET.ClickCount <> SOURCE.ClickCount
						OR TARGET.MinClickTime <> SOURCE.MinClickTime
					)
	THEN
		UPDATE SET
			  TARGET.MailingName = SOURCE.MailingName
			, TARGET.PublicWebviewURL = SOURCE.PublicWebviewURL
			, TARGET.DeliveryResult = SOURCE.DeliveryResult
			, TARGET.DeliveryCount = SOURCE.DeliveryCount
			, TARGET.MinDeliveryTime = SOURCE.MinDeliveryTime
			, TARGET.MaxDeliveryTime = SOURCE.MaxDeliveryTime
			, TARGET.OpenCount = SOURCE.OpenCount
			, TARGET.MinOpenTime = SOURCE.MinOpenTime
			, TARGET.ClickCount = SOURCE.ClickCount
			, TARGET.MinClickTime = SOURCE.MinClickTime
			, TARGET.ETL_UpdatedDate = GETDATE()
	
	WHEN NOT MATCHED THEN
	INSERT (SSB_CRMSYSTEM_CONTACT_ID, MemberID, EmailAddress, MailingID, MailingName, PublicWebviewURL
			, DeliveryResult, DeliveryCount, MinDeliveryTime, MaxDeliveryTime, OpenCount, MinOpenTime, ClickCount
			, MinClickTime, ETL_CreatedDate, ETL_UpdatedDate)
	
	VALUES (
		SOURCE.SSB_CRMSYSTEM_CONTACT_ID
		, SOURCE.MemberID
		, SOURCE.Email
		, SOURCE.MailingID
		, SOURCE.MailingName
		, SOURCE.PublicWebviewURL
		, SOURCE.DeliveryResult
		, SOURCE.DeliveryCount
		, SOURCE.MinDeliveryTime
		, SOURCE.MaxDeliveryTime
		, SOURCE.OpenCount
		, SOURCE.MinOpenTime
		, SOURCE.ClickCount
		, SOURCE.MinClickTime
		, GETDATE()
		, GETDATE()
		);

END









GO
