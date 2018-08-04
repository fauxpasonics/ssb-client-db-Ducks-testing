SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[TM_LoadFactInventory_Avail]
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
	, fi.FactAvailSeatsId = NULL
	, fi.DimSeatStatusId = 0
	FROM etl.vw_FactInventory fi
	LEFT OUTER JOIN etl.vw_FactAvailSeats (NOLOCK) f ON fi.FactAvailSeatsId = f.FactAvailSeatsId
	WHERE f.ETL__SourceSystem = @TMSourceSystem
	AND fi.FactAvailSeatsId IS NOT NULL
	AND f.FactAvailSeatsId IS NULL

	
	/* ********************************************* Get FactRecords Within LoadDate TimePeriod ********************************************* */

	SELECT DISTINCT f.FactAvailSeatsId, de.TM_manifest_id
	INTO #FactFilter
	FROM etl.vw_FactAvailSeats f
	INNER JOIN etl.vw_DimEvent (NOLOCK) de ON f.DimEventId = de.DimEventId
	WHERE f.ETL__SourceSystem = @TMSourceSystem
		AND de.Config_IsFactInventoryEligible = 1
		AND f.ETL__UpdatedDate > @LoadDate

	CREATE NONCLUSTERED INDEX IX_Key ON #FactFilter (FactAvailSeatsId) INCLUDE (TM_manifest_id);


	/* ********************************************* Expand to individual Seats ********************************************* */

	WITH CurrentSeats AS (
		SELECT f.FactAvailSeatsId, f.DimEventId, dSeat.DimSeatId, f.DimSeatStatusId
		FROM etl.vw_FactAvailSeats f
		INNER JOIN #FactFilter ff ON f.FactAvailSeatsId = ff.FactAvailSeatsId		
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
		, fi.FactAvailSeatsId = CurrentSeats.FactAvailSeatsId
		, fi.DimSeatStatusId = ISNULL(CurrentSeats.DimSeatStatusId,0)
	FROM etl.vw_FactInventory fi
	INNER JOIN #FactFilter ff ON fi.FactAvailSeatsId = ff.FactAvailSeatsId
	LEFT OUTER JOIN CurrentSeats ON fi.FactAvailSeatsId = CurrentSeats.FactAvailSeatsId AND fi.DimEventId = CurrentSeats.DimEventId AND fi.DimSeatId = CurrentSeats.DimSeatId
	WHERE ISNULL(fi.FactAvailSeatsId,0) <> ISNULL(CurrentSeats.FactAvailSeatsId,0);



	IF OBJECT_ID('tempdb..#FactFilter') IS NOT NULL DROP TABLE #FactFilter


END



GO
