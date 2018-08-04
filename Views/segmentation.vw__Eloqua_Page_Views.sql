SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










CREATE VIEW [segmentation].[vw__Eloqua_Page_Views]
AS
WITH   SSB_ID
          AS (
               SELECT   ec.ID
                    --  , ec.ContactIDExt
                      , dc.DimCustomerId
                      , d.SSB_CRMSYSTEM_CONTACT_ID
               FROM     ods.Eloqua_Contact AS ec WITH (NOLOCK)
               JOIN     dbo.DimCustomer AS dc WITH (NOLOCK) ON dc.SourceSystem = 'Eloqua' AND dc.SSID = ec.ID
               JOIN     dbo.dimcustomerssbid AS d WITH (NOLOCK) ON d.DimCustomerId = dc.DimCustomerId
             )
    SELECT  ssbid.SSB_CRMSYSTEM_CONTACT_ID AS SSB_CRMSYSTEM_CONTACT_ID
          , eactivity.ID AS PV_ID
          , eactivity.CreatedAt AS PV_CreatedAt
          , eactivity.Type AS PV_Type
          , eactivity.ContactId AS PV_ContactId
          , eactivity.IPAddress AS PV_IPAddress
          , eactivity.Url AS PV_Url
          , eactivity.CampaignId AS PV_CampaignId
          , eactivity.ReferrerUrl AS PV_ReferrerUrl
          , eactivity.VisitorId AS PV_VisitorId
          , eactivity.VisitorExternalId AS PV_VisitorExternalId
          , eactivity.WebVisitId AS PV_WebVisitId
          , eactivity.IsWebTrackingOptedIn AS PV_IsWebTrackingOptedIn
    FROM    ods.Eloqua_ActivityPageView eactivity WITH ( NOLOCK )
	JOIN SSB_ID  ssbid WITH ( NOLOCK ) ON ssbid.ID = eactivity.ContactId
	WHERE eactivity.CreatedAt > (GETDATE()-180)





GO
