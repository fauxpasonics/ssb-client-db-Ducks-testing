SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [rpt].[DimCustomer_Waterfall]
AS

CREATE TABLE #Final
(
	  ID					INT IDENTITY(1,1)
	, SourceSystem			NVARCHAR(255)
	, LastUpdate			DATETIME
	, TotalRecordCount		INT
	, Source_Duplicates		INT
	, DistinctRecordCount	INT
	, PercentTotal			NVARCHAR(255)
	, ValidAddress			INT
	, ValidPhone			INT
	, ValidEmail			INT
)




INSERT INTO #Final (SourceSystem, LastUpdate, TotalRecordCount, Source_Duplicates, DistinctRecordCount, PercentTotal, ValidAddress, ValidPhone, ValidEmail)

SELECT a.SourceSystem
	, b.LastUpdate
	, a.RecordCount TotalRecordCount
	, (a.RecordCount - a.DistinctRecordCount) Source_Duplicates
	, a.DistinctRecordCount
	, CAST(CAST((CAST((a.RecordCount - a.DistinctRecordCount) AS DECIMAL(15,2))/CAST(a.RecordCount AS DECIMAL(15,2))) AS DECIMAL(5,2))*100 AS NVARCHAR(10)) + '%' PercentTotal
	, b.ValidAddress
	, b.ValidPhone
	, b.ValidEmail
--INTO rpt.TEMP_DimCustomer_Waterfall
FROM ( --#tmpa a
		SELECT SourceSystem
			, COUNT(SSB_CRMSYSTEM_CONTACT_ID) RecordCount
			, COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) DistinctRecordCount
		FROM dbo.dimcustomerssbid (NOLOCK)
		WHERE IsDeleted <> 1
		GROUP BY SourceSystem
	) a
INNER JOIN ( --#tmpb b 
		SELECT SourceSystem
			, SUM(CASE WHEN AddressPrimaryIsCleanStatus = 'Valid' THEN 1
				ELSE 0
				END) AS ValidAddress
			, SUM(CASE WHEN PhonePrimaryIsCleanStatus = 'Valid' THEN 1
				ELSE 0
				END) AS ValidPhone
			, SUM(CASE WHEN EmailPrimaryIsCleanStatus = 'Valid' THEN 1
				ELSE 0
				END) AS ValidEmail
			, MAX(UpdatedDate) LastUpdate
		FROM dbo.DimCustomer (NOLOCK)
		WHERE IsDeleted <> 1
		GROUP BY SourceSystem
	) b
	ON a.SourceSystem = b.SourceSystem
LEFT OUTER JOIN (
		SELECT
			ss.SourceSystem,
			ssp.SourceSystemPriority
		FROM mdm.SourceSystemPriority ssp
		INNER JOIN mdm.SourceSystems ss
			ON  ssp.SourceSystemId = ss.SourceSystemID
		WHERE ElementID = 1
	) p
	ON  a.SourceSystem = p.SourceSystem
ORDER BY ISNULL(p.SourceSystemPriority, -1) DESC, a.SourceSystem





INSERT INTO #Final (SourceSystem, LastUpdate, TotalRecordCount, Source_Duplicates, DistinctRecordCount, PercentTotal, ValidAddress, ValidPhone, ValidEmail)


SELECT a.SourceSystem
	, a.LastUpdate
	, a.TotalRecordCount
	, (a.TotalRecordCount - a.DistinctRecordCount) Source_Duplicates
	, a.DistinctRecordCount
	, CAST(CAST((CAST((a.TotalRecordCount - a.DistinctRecordCount) AS DECIMAL(15,2))/CAST(a.TotalRecordCount AS DECIMAL(15,2))) AS DECIMAL(5,2))*100 AS NVARCHAR(10)) + '%' PercentTotal
	, a.ValidAddress
	, a.ValidPhone
	, a.ValidEmail
FROM (
	SELECT 'All Sources' AS SourceSystem, MAX(dc.UpdatedDate) AS LastUpdate, COUNT(*) AS TotalRecordCount
		, COUNT(DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID) AS DistinctRecordCount
		, SUM(CASE WHEN dc.AddressPrimaryIsCleanStatus = 'Valid' THEN 1 END) ValidAddress
		, SUM(CASE WHEN dc.PhonePrimaryIsCleanStatus = 'Valid' THEN 1 END) ValidPhone
		, SUM(CASE WHEN dc.EmailPrimaryIsCleanStatus = 'Valid' THEN 1 END) ValidEmail
	FROM dbo.dimcustomer dc
	JOIN dbo.dimcustomerssbid ssbid
		ON dc.DimCustomerId = ssbid.DimCustomerId
	) a



SELECT SourceSystem, LastUpdate, TotalRecordCount
	, Source_Duplicates, DistinctRecordCount, PercentTotal
	, ValidAddress, ValidPhone, ValidEmail
FROM #Final


GO
