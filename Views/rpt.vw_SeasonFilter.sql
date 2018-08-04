SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [rpt].[vw_SeasonFilter]
AS
WITH CTE_Seasons
AS (
		SELECT DISTINCT
			ds.DimSeasonId,
			ds.SeasonYear,
			ds.DimSeasonId_Prev,
			ds.SeasonName,
			ds.IsActive,
			dsh.SeasonName AS SeasonHeaderName
		FROM ro.vw_DimEvent de
		INNER JOIN ro.vw_DimEventHeader deh
			ON  de.DimEventHeaderId = deh.DimEventHeaderId
		INNER JOIN ro.vw_DimSeasonHeader dsh
			ON  deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId
		INNER JOIN ro.vw_DimSeason ds
			ON  de.DimSeasonId = ds.DimSeasonId
		WHERE 1=1
			AND dsh.SeasonName <> 'Unknown'
			AND dsh.SeasonName LIKE '%Ducks%'
			AND ds.SeasonName NOT LIKE '%Food%'
			AND ds.SeasonName NOT LIKE '%F&B%'
			AND ds.SeasonName NOT LIKE '%Shock Top%'
			AND ds.SeasonName NOT LIKE '%Parking%'
			AND ds.SeasonName NOT LIKE '%Barcode%'
			AND ds.SeasonName NOT LIKE '%GA%'
	)
SELECT
	DimSeasonId, MAX(SeasonYear) AS SeasonYear, MAX(SeasonName) AS SeasonName, MAX(SeasonHeaderName) AS SeasonHeaderName
FROM (
		SELECT s.DimSeasonId, s.SeasonYear, s.SeasonName, s.SeasonHeaderName
		FROM CTE_Seasons s
		WHERE s.IsActive = 1
		UNION
		SELECT DISTINCT
			ds.DimSeasonId,
			ds.SeasonYear,
			ds.SeasonName,
			dsh.SeasonName AS SeasonHeaderName
		FROM ro.vw_DimEvent de
		INNER JOIN ro.vw_DimEventHeader deh
			ON  de.DimEventHeaderId = deh.DimEventHeaderId
		INNER JOIN ro.vw_DimSeasonHeader dsh
			ON  deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId
		INNER JOIN ro.vw_DimSeason ds
			ON  de.DimSeasonId = ds.DimSeasonId
		INNER JOIN CTE_Seasons s
			ON  ds.DimSeasonId = s.DimSeasonId_Prev
		WHERE dsh.SeasonName <> 'Unknown'

		--SELECT ds.DimSeasonId, ds.SeasonYear, ds.SeasonName
		--FROM ro.vw_DimSeason ds
		--INNER JOIN CTE_Seasons s
		--	ON  ds.DimSeasonId = s.DimSeasonId_Prev
	) S
GROUP BY DimSeasonId

GO
