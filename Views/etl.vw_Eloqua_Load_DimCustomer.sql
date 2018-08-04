SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_Eloqua_Load_DimCustomer] AS (

	SELECT *
	/*Name*/
		, HASHBYTES('sha2_256',
							ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')
							+ ISNULL(RTRIM(Fullname),'DBNULL_TEXT')
							+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT')) AS [NameDirtyHash]
	, 'Dirty' AS [NameIsCleanStatus]
	, NULL AS [NameMasterId]

	/*Address*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT')) AS [AddressPrimaryDirtyHash]
	, 'Dirty' AS [AddressPrimaryIsCleanStatus]
	, NULL AS [AddressPrimaryMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressOneStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressOneCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressOneZip),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressOneCounty),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneCountry),'DBNULL_TEXT')) AS [AddressOneDirtyHash]
	, 'Dirty' AS [AddressOneIsCleanStatus]
	, NULL AS [AddressOneMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressTwoStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressTwoCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressTwoState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressTwoZip),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressTwoCounty),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressTwoCountry),'DBNULL_TEXT')) AS [AddressTwoDirtyHash]
	, 'Dirty' AS [AddressTwoIsCleanStatus]
	, NULL AS [AddressTwoMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressThreeStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressThreeCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressThreeState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressThreeZip),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressThreeCounty),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressThreeCountry),'DBNULL_TEXT')) AS [AddressThreeDirtyHash]
	, 'Dirty' AS [AddressThreeIsCleanStatus]
	, NULL AS [AddressThreeMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressFourStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressFourCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressFourState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressFourZip),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressFourCounty),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressFourCountry),'DBNULL_TEXT')) AS [AddressFourDirtyHash]
	, 'Dirty' AS [AddressFourIsCleanStatus]
	, NULL AS [AddressFourMasterId]

	/*Contact*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')+ ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT')) AS [ContactDirtyHash]
	

	/*Phone*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhonePrimary),'DBNULL_TEXT')) AS [PhonePrimaryDirtyHash]
	, 'Dirty' AS [PhonePrimaryIsCleanStatus]
	, NULL AS [PhonePrimaryMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneHome),'DBNULL_TEXT')) AS [PhoneHomeDirtyHash]
	, 'Dirty' AS [PhoneHomeIsCleanStatus]
	, NULL AS [PhoneHomeMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneCell),'DBNULL_TEXT')) AS [PhoneCellDirtyHash]
	, 'Dirty' AS [PhoneCellIsCleanStatus]
	, NULL AS [PhoneCellMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneBusiness),'DBNULL_TEXT')) AS [PhoneBusinessDirtyHash]
	, 'Dirty' AS [PhoneBusinessIsCleanStatus]
	, NULL AS [PhoneBusinessMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneFax),'DBNULL_TEXT')) AS [PhoneFaxDirtyHash]
	, 'Dirty' AS [PhoneFaxIsCleanStatus]
	, NULL AS [PhoneFaxMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneOther),'DBNULL_TEXT')) AS [PhoneOtherDirtyHash]
	, 'Dirty' AS [PhoneOtherIsCleanStatus]
	, NULL AS [PhoneOtherMasterId]

	/*Email*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailPrimary),'DBNULL_TEXT')) AS [EmailPrimaryDirtyHash]
	, 'Dirty' AS [EmailPrimaryIsCleanStatus]
	, NULL AS [EmailPrimaryMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailOne),'DBNULL_TEXT')) AS [EmailOneDirtyHash]
	, 'Dirty' AS [EmailOneIsCleanStatus]
	, NULL AS [EmailOneMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailTwo),'DBNULL_TEXT')) AS [EmailTwoDirtyHash]
	, 'Dirty' AS [EmailTwoIsCleanStatus]
	, NULL AS [EmailTwoMasterId]
	
	/*External Attributes*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(customerType),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(CustomerStatus),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AccountType),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AccountRep),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(SalutationName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(DonorMailName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(DonorFormalName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(Birthday),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(Gender),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AccountId),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MergedRecordFlag),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MergedIntoSSID),'DBNULL_TEXT')
							+ ISNULL(RTRIM(IsBusiness),'DBNULL_TEXT')) AS [contactattrDirtyHash]

	, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute1),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute2),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute3),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute4),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute5),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute6),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute7),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute8),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute9),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute10),'DBNULL_TEXT') 
							) AS [extattr1_10DirtyHash]

	, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute11),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute12),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute13),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute14),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute15),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute16),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute17),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute18),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute19),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute20),'DBNULL_TEXT') 
							) AS [extattr11_20DirtyHash]

							
	, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute21),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute22),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute23),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute24),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute25),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute26),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute27),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute28),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute29),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute30),'DBNULL_TEXT') 
							) AS [extattr21_30DirtyHash]

							
	, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute31),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute32),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute33),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute34),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute35),'DBNULL_TEXT')
							) AS [extattr31_35DirtyHash]
	FROM (
		SELECT
			'Ducks' AS [SourceDB]
			, 'Eloqua' AS [SourceSystem]
			, NULL AS [SourceSystemPriority]

			/*Standard Attributes*/
			, CAST(p.ID AS NVARCHAR(100)) [SSID]
            , CAST(NULL AS NVARCHAR(50)) AS [CustomerType]
			, CAST(NULL AS NVARCHAR(50)) AS [CustomerStatus]
			, CAST(NULL AS NVARCHAR(50)) AS [AccountType] 
			, CAST(NULL AS NVARCHAR(50)) AS [AccountRep] 
			, CAST(p.Company AS NVARCHAR(50)) AS [CompanyName] 
			, CAST(NULL AS NVARCHAR(50))  AS [SalutationName]
			, CAST(NULL AS NVARCHAR(50))  AS [DonorMailName]
			, CAST(NULL AS NVARCHAR(50))  AS [DonorFormalName]
			, CAST(NULL AS DATE) AS [Birthday]
			, CAST(NULL AS NVARCHAR(10)) AS [Gender] 
			, 0 [MergedRecordFlag]
			, CAST(NULL AS NVARCHAR(100)) [MergedIntoSSID]

			/**ENTITIES**/
			/*Name*/			
			, CAST(NULL AS NVARCHAR(300)) AS FullName
			, CAST(NULL AS NVARCHAR(100)) AS [Prefix]
			, CAST(p.FirstName AS NVARCHAR(100)) AS [FirstName]
			--, master.dbo.TI_FirstName(FullName) AS [FirstName]
			, CAST(NULL AS NVARCHAR(100)) AS [MiddleName]
			, CAST(p.LastName AS NVARCHAR(100)) AS [LastName]
			--, master.dbo.TI_LastName(FullName) AS [LastName]
			, CAST(NULL AS NVARCHAR(100)) AS [Suffix]
			--, Title as [Title]

			/*AddressPrimary*/
			,  CAST(p.Address1 AS NVARCHAR(500)) AS [AddressPrimaryStreet]
			, CAST (p.Address2 AS NVARCHAR(200)) AS [AddressPrimarySuite]
			, CAST (p.City AS NVARCHAR(200)) AS [AddressPrimaryCity] 
			, CAST (Province AS NVARCHAR(200)) AS [AddressPrimaryState] 
			, CAST (PostalCode AS NVARCHAR(25))	AS [AddressPrimaryZip] 
			, CAST(NULL AS NVARCHAR(25)) AS [AddressPrimaryCounty]
			, CAST(p.Country AS NVARCHAR(200)) AS [AddressPrimaryCountry] 
			
			, CAST(NULL AS NVARCHAR(500)) AS [AddressOneStreet]
			, CAST(NULL AS NVARCHAR(200)) AS [AddressOneCity] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressOneState] 
			, CAST(NULL AS NVARCHAR(25)) AS [AddressOneZip] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressOneCounty] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressOneCountry] 

			, CAST(NULL AS NVARCHAR(500)) AS [AddressTwoStreet]
			, CAST(NULL AS NVARCHAR(200)) AS [AddressTwoCity] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressTwoState] 
			, CAST(NULL AS NVARCHAR(25)) AS [AddressTwoZip] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressTwoCounty] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressTwoCountry] 

			, CAST(NULL AS NVARCHAR(500)) AS [AddressThreeStreet]
			, CAST(NULL AS NVARCHAR(200)) AS [AddressThreeCity] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressThreeState] 
			, CAST(NULL AS NVARCHAR(25)) AS [AddressThreeZip] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressThreeCounty] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressThreeCountry] 
			
			, CAST(NULL AS NVARCHAR(500)) AS [AddressFourStreet]
			, CAST(NULL AS NVARCHAR(200)) AS [AddressFourCity] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressFourState] 
			, CAST(NULL AS NVARCHAR(25)) AS [AddressFourZip] 
			, CAST(NULL AS NVARCHAR(200)) AS [AddressFourCounty]
			, CAST(NULL AS NVARCHAR(200)) AS [AddressFourCountry] 

			/*Phone*/
			, CAST(p.MobilePhone AS NVARCHAR(25)) AS [PhonePrimary]
			, CAST(NULL AS NVARCHAR(25)) AS [PhoneHome]
			, CAST(p.MobilePhone AS NVARCHAR(25)) AS [PhoneCell]
			, CAST(p.BusinessPhone AS NVARCHAR(25)) AS [PhoneBusiness]
			, CAST(p.Fax AS NVARCHAR(25)) AS [PhoneFax]
			, CAST(NULL AS NVARCHAR(25)) AS [PhoneOther]

			/*Email*/
			, CAST(p.EmailAddress AS NVARCHAR(256)) AS [EmailPrimary]
			, CAST(NULL AS NVARCHAR(256)) AS [EmailOne]
			, CAST(NULL AS NVARCHAR(256)) AS [EmailTwo]

			/*Extended Attributes*/
			, CAST(NULL AS NVARCHAR(100)) AS[ExtAttribute1] --nvarchar(100)
			, CAST(NULL AS NVARCHAR(100)) AS[ExtAttribute2] 
			, CAST(NULL AS NVARCHAR(100)) AS[ExtAttribute3] 
			, CAST(NULL AS NVARCHAR(100)) AS[ExtAttribute4] 
			, CAST(NULL AS NVARCHAR(100)) AS[ExtAttribute5] 
			, 'ELO-' + CAST(p.id AS NVARCHAR(96)) AS[ExtAttribute6] 
			, CAST(NULL AS NVARCHAR(100)) AS[ExtAttribute7] 
			, CAST(NULL AS NVARCHAR(100)) AS[ExtAttribute8] 
			, CAST(NULL AS NVARCHAR(100)) AS[ExtAttribute9] 
			, CASE WHEN p.C_MSCRMContactID IS NOT NULL OR p.C_MSCRMContactID <> '' THEN RTRIM(CAST(p.C_MSCRMContactID AS NVARCHAR(100))) END AS[ExtAttribute10]

			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute11] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute12] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute13] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute14] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute15] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute16] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute17] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute18] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute19] 
			, CAST(NULL AS DECIMAL(18,6)) AS [ExtAttribute20]  

			, CAST(NULL AS DATETIME) AS [ExtAttribute21] --datetime
			, CAST(NULL AS DATETIME) AS [ExtAttribute22] 
			, CAST(NULL AS DATETIME) AS[ExtAttribute23] 
			, CAST(NULL AS DATETIME) AS [ExtAttribute24] 
			, CAST(NULL AS DATETIME) AS [ExtAttribute25] 
			, CAST(NULL AS DATETIME) AS [ExtAttribute26] 
			, CAST(NULL AS DATETIME) AS [ExtAttribute27] 
			, CAST(NULL AS DATETIME) AS [ExtAttribute28] 
			, CAST(NULL AS DATETIME) AS [ExtAttribute29] 
			, CAST(NULL AS DATETIME) AS [ExtAttribute30]  

			, CAST(NULL AS NVARCHAR(MAX)) AS [ExtAttribute31]
			, CAST(NULL AS NVARCHAR(MAX)) AS [ExtAttribute32]
			, CAST(NULL AS NVARCHAR(MAX)) AS [ExtAttribute33] 
			, CAST(NULL AS NVARCHAR(MAX)) AS [ExtAttribute34] 
			, CAST(NULL AS NVARCHAR(MAX)) AS [ExtAttribute35] 

			/*Source Created and Updated*/
			, CAST(p.CreatedBy AS NVARCHAR(255)) AS [SSCreatedBy]
			, CAST(p.UpdatedBy AS NVARCHAR(255)) AS [SSUpdatedBy]
			, CreatedAt AS [SSCreatedDate]
			, UpdatedAt AS [SSUpdatedDate]

			, p.ETL_CreatedDate AS CreatedDate
			, p.ETL_UpdatedDate AS UpdatedDate
			, p.ETL_IsDeleted AS IsDeleted
			, p.ETL_DeletedDate AS DeleteDate
			, NULL AddressOneSuite
			, NULL AddressTwoSuite
			, NULL AddressThreeSuite
			, NULL AddressFourSuite
			--, CASE WHEN p.C_Contact_Id1 IS NOT NULL AND p.C_Contact_Id1 <> '' AND CHARINDEX('|',p.C_Contact_Id1) >0 THEN 'TM-' + RTRIM(CAST(LEFT(p.C_Contact_Id1,CHARINDEX('|',p.C_Contact_Id1)-1) AS NVARCHAR(50))) 
			--	   WHEN p.C_Contact_Id1 IS NOT NULL AND p.C_Contact_Id1 <> '' AND CHARINDEX('|',p.C_Contact_Id1) =0 THEN 'TM-' + RTRIM(CAST(p.C_Contact_Id1 AS NVARCHAR(50))) 
			--		     ELSE NULL END customer_matchkey
			, NULL [customer_matchkey]
			, NULL [AddressPrimaryNCOAStatus]
			, NULL [AddressOneStreetNCOAStatus]
			, NULL [AddressTwoStreetNCOAStatus]
			, NULL [AddressThreeStreetNCOAStatus]
			, NULL [AddressFourStreetNCOAStatus]

			, NULL [AccountId]
			, CAST(CASE WHEN LEN(ISNULL(p.Company,'')) > 0 THEN 1 ELSE 0 END AS BIT) IsBusiness

--		select top 100 *			
		FROM ods.Eloqua_Contact p	
		LEFT JOIN ods.TM_Cust c
		ON CAST(c.acct_id AS NVARCHAR(50)) = p.C_Contact_Id1 AND c.email_addr = p.EmailAddress AND c.Primary_code = 'primary'
		WHERE 1=1
		AND ETL_UpdatedDate > DATEADD(DAY,-3,GETDATE())

	) a

)






GO
