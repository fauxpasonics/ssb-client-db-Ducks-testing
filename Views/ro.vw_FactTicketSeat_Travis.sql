SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ro].[vw_FactTicketSeat_Travis]
AS
WITH CTE_Inventory
AS (
		SELECT
			fi.DimSeasonId,
			fi.DimArenaId,
			fi.DimEventId,
			dst.SectionName,
			dst.RowName,
			TRY_CAST(dst.Seat AS INT) AS Seat,
			fi.ETL__SSID_TM_event_id,
			fi.ETL__SSID_TM_section_id,
			fi.ETL__SSID_TM_row_id,
			fi.ETL__SSID_TM_seat,
			fi.DimSeatId,
			fi.FactAvailSeatsId,
			fi.FactHeldSeatsId,
			fi.FactTicketSalesId,
			CAST(CASE WHEN fi.FactAvailSeatsId IS NULL OR fi.FactAvailSeatsId <= 0 THEN 0 ELSE 1 END AS BIT) AS IsAvailable,
			CAST(CASE WHEN fi.FactHeldSeatsId IS NULL OR fi.FactHeldSeatsId <=0 THEN 0 ELSE 1 END AS BIT) AS IsHeld,
			CAST(CASE WHEN fi.FactTicketSalesId IS NULL OR fi.FactTicketSalesId <= 0 THEN 0 ELSE 1 END AS BIT) AS IsSold,
			1 AS IsSaleable
		FROM [ro].[vw_FactInventory] fi
		INNER JOIN [ro].[vw_DimSeat] dst (NOLOCK)  
			ON  fi.DimSeatId = dst.DimSeatId
		WHERE fi.DimSeasonId IN (10,27)
)
SELECT
	fi.DimSeasonId,
	fi.DimEventId,
    CAST(fts.OrderDate AS DATE) AS SaleDate,
    CONVERT(TIME, fts.OrderDate, 114) AS SaleTime,
    fts.OrderDate SaleDateTime,
    --fts.ETL__SSID_TM_acct_id AS TicketingAccountId,
    da.ArenaCode,
    da.ArenaName,
    dsh.SeasonCode SeasonHeaderCode,
    dsh.SeasonName SeasonHeaderName, 
    dsh.SeasonDesc SeasonHeaderDesc, 
    dsh.SeasonClass SeasonHeaderClass, 
    dsh.SeasonYear SeasonHeaderYear, 
    dsh.IsActive SeasonHeaderIsActive, 
    ds.SeasonName, 
    ds.SeasonYear, 
    ds.SeasonClass, 
    ds.Config_Org Sport, 
    deh.EventName EventHeaderName, 
    deh.EventDesc EventHeaderDesc, 
    deh.EventDate EventHeaderDate, 
    deh.EventTime EventHeaderTime, 
    deh.EventDateTime EventHeaderDateTime, 
    deh.EventOpenTime EventHeaderOpenTime, 
    deh.EventFinishTime EventHeaderFinishTime, 
    --deh.EventSeasonNumber EventSeasonNumber, 
    deh.HomeGameNumber EventHeaderHomeNumber, 
    deh.GameTypeNumber EventHeaderGameNumber, 
    deh.EventHierarchyL1, 
    deh.EventHierarchyL2, 
    deh.EventHierarchyL3, 
    deh.EventHierarchyL4, 
    deh.EventHierarchyL5, 
    de.EventCode, 
    de.EventName, 
    de.EventDate, 
    de.EventTime, 
    de.EventDateTime, 
    de.EventClass,
    de.TM_major_category AS MajorCategoryTM,
    de.TM_minor_category AS MinorCategoryTM,
    di.ItemCode,
    di.ItemName,
    di.ItemClass AS ItemPlanOrEvent, --Maybe remove
    dpl.PlanCode,
    dpl.PlanName,
    dpl.PlanClass,
    dpl.PlanFSE,
    dpl.PlanType,
    dpl.PlanEventCnt,
    dpc.PriceCode,
    dpc.PC1,
    dpc.PC2,
    dpc.PC3,
    dpc.PC4,
    dpc.PriceCodeDesc,
    dpc.PriceCodeGroup,
    dst.SectionName,
    dst.RowName,
    dst.Seat,
    dst.Config_Location AS SeatLocationMapping,
    dtc.TicketClassCode,
    dtc.TicketClassName,
    dtt.TicketTypeCode,
    dtt.TicketTypeName,
    dpt.PlanTypeCode,
    dpt.PlanTypeName,
    dstp.SeatTypeCode,
    dstp.SeatTypeName,
    /*-----------------------------------------------
    What is TM v2 equivelent of former: DimClassTM?
    -------------------------------------------------
    dctm.ClassName,
    dctm.DistStatus,
    -----------------------------------------------*/
    dsc.SalesCode,
    dsc.SalesCodeName,
    dpm.PromoCode,
    dpm.PromoName,
 
    /*-----------------------------------------------
    What about the Manifested Price Codes and Classes?
    -------------------------------------------------
    dpc_Manifest.PriceCode ManifestedPriceCode,
    dctm_Manifest.ClassName ManifestedClassName
    -----------------------------------------------*/
    a_dpc.PriceCode AS ManifestedPriceCode,
    a_dtc.TicketClassName AS ManifestedClassName,
	a_dtt.TicketTypeName AS ManifestedTicketTypeName,
 
    fi.SeatValue AS ManifestedSeatValue,
 
    /*-----------------------------------------------
    What about the Posted Price Codes and Classes
    and Posted Seat Value?
    -------------------------------------------------
    dpc_Posted.PriceCode PostedPriceCode,
    dctm_Posted.ClassName PostedClassName
    fi.PostedSeatValue
    -----------------------------------------------*/
 
    a_dpc.PriceCode AS PostedPriceCode,
    a_dtc.TicketClassName AS PostedClassName,
	fas.TM_price AS PostedSeatValue,

    /*-----------------------------------------------
    1 AS IsSaleable, --This needs refined
    -----------------------------------------------*/
    h_dpc.PriceCode AS HeldPriceCode,
    h_dtc.TicketClassName AS HeldClassName,
	fhs.TM_price AS HeldSeatValue,

    CAST(1 AS BIT) AS IsSaleable, --This needs refined
    CAST(CASE WHEN fi.FactAvailSeatsId IS NULL OR fi.FactAvailSeatsId <= 0 THEN 0 ELSE 1 END AS BIT) AS IsAvailable,
    CAST(CASE WHEN fi.FactHeldSeatsId IS NULL OR fi.FactHeldSeatsId <=0 THEN 0 ELSE 1 END AS BIT) AS IsHeld,
    CAST(ISNULL(fts.IsReserved, 0) AS BIT) AS IsReserved,
    CAST(CASE WHEN fi.FactTicketSalesId IS NULL OR fi.FactTicketSalesId <= 0 THEN 0 ELSE 1 END AS BIT) AS IsSold,
    CAST(ISNULL(fts.IsHost, 0) AS BIT) AS IsHost,
    CAST(ISNULL(fts.IsComp, 0) AS BIT) AS IsComp,
    /*-----------------------------------------------
    What about Comp code and CompName?
    -------------------------------------------------
    fts.CompCode,
    fts.CompName
    -----------------------------------------------*/
    CAST(ISNULL(fts.IsPremium, 0) AS BIT) AS IsPremium,
    CAST(ISNULL(fts.IsSingleEvent, 0) AS BIT) AS IsSingleEvent,
    CAST(ISNULL(fts.IsPlan, 0) AS BIT) AS IsPlan,
    CAST(ISNULL(fts.IsPartial, 0) AS BIT) AS IsPartial,
    CAST(ISNULL(fts.IsGroup, 0) AS BIT) AS IsGroup,
    CAST(ISNULL(fts.IsRenewal, 0) AS BIT) AS IsRenewal,
    CAST(ISNULL(fts.IsBroker, 0)  AS BIT) AS IsBroker,

	fts.TM_pc_ticket AS TotalRevenue,
    /*-----------------------------------------------
    What are these values / calcs?
    -------------------------------------------------
    fts.TotalRevenue,
    fts.TotalRevenue AS PurchasePrice,
    fts.PcTicketValue,
    fts.Surcharge,
    -----------------------------------------------*/
    fts.TM_pc_ticket AS PcTicket,
    fts.TM_pc_tax AS PcTax,
    fts.TM_pc_licfee AS PcLicenseFee,
    fts.TM_pc_other1 AS PcOther1,
    fts.TM_pc_other2 AS PcOther2,
    CAST(CASE WHEN fi.FactAttendanceId IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS IsAttended,
    fa.ScanDateTime,
    dsg.ScanGateName AS ScanGate,
    CASE WHEN fi.FactTicketSalesId IS NOT NULL THEN 1 ELSE 0 END AS QtySeat,
    (fts.QtySeatFSE / CAST(CASE WHEN fi.FactTicketSalesId IS NOT NULL THEN 1 ELSE 0 END AS DECIMAL(18,6)) ) AS QtySeatFSE,
    fts.PaidAmount,
    fts.OwedAmount,
    fts.TM_order_num AS OrderNum,
    fts.TM_order_line_item AS OrderLineItem,
    fts.TM_retail_ticket_type AS RetailTicketType,
    fts.TM_retail_qualifiers AS RetailQualifiers,
    CAST(CASE WHEN fi.FactTicketActivityId_Resold IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS IsResold,
    ftar.DimTicketCustomerId_Recipient AS ResoldDimCustomerId,
    ftar.TransDateTime AS ResoldDateTime,
    ftar.SubTotal / ftar.QtySeat AS ResoldPurchasePrice,
    ftar.Fees / ftar.QtySeat AS ResoldFees,
    ftar.Total / ftar.QtySeat AS ResoldTotalAmount,
    fts.TM_sales_source_name AS SalesSource,
    fts.TM_group_sales_name AS GroupSalesName,
    fts.CreatedBy AS ArchticsAddUser,
    /*-----------------------------------------------
    What are these values?
    -------------------------------------------------
    fts.DimCustomerIdSalesRep,
    DimCustomerId_TransSalesRep,
    -----------------------------------------------*/
    fi.ETL__SSID_TM_event_id AS SSID_event_id,
    fi.ETL__SSID_TM_section_id AS SSID_section_id,
    fi.ETL__SSID_TM_row_id AS SSID_row_id,
    fi.ETL__SSID_TM_seat AS SSID_seat,
    0 as SeatCenter_X,
    0 as SeatCenter_Y,
    0 as X,
    0 as Y,
    --CAST(CASE WHEN ((ls.IsSold = 0 AND ls.IsSaleable = 1) OR (rs.IsSold = 0 AND rs.IsSaleable = 1)) AND fi.FactTicketSalesId IS NULL /*AND fi.IsSaleable = 1*/ THEN 1 ELSE 0 END AS BIT) AS IsPair
	CAST(CASE
		WHEN 
			(
				(fi.FactTicketSalesId IS NULL)
				--AND (fi.FactAvailSeatsId IS NULL)
				--AND (fi.FactHeldSeatsId IS NULL)
			)
			AND (
					(
						ls.FactTicketSalesId IS NULL AND ls.ETL__SSID_TM_seat IS NOT NULL
						--AND ls.FactHeldSeatsId IS NULL
						--AND ls.FactAvailSeatsId IS NOT NULL
					)
				OR (
						rs.FactTicketSalesId IS NULL AND rs.ETL__SSID_TM_seat IS NOT NULL
						--AND rs.FactHeldSeatsId IS NULL
						--AND rs.FactAvailSeatsId IS NOT NULL
					)
			)
		THEN 1
		ELSE 0
		END AS BIT) AS IsPair
    /*-----------------------------------------------
    I haven't had a chance yet for these...
    -------------------------------------------------
    dc.FirstName + ' ' + dc.LastName AS CustomerName,
    dcAR.FirstName + ' ' + dcAR.LastName AS AccountRep,
    x.SeatTotalResoldPurchasePrice,
    x.SeatTotalResoldFees,
    x.SeatTotalResoldTotalAmount,
    x.SeatTotalRecordCount
    -----------------------------------------------*/
FROM [ro].[vw_FactInventory] fi 
 
INNER JOIN [ro].[vw_DimSeason] ds ON fi.DimSeasonId = ds.DimSeasonId
INNER JOIN [ro].[vw_DimArena] da ON fi.DimArenaId = da.DimArenaId
INNER JOIN [ro].[vw_DimEvent] de ON fi.DimEventId = de.DimEventId
LEFT JOIN [ro].[vw_DimEventHeader] deh ON de.DimEventHeaderId = deh.DimEventHeaderId  --FK
LEFT JOIN [ro].[vw_DimSeasonHeader] dsh ON deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId --FK
INNER JOIN [ro].[vw_DimSeat] dst ON fi.DimSeatId = dst.DimSeatId
INNER JOIN [ro].[vw_DimSeatStatus] dss ON fi.DimSeatStatusid = dss.DimseatStatusId
 
LEFT OUTER JOIN [ro].[vw_FactTicketSales] fts ON fi.FactTicketSalesId = fts.FactTicketSalesId
LEFT OUTER JOIN [ro].[vw_FactTicketActivity] ftar ON fi.FactTicketActivityId_Resold = ftar.FactTicketActivityId
LEFT OUTER JOIN [ro].[vw_FactAttendance] fa ON fi.FactAttendanceId = fa.FactAttendanceId
LEFT OUTER JOIN [ro].[vw_DimScanGate] dsg ON fa.DimScanGateId = dsg.DimScanGateId
 
--LEFT OUTER JOIN [ro].[vw_DimPriceType] dpt ON fo.DimPriceTypeId = dpt.DimPriceTypeId
LEFT OUTER JOIN [ro].[vw_DimItem] di ON fts.DimItemId = di.DimItemId
LEFT OUTER JOIN [ro].[vw_DimPlan] dpl ON fts.DimPlanId = dpl.DimPlanId 
LEFT OUTER JOIN [ro].[vw_DimPriceCode] dpc ON fts.DimPriceCodeId = dpc.DimPriceCodeId
LEFT OUTER JOIN [ro].[vw_DimTicketClass] dtc ON fts.DimTicketClassId = dtc.DimTicketClassId
LEFT OUTER JOIN [ro].[vw_DimTicketType] dtt ON fts.DimTicketTypeId = dtt.DimTicketTypeId
LEFT OUTER JOIN [ro].[vw_DimPlanType] dpt ON fts.DimPlanTypeId = dpt.DimPlanTypeId
LEFT OUTER JOIN [ro].[vw_DimSeatType] dstp ON fts.DimSeatTypeId = dstp.DimSeatTypeId

LEFT OUTER JOIN [ro].[vw_FactHeldSeats] fhs ON  fi.FactHeldSeatsId = fhs.FactHeldSeatsId
LEFT OUTER JOIN [ro].[vw_DimPriceCode] h_dpc ON fhs.DimPriceCodeId = h_dpc.DimPriceCodeId
LEFT OUTER JOIN [ro].[vw_DimTicketClass] h_dtc ON fhs.DimTicketClassId = h_dtc.DimTicketClassId

LEFT OUTER JOIN [ro].[vw_FactAvailSeats] fas ON  fi.FactAvailSeatsId = fas.FactAvailSeatsId
LEFT OUTER JOIN [ro].[vw_DimPriceCode] a_dpc ON fas.DimPriceCodeId = a_dpc.DimPriceCodeId
LEFT OUTER JOIN [ro].[vw_DimTicketClass] a_dtc ON fas.DimTicketClassId = a_dtc.DimTicketClassId
LEFT OUTER JOIN [ro].[vw_DimTicketType] a_dtt ON fas.DimTicketTypeId = a_dtt.DimTicketTypeId

 
--LEFT OUTER JOIN [ro].[vw_DimCustomer_Base] dc ON dc.SourceSystem = 'Paciolan' AND fo.ETL__SSID_PAC_CUSTOMER = dc.SSID
     
LEFT OUTER JOIN [ro].[vw_DimSalesCode] dsc ON fts.DimSalesCodeId = dsc.DimSalesCodeId
LEFT OUTER JOIN [ro].[vw_DimPromo] dpm ON fts.DimPromoId = dpm.DimPromoID
--LEFT OUTER JOIN [ro].[vw_Seat_Coordinates] sc ON  dst.SectionName = sc.Section AND dst.RowName = sc.[Row] AND dst.Seat = sc.Seat

LEFT OUTER JOIN CTE_Inventory ls
	ON  fi.DimSeasonId = ls.DimSeasonId
	AND fi.DimEventId = ls.DimEventId
	AND fi.ETL__SSID_TM_section_id = ls.ETL__SSID_TM_section_id
	AND fi.ETL__SSID_TM_row_id = ls.ETL__SSID_TM_row_id
	AND TRY_CAST(dst.Seat AS INT) = (ls.Seat + 1)
LEFT OUTER JOIN CTE_Inventory rs
	ON  fi.DimSeasonId = rs.DimSeasonId
	AND fi.DimEventId = rs.DimEventId
	AND fi.ETL__SSID_TM_section_id = rs.ETL__SSID_TM_section_id
	AND fi.ETL__SSID_TM_row_id = rs.ETL__SSID_TM_row_id
	AND TRY_CAST(dst.Seat AS INT) = (rs.Seat - 1)
 
--WHERE fi.[FactTicketActivityId_Resold] IS NOT NULL
--WHERE di.itemname = 'The Weeknd' --AND dst.SectionName = 'LOGE06' AND dst.rowname = '3C' --AND dst.seat = '1' 
--)
WHERE ds.DimSeasonId IN (10,27)
	AND de.EventName <> 'Map Dummy'
	AND dst.SectionName NOT LIKE 'ADD%'
	--AND DE.EventCode = '160927'
	--AND DST.Seat = 4
	--AND DST.SectionName = '419'
	--AND dst.RowName = 'A'
GO
