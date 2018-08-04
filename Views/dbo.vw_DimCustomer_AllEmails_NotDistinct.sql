SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vw_DimCustomer_AllEmails_NotDistinct]
AS

-- Email Primary --
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, dc.DimCustomerId, dc.SourceSystem, dc.SSID
	, Prefix, FirstName, MiddleName, LastName, Suffix, FullName, NameDirtyHash, NameIsCleanStatus
	, dc.EmailPrimary Email, dc.EmailPrimaryDirtyHash EmailDirtyHash, dc.EmailPrimaryIsCleanStatus EmailIsCleanStatus
	, 'EmailPrimary' AS EmailType
FROM dbo.DimCustomer dc (NOLOCK)
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerID
WHERE EmailPrimaryIsCleanStatus LIKE '%Valid%'
	AND NameIsCleanStatus LIKE '%Valid%'

UNION

-- Email One --
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, dc.DimCustomerId, dc.SourceSystem, dc.SSID
	, Prefix, FirstName, MiddleName, LastName, Suffix, FullName, NameDirtyHash, NameIsCleanStatus
	, dc.EmailOne Email, dc.EmailOneDirtyHash EmailDirtyHash, dc.EmailOneIsCleanStatus EmailIsCleanStatus
	, 'EmailOne' AS EmailType
FROM dbo.DimCustomer dc (NOLOCK)
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerID
WHERE EmailOneIsCleanStatus LIKE '%Valid%'
	AND NameIsCleanStatus LIKE '%Valid%'

UNION

-- Email Two --
SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, dc.DimCustomerId, dc.SourceSystem, dc.SSID
	, Prefix, FirstName, MiddleName, LastName, Suffix, FullName, NameDirtyHash, NameIsCleanStatus
	, dc.EmailTwo Email, dc.EmailTwoDirtyHash AS EmailDirtyHash, dc.EmailTwoIsCleanStatus AS EmailIsCleanStaus
	, 'EmailTwo' AS EmailType
FROM dbo.DimCustomer dc (NOLOCK)
JOIN dbo.dimcustomerssbid ssbid (NOLOCK)
	ON dc.DimCustomerId = ssbid.DimCustomerID
WHERE EmailTwoIsCleanStatus LIKE '%Valid%'
	AND NameIsCleanStatus LIKE '%Valid%'


-- Total Records (3018-03-27): 
GO
