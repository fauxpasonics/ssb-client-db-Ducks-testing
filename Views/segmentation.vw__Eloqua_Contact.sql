SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO










CREATE VIEW [segmentation].[vw__Eloqua_Contact]
AS
    WITH    SSB_ID
              AS (
                   SELECT   d.SSID
                          , d.SSB_CRMSYSTEM_CONTACT_ID
                   FROM     dbo.DimCustomer AS dc  WITH ( NOLOCK ) 
                   JOIN     dbo.dimcustomerssbid AS d  WITH ( NOLOCK ) ON d.DimCustomerId = dc.DimCustomerId
				   WHERE dc.SourceSystem = 'Eloqua'
                 
                 )
    SELECT  ssbid.SSB_CRMSYSTEM_CONTACT_ID AS SSB_CRMSYSTEM_CONTACT_ID
          , econtact.AccountName AS C_AccountName
          , econtact.BouncebackDate AS C_BouncebackDate
          , econtact.IsBounceback AS C_IsBounceback
          , econtact.IsSubscribed AS C_IsSubscribed
          , econtact.PostalCode AS C_PostalCode
          , econtact.Province AS C_Province
          , econtact.SubscriptionDate AS C_SubscriptionDate
          , econtact.UnsubscriptionDate AS C_UnsubscriptionDate
          , econtact.CreatedAt AS C_CreatedAt
          , econtact.CreatedBy AS C_CreatedBy
          , econtact.AccessedAt AS C_AccessedAt
          , econtact.CurrentStatus AS C_CurrentStatus
          , econtact.Depth AS C_Depth
          , econtact.UpdatedAt AS C_UpdatedAt
          , econtact.UpdatedBy AS C_UpdatedBy
          , econtact.EmailAddress AS C_EmailAddress
          , econtact.FirstName AS C_FirstName
          , econtact.LastName AS C_LastName
          , econtact.Company AS C_Company
          , econtact.Address1 AS C_Address1
          , econtact.Address2 AS C_Address2
          , econtact.Address3 AS C_Address3
          , econtact.City AS C_City
          , econtact.Country AS C_Country
          , econtact.MobilePhone AS C_MobilePhone
          , econtact.BusinessPhone AS C_BusinessPhone
          , econtact.Fax AS C_Fax
          , econtact.Title AS C_Title
          , econtact.SalesPerson AS C_SalesPerson
    FROM    ods.Eloqua_Contact econtact WITH ( NOLOCK )
    JOIN    SSB_ID ssbid  WITH ( NOLOCK ) ON ssbid.SSID = econtact.ID;







GO
