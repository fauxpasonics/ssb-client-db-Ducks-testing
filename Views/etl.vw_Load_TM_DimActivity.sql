SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_Load_TM_DimActivity]
AS (
SELECT
	 Act.Activity AS ETL__SSID
	,Act.Activity AS ETL__SSID_TM_activity
	,Act.Activity AS ActivityCode
	,Act.ActivityName
	,Act.ActivityName AS ActivityDesc
FROM (
		SELECT
			 Act.Activity 
			,Act.ActivityName
			,ROW_NUMBER() OVER (PARTITION BY Act.Activity ORDER BY Act.ActivityName) AS RowNumber
		FROM (
				SELECT DISTINCT
					 Activity
					,activity_name AS ActivityName
				FROM ods.TM_Tex (NOLOCK)
			) Act
	) Act
WHERE Act.RowNumber = 1
)
GO
