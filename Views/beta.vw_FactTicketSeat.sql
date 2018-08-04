SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [beta].[vw_FactTicketSeat]

AS 
(

SELECT 
    --fi.*, 
	--fo.*,
	--ftar.*,

	fts.OrderDate SaleDateTime
    , fts.ETL__SSID_TM_acct_id AS TicketingAccountId
	
	, da.ArenaCode, da.ArenaName
	--, dsh.SeasonCode SeasonHeaderCode, dsh.SeasonName SeasonHeaderName, dsh.SeasonDesc SeasonHeaderDesc, dsh.SeasonClass SeasonHeaderClass, dsh.SeasonYear SeasonHeaderYear, dsh.Active SeasonHeaderIsActive
	, ds.SeasonName, ds.SeasonYear, ds.SeasonClass, ds.Config_Org Sport
	----, deh.EventName EventHeaderName, deh.EventDesc EventHeaderDesc, deh.EventDate EventHeaderDate, deh.EventTime EventHeaderTime, deh.EventDateTime EventHeaderDateTime, deh.EventOpenTime EventHeaderOpenTime, deh.EventFinishTime EventHeaderFinishTime, deh.EventSeasonNumber EventSeasonNumber, deh.HomeGameNumber EventHeaderHomeNumber, deh.GameNumber EventHeaderGameNumber, deh.EventHierarchyL1, deh.EventHierarchyL2, deh.EventHierarchyL3, deh.EventHierarchyL4, deh.EventHierarchyL5
	, de.EventCode, de.EventName, de.EventDate, de.EventTime, de.EventDateTime
	, dss.SeatStatusCode, dss.SeatStatusName
	
	, di.ItemCode, di.ItemName
	, dpl.PlanCode, dpl.PlanName, dpl.PlanDesc, dpl.PlanClass, dpl.PlanFse, dpl.PlanType, dpl.PlanEventCnt

	, dst.SectionName, dst.RowName, dst.Seat, dst.Config_Location
	, dtc.TicketClassCode, dtc.TicketClassName
	, tt.TicketTypeCode, tt.TicketTypeName, tt.TicketTypeDesc
	, pt.PlanTypeCode, pt.PlanTypeName, pt.PlanTypeDesc
	, dstp.SeatTypeCode, dstp.SeatTypeName	
	, dsc.SalesCode, dsc.SalesCodeName
	, dpm.PromoCode, dpm.PromoName


	--, dpc_Held.PriceCode HeldPriceCode
	--, dctm_Held.ClassName HeldClassName
	--, fi.HeldSeatValue

	--,fi.IsSaleable
	--, fi.IsAvailable
	--, fi.IsHeld
	--, fi.IsReserved
	
	--, fo.IsSold
	----, fi.IsHost
	--, fo.IsComp
	
	--, fo.IsPremium
	--, fo.IsSingleEvent
	--, fo.IsPlan
	--, fo.IsPartial
 --   , fo.IsGroup
	--, fo.IsRenewal
	--, fo.IsBroker

	--, fi.TotalRevenue, fi.PcTicketValue, fi.Surcharge, fi.PcTicket, fi.PcTax, fi.PcLicenseFee, fi.PcOther1, fi.PcOther2

	
	, CASE WHEN fi.FactAttendanceId IS NOT NULL THEN 1 ELSE 0 END AS IsAttended
	--, fa. ScanDate
	--, fi.ScanGate

	
	, CASE WHEN fi.FactTicketSalesId IS NOT NULL THEN 1 ELSE 0 END AS QtySeat
	, (fts.RevenueTotal / fts.QtySeat) AS RevenueTotal
	, (fts.PaidAmount / fts.QtySeat) AS PaidAmound
	, (fts.OwedAmount / fts.QtySeat) AS OwedAmount

	, fts.TM_order_num OrderNum
	, fts.TM_order_line_item OrderLineItem
	, fts.TM_retail_ticket_type RetailTicketType
	, fts.TM_retail_qualifiers RetailQualifiers

	, CASE WHEN fi.FactTicketActivityId_Resold IS NOT NULL THEN 1 ELSE 0 END AS IsResold
	--, ( CAST(dd_resold.CalDate AS DATETIME) + CAST(dt_resold.Time24 AS DATETIME) ) ResoldDateTime
	----, ftar.ResoldPurchasePrice
	----, ftar.Fees ResoldFees
	--,ftar.QtySeat ResoldQty
	--, ftar.Total/ftar.QtySeat ResoldTotal
	--, ftar.PAC_MP_Diff/ftar.QtySeat ResoldDifference
	--, ftar.PAC_MP_Buy_Amt/ftar.QtySeat ResoldValue
	--, ftar.PAC_MP_Buyer ResoldBuyer_TicketingAccountId

	--, fi.FactInventoryId, fi.FactOdetId, fi.[FactTicketActivityId_Tranferred], fi.FactAvailSeatsId, fi.FactHeldSeatsId, fi.DimSeasonId, fi.DimEventId, fi.DimSeatId
	----, fi.SoldDimDateId, fi.SoldDimTimeId, fi.SoldDimClassTMId, fi.SoldDimSalesCodeId, fi.SoldDimPromoId, fts.DimPlanTypeId, fts.DimTicketTypeId, fts.DimSeatTypeId
	----, fi.ResoldDimCustomerId
	------, dsh.DimSeasonHeaderId, dsh.PrevSeasonHeaderId
	----, deh.DimEventHeaderId, ds.PrevSeasonId
	----, de.SSID_event_id
	----, dst.SSID_section_id
	----, dst.SSID_row_id
	----, dst.SSID_seat

	, fts.TM_sales_source_name SalesSource
	, fts.TM_group_sales_name GroupSalesName
	, fts.CreatedBy ArchticsAddUser
	--, fts.DimCustomerIdSalesRep
	----, fts.DimCustomerId_TransSalesRep
	--, dc.SSB_CRMSYSTEM_CONTACT_ID


--19088
--SELECT COUNT(*)
--FROM (SELECT * FROM [ro].vw_FactInventory WHERE DimEventId = 852) fi
FROM [ro].[vw_FactInventory] fi 

INNER JOIN [ro].[vw_DimSeason] ds ON fi.DimSeasonId = ds.DimSeasonId
INNER JOIN [ro].[vw_DimArena] da ON fi.DimArenaId = da.DimArenaId
INNER JOIN [ro].[vw_DimEvent] de ON fi.DimEventId = de.DimEventId
--INNER JOIN dbo.DimEventHeader (NOLOCK) deh ON de.DimEventHeaderId = deh.DimEventHeaderId
--INNER JOIN dbo.DimSeasonHeader (NOLOCK) dsh ON deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId
INNER JOIN [ro].[vw_DimSeat] dst ON fi.DimSeatId = dst.DimSeatId
INNER JOIN [ro].[vw_DimSeatStatus] dss ON fi.DimSeatStatusid = dss.DimseatStatusId

--INNER JOIN [ro].[vw_DimPriceCode_Beta] dpc_Manifest ON fi.ManifestDimPriceCodeId = dpc_Manifest.DimPriceCodeId
----INNER JOIN dbo.DimClassTM (NOLOCK) dctm_Manifest ON fi.ManifestDimClassTMId = dctm_Manifest.DimClassTMId

--LEFT OUTER JOIN [ro].[vw_DimPriceCode_Beta] (NOLOCK) dpc_Posted ON fi.PostedDimPriceCodeId = dpc_Posted.DimPriceCodeId
----LEFT OUTER JOIN dbo.DimClassTM (NOLOCK) dctm_Posted ON fi.PostedDimClassTMId = dctm_Posted.DimClassTMId

--LEFT OUTER JOIN [ro].[vw_DimPriceCode_Beta] (NOLOCK) dpc_Held ON fi.HeldDimPriceCodeId = dpc_Held.DimPriceCodeId
--LEFT OUTER JOIN dbo.DimClassTM (NOLOCK) dctm_Held ON fi.HeldDimClassTMId = dctm_Held.DimClassTMId



LEFT OUTER JOIN [ro].[vw_FactTicketSales] fts ON fi.FactTicketSalesId = fts.FactTicketSalesId
LEFT OUTER JOIN [ro].[vw_FactTicketActivity] ftar ON fi.FactTicketActivityId_Resold = ftar.FactTicketActivityId


--LEFT OUTER JOIN [ro].[vw_DimPriceType] dpt ON fo.DimPriceTypeId = dpt.DimPriceTypeId
LEFT OUTER JOIN [ro].[vw_DimItem] di ON fts.DimItemId = di.DimItemId
LEFT OUTER JOIN [ro].[vw_DimPlan] dpl ON fts.DimPlanId = dpl.DimPlanId 
--LEFT OUTER JOIN [ro].[vw_DimCustomer_Base] dc ON dc.SourceSystem = 'Paciolan' AND fo.ETL__SSID_PAC_CUSTOMER = dc.SSID
    
--LEFT OUTER JOIN dbo.DimDate (NOLOCK) dd ON fo.DimDateId = dd.DimDateId
--LEFT OUTER JOIN dbo.DimTime (NOLOCK) dt ON fo.DimTimeId = dt.DimTimeId

--LEFT OUTER JOIN dbo.DimDate (NOLOCK) dd_resold ON ftar.DimdateId = dd_resold.DimDateId
--LEFT OUTER JOIN dbo.DimTime (NOLOCK) dt_resold ON ftar.DimTimeId = dt_resold.DimTimeId


LEFT OUTER JOIN [ro].[vw_DimSalesCode] dsc ON fts.DimSalesCodeId = dsc.DimSalesCodeId
LEFT OUTER JOIN [ro].[vw_DimPromo] dpm ON fts.DimPromoId = dpm.DimPromoID
LEFT OUTER JOIN [ro].[vw_DimPlanType] pt ON fts.DimPlanTypeId = pt.DimPlanTypeId
LEFT OUTER JOIN [ro].[vw_DimTicketType] tt ON fts.DimTicketTypeId = tt.DimTicketTypeId
LEFT OUTER JOIN [ro].[vw_DimSeatType] dstp ON fts.DimSeatTypeId = dstp.DimSeatTypeId
LEFT OUTER JOIN [ro].[vw_DimTicketClass] dtc ON fts.DimTicketClassId = dtc.DimTicketClassId

--WHERE fi.[FactTicketActivityId_Resold] IS NOT NULL

)
GO
