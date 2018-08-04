SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO











CREATE VIEW [segmentation].[vw__Eloqua_Form_Submit]
AS
 WITH   SSB_ID
          AS (
               SELECT   ec.ID
                     -- , ec.ContactIDExt
                      , dc.DimCustomerId
                      , d.SSB_CRMSYSTEM_CONTACT_ID
               FROM     ods.Eloqua_Contact AS ec
               JOIN     dbo.DimCustomer AS dc WITH ( NOLOCK ) ON  dc.SourceSystem = 'Eloqua' AND dc.SSID = ec.ID
               JOIN     dbo.dimcustomerssbid AS d WITH ( NOLOCK ) ON d.DimCustomerId = dc.DimCustomerId
             )
    SELECT  ssbid.SSB_CRMSYSTEM_CONTACT_ID AS SSB_CRMSYSTEM_CONTACT_ID     
          , eafs.ID AS FS_ID --ACarter 9/12 changed due to segmentation column duplication error
          , eafs.Name
          , eafs.CreatedAt
          , eafs.Type
          , eafs.AssetName
          , eafs.AssetId
          , eafs.AssetType
          , eafs.ContactId
          , eafs.Collection
          , eafs.FormName
          , eafs.FormData
          , eafs.RawData
          , eafs.CampaignId
    FROM    ods.Eloqua_ActivityFormSubmit AS eafs
    JOIN    SSB_ID ssbid ON ssbid.ID = eafs.ContactId;











GO
