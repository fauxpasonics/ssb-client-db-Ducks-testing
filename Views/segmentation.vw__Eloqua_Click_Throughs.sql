SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE VIEW [segmentation].[vw__Eloqua_Click_Throughs]
AS

    WITH    SSB_ID
              AS (
                   SELECT   ec.ID
                          , ec.ContactIDExt
                          , dc.DimCustomerId
                          , d.SSB_CRMSYSTEM_CONTACT_ID
                   FROM     ods.Eloqua_Contact AS ec  WITH ( NOLOCK ) 
                   JOIN     dbo.DimCustomer AS dc  WITH ( NOLOCK )  ON dc.SourceSystem = 'Eloqua' AND dc.SSID = ec.ID
                   JOIN     dbo.dimcustomerssbid AS d  WITH ( NOLOCK ) ON d.DimCustomerId = dc.DimCustomerId
                 )
        SELECT  ssbid.SSB_CRMSYSTEM_CONTACT_ID AS SSB_CRMSYSTEM_CONTACT_ID
              , eclick.ID AS CTR_ID
              , eclick.Name AS CTR_Name
              , eclick.CreatedAt AS CTR_CreatedAt
              , eclick.Type AS CTR_Type
              , eclick.AssetId AS CTR_AssetId
              , eclick.AssetName AS CTR_AssetName
              , eclick.AssetType AS CTR_AssetType
              , eclick.ContactId AS CTR_ContactId
              , eclick.EmailClickedThruLink AS CTR_EmailClickedThruLink
              , eclick.EmailName AS CTR_EmailName
              , eclick.EmailWebLink AS CTR_EmailWebLink
              , eclick.SubjectLine AS CTR_SubjectLine
              , eclick.EmailRecipientId AS CTR_EmailRecipientId
              , eclick.EmailAddress AS CTR_EmailAddress
              , eclick.CampaignId AS CTR_CampaignId
        FROM    ods.Eloqua_ActivityEmailClickThrough eclick WITH ( NOLOCK )
		JOIN SSB_ID ssbid  WITH ( NOLOCK ) ON ssbid.ID = eclick.ContactId







GO
