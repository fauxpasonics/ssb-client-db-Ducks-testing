SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROC [etl].[Eloqua_Transactions_DeleteTracking]
AS


SELECT  CONCAT(fts.ETL__SSID_TM_acct_id,':',e.EventCode,':',ss.SectionName,':',ss.RowName,':',ss.Seat) Factticketseat_Key
	--	,ds.SeasonName
	--	,fts.ETL__SSID_TM_acct_id AS ArchticsID
	--	,dt.FirstName
	--	,dt.LastName
	--	,dt.EmailPrimary
	--	,dt.accountrep
	--	,fts.TM_purchase_price
	--	,t.TicketTypeName
	--	,e.EventCode
	--	,e.EventName
	----	,e.EventDesc
	--	,e.EventDate
	--	,s.seattypename
	--	,CONCAT(ss.SectionName, + ':', + ss.RowName, + ':', + ss.Seat) AS SeatLocation
	--	,CASE WHEN fa.ScanDateTime IS NOT NULL THEN 1 ELSE 0 END AttendedEvent 

INTO  #todayssales

FROM ro.vw_FactInventory AS fi
JOIN ro.vw_FactTicketSales AS fts
	ON fts.FactTicketSalesId = fi.FactTicketSalesId
	AND fts.ETL__SSID_TM_acct_id <> -1
JOIN ro.vw_DimEvent e
	ON e.DimEventId = fts.DimEventId
JOIN ro.vw_DimSeason ds
	ON ds.DimSeasonId = fts.DimSeasonId
JOIN ro.vw_DimSeat ss
	ON ss.DimSeatId = fi.DimSeatId
JOIN ro.vw_DimCustomer dt
	ON dt.AccountId = fts.ETL__SSID_TM_acct_id
	AND dt.SourceSystem = 'TM'
	AND dt.CustomerType = 'Primary'
	AND dt.emailprimary <> '' 
	AND dt.accountid <> -1
WHERE fts.dimseasonid IN (27,35,47,55)
OR ds.SeasonName LIKE ('%premium suite season%')
OR ds.SeasonName LIKE ('%premium club season%');



TRUNCATE TABLE  ods.Eloqua_Transaction_DetectedDeletes;
--capturing the difference in sales that are visible yesterday but not today for returns/deletes
INSERT INTO  ods.Eloqua_Transaction_DetectedDeletes
SELECT DISTINCT s.Factticketseat_Key 
FROM ods.Eloqua_Transcations_DeleteTracking S
LEFT OUTER JOIN #todayssales t
ON t.Factticketseat_Key = s.Factticketseat_Key
WHERE t.Factticketseat_Key IS NULL


--insert todays sales into table to reference for tomorrows deltas
TRUNCATE TABLE  ods.Eloqua_Transcations_DeleteTracking
INSERT INTO  ods.Eloqua_Transcations_DeleteTracking
SELECT * FROM #todayssales


INSERT INTO [ods].[API_OutboundQueue] (Apiname,Apientity,endpointname,sourceid,json_payload,httpaction)
SELECT  'Eloqua Deletes','API','data/customObject/24' AS endpointname, CONCAT('FactticketSalesId1',+ '=',+factticketseat_key), '','delete'
FROM ods.Eloqua_Transaction_DetectedDeletes



GO
