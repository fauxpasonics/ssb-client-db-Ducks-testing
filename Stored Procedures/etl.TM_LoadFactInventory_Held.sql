SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[TM_LoadFactInventory_Held]
(
	@BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = null
)

AS
BEGIN


	DECLARE @OptionsXML XML = TRY_CAST(@Options AS XML)


	DECLARE @LoadDate DATETIME = (GETDATE() - 2)

	SELECT @LoadDate = t.x.value('LoadDate[1]','DateTime')
	FROM @OptionsXML.nodes('options') t(x)




	DECLARE @TMSourceSystem NVARCHAR(255) = (SELECT etl.fnGetClientSetting('TM-SourceStyem'))


	/* ********************************************* If Fact Record No Longer Exist Reset Status ********************************************* */

	UPDATE fi
	SET fi.ETL__UpdatedDate = GETUTCDATE()	
	, fi.FactHeldSeatsId = NULL
	, fi.DimSeatStatusId = 0
	FROM etl.vw_FactInventory fi
	LEFT OUTER JOIN etl.vw_FactHeldSeats (NOLOCK) f ON fi.FactHeldSeatsId = f.FactHeldSeatsId
	WHERE f.ETL__SourceSystem = @TMSourceSystem
	AND fi.FactHeldSeatsId IS NOT NULL
	AND f.FactHeldSeatsId IS NULL

	
	/* ********************************************* Get FactRecords Within LoadDate TimePeriod ********************************************* */

	SELECT DISTINCT f.FactHeldSeatsId, de.TM_manifest_id
	INTO #FactFilter
	FROM etl.vw_FactHeldSeats f
	INNER JOIN etl.vw_DimEvent (NOLOCK) de ON f.DimEventId = de.DimEventId
	WHERE f.ETL__SourceSystem = @TMSourceSystem
		AND de.Config_IsFactInventoryEligible = 1
		AND f.ETL__UpdatedDate > @LoadDate

	CREATE NONCLUSTERED INDEX IX_Key ON #FactFilter (FactHeldSeatsId) INCLUDE (TM_manifest_id);


	/* ********************************************* Expand to individual Seats ********************************************* */

	WITH CurrentSeats AS (
		SELECT f.FactHeldSeatsId, f.DimEventId, dSeat.DimSeatId, f.DimSeatStatusId
		FROM etl.vw_FactHeldSeats f
		INNER JOIN #FactFilter ff ON f.FactHeldSeatsId = ff.FactHeldSeatsId		
		INNER JOIN etl.vw_DimSeat (NOLOCK) dSeat 
			ON f.ETL__SourceSystem = dSeat.ETL__SourceSystem
			AND ff.TM_manifest_id = dSeat.ETL__SSID_TM_manifest_id
			AND f.ETL__SSID_TM_section_id = dSeat.ETL__SSID_TM_section_id 
			AND f.ETL__SSID_TM_row_id = dSeat.ETL__SSID_TM_row_id 
			AND dSeat.ETL__SSID_TM_seat between f.ETL__SSID_TM_seat_num and (f.ETL__SSID_TM_seat_num + f.QtySeat - 1)
		WHERE f.DimEventId > 0 AND f.DimSeatId_Start > 0
	)


	/* ********************************************* Update Inventory Status ********************************************* */
	UPDATE fi
	SET fi.ETL__UpdatedDate = GETUTCDATE()	
	, fi.FactHeldSeatsId = s.FactHeldSeatsId
	, fi.DimSeatStatusId = s.DimSeatStatusId
	FROM etl.vw_FactInventory fi
	INNER JOIN CurrentSeats s ON fi.DimEventId = s.DimEventId AND fi.DimSeatId = s.DimSeatId
	WHERE ISNULL(fi.FactHeldSeatsId, -987) <> ISNULL(s.FactHeldSeatsId, -987) OR ISNULL(fi.DimSeatStatusId, -987) <> ISNULL(s.DimSeatStatusId, -987)
	
	
	
	--UPDATE fi
	--SET fi.ETL__UpdatedDate = GETUTCDATE()	
	--, fi.FactHeldSeatsId = NULL
	--, fi.DimSeatStatusId = 0
	--FROM etl.vw_FactInventory fi
	--INNER JOIN #FactFilter ff ON fi.FactHeldSeatsId = ff.FactHeldSeatsId
	--LEFT OUTER JOIN CurrentSeats ON fi.FactHeldSeatsId = CurrentSeats.FactHeldSeatsId AND fi.DimEventId = CurrentSeats.DimEventId AND fi.DimSeatId = CurrentSeats.DimSeatId
	--WHERE ISNULL(fi.FactHeldSeatsId,0) <> ISNULL(CurrentSeats.FactHeldSeatsId,0);



	IF OBJECT_ID('tempdb..#FactFilter') IS NOT NULL DROP TABLE #FactFilter


END



GO
