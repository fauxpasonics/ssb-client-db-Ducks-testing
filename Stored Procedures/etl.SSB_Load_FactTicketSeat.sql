SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [etl].[SSB_Load_FactTicketSeat]
	@DaysBack INT = 1, @InitialLoad BIT = 0
AS
BEGIN
	--EXEC [etl].[SSB_Load_FactTicketSeat], 1, 0
	SET ANSI_WARNINGS OFF
	SET NOCOUNT ON
	  
	BEGIN TRY  
		BEGIN TRAN
			--DECLARE @DaysBack INT = 1, @InitialLoad BIT = 1

			IF OBJECT_ID('tempdb..#FactInventory_ChangeLog') IS NOT NULL
			BEGIN
				DROP TABLE #FactInventory_ChangeLog
			END

			SELECT fi.FactInventoryId
			INTO #FactInventory_ChangeLog
			FROM ro.vw_FactTicketSales fts
			INNER JOIN ro.vw_FactInventory fi
				ON  fts.FactTicketSalesId = fi.FactTicketSalesId
			INNER JOIN ro.vw_DimSeason ds
				ON  fts.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (fts.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR fts.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR @InitialLoad = 1
				)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactAttendance fa
			INNER JOIN ro.vw_FactInventory fi
				ON  fa.FactAttendanceId = fi.FactAttendanceId
			INNER JOIN ro.vw_DimSeason ds
				ON  fa.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (fa.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR fa.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR @InitialLoad = 1
				)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactTicketActivity fta
			INNER JOIN ro.vw_FactInventory fi
				ON  fta.FactTicketActivityId = fi.FactTicketActivityId_Resold
			INNER JOIN ro.vw_DimSeason ds
				ON  fta.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (fta.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR fta.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR @InitialLoad = 1
				)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactTicketActivity ftt
			INNER JOIN ro.vw_FactInventory fi
				ON  ftt.FactTicketActivityId = fi.FactTicketActivityId_Tranferred
			INNER JOIN ro.vw_DimSeason ds
				ON  ftt.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (ftt.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR ftt.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR @InitialLoad = 1
				)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactAvailSeats fas
			INNER JOIN ro.vw_FactInventory fi
				ON  fas.FactAvailSeatsId = fi.FactAvailSeatsId
			INNER JOIN ro.vw_DimSeason ds
				ON  fas.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (fas.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR fas.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR @InitialLoad = 1
				)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactHeldSeats fhs
			INNER JOIN ro.vw_FactInventory fi
				ON  fhs.FactHeldSeatsId = fi.FactHeldSeatsId
			INNER JOIN ro.vw_DimSeason ds
				ON  fhs.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (fhs.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR fhs.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR @InitialLoad = 1
				)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (fi.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR fi.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					OR @InitialLoad = 1
				)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (ds.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR ds.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimArena da
				ON  fi.DimArenaId = da.DimArenaId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (da.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR da.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			--Where DimEvent changed.. total of 3 times for DimEvent, DimEventHeader, and DimSeasonHeader
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimEvent de
				ON  fi.DimEventId = de.DimEventId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (de.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR de.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			--Where DimEventHeader changed.. total of 3 times for DimEvent, DimEventHeader, and DimSeasonHeader
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimEvent de
				ON  fi.DimEventId = de.DimEventId
			INNER JOIN ro.vw_DimEventHeader deh
				ON  de.DimEventHeaderId = deh.DimEventHeaderId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (deh.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR deh.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			--Where DimSeasonHeader changed.. total of 3 times for DimEvent, DimEventHeader, and DimSeasonHeader
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimEvent de
				ON  fi.DimEventId = de.DimEventId
			INNER JOIN ro.vw_DimEventHeader deh
				ON  de.DimEventHeaderId = deh.DimEventHeaderId
			INNER JOIN ro.vw_DimSeasonHeader dsh
				ON  deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (dsh.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dsh.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimSeatStatus dss
				ON  fi.DimSeatStatusId = dss.DimSeatStatusId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (dss.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dss.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimSeatStatus dss
				ON  fi.DimSeatStatusId = dss.DimSeatStatusId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (dss.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dss.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_FactAttendance fa
				ON  fi.FactAttendanceId = fa.FactAttendanceId
			INNER JOIN ro.vw_DimScanGate dsg
				ON  fa.DimScanGateId = dsg.DimScanGateId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (dsg.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dsg.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_FactAvailSeats fas
				ON  fi.FactAvailSeatsId = fas.FactAvailSeatsId
			INNER JOIN ro.vw_DimSeatStatus dss
				ON  fas.DimSeatStatusId = dss.DimSeatStatusId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (dss.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dss.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
					)
			UNION
			SELECT fi.FactInventoryId
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_FactHeldSeats fhs
				ON  fi.FactHeldSeatsId = fhs.FactHeldSeatsId
			INNER JOIN ro.vw_DimSeatStatus dss
				ON  fhs.DimSeatStatusId = dss.DimSeatStatusId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
				AND ds.SeasonClass = 'Seating'
			WHERE (dss.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dss.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
				)

			IF OBJECT_ID('tempdb..#FTS') IS NOT NULL
			BEGIN
				DROP TABLE #FTS
			END

			SELECT	
				fts.FactTicketSalesId,
				fts.DimSeasonId,
				CAST(fts.OrderDate AS DATE) AS SaleDate,
				CONVERT(TIME, fts.OrderDate, 114) AS SaleTime,
				fts.OrderDate SaleDateTime,
				fts.ETL__SSID_TM_acct_id AS TicketingAccountId,
				fts.DimItemId,
				di.ItemCode,
				di.ItemName,
				di.ItemType AS ItemPlanOrEvent,
				fts.DimPlanId,
				dpl.PlanCode,
				dpl.PlanName,
				dpl.PlanClass,
				dpl.PlanFSE,
				dpl.PlanType,
				dpl.PlanEventCnt,
				fts.DimPriceCodeId,
				dpc.PriceCode,
				dpc.PC1,
				dpc.PC2,
				dpc.PC3,
				dpc.PC4,
				dpc.PriceCodeDesc,
				dpc.PriceCodeGroup,
				fts.DimTicketClassId,
				dtc.TicketClassCode,
				dtc.TicketClassName,
				fts.DimTicketTypeId,
				dtt.TicketTypeCode,
				dtt.TicketTypeName,
				fts.DimPlanTypeId,
				dpt.PlanTypeCode,
				dpt.PlanTypeName,
				fts.DimSeatTypeId,
				dstp.SeatTypeCode,
				dstp.SeatTypeName,
				fts.DimSeatStatusId,
				ftsss.SeatStatusName ClassName,
				ftsss.TM_dist_status DistStatus,
				fts.DimSalesCodeId,
				dsc.SalesCode,
				dsc.SalesCodeName,
				fts.DimPromoId,
				dpm.PromoCode,
				dpm.PromoName,
				CAST(ISNULL(fts.IsReserved, 0) AS BIT) AS IsReserved,
				CAST(ISNULL(fts.IsHost, 0) AS BIT) AS IsHost,
				CAST(ISNULL(fts.IsComp, 0) AS BIT) AS IsComp,
				fts.TM_comp_code,
				fts.TM_comp_name,
				CAST(ISNULL(fts.IsPremium, 0) AS BIT) AS IsPremium,
				CAST(ISNULL(fts.IsSingleEvent, 0) AS BIT) AS IsSingleEvent,
				CAST(ISNULL(fts.IsPlan, 0) AS BIT) AS IsPlan,
				CAST(ISNULL(fts.IsPartial, 0) AS BIT) AS IsPartial,
				CAST(ISNULL(fts.IsGroup, 0) AS BIT) AS IsGroup,
				CAST(ISNULL(fts.IsRenewal, 0) AS BIT) AS IsRenewal,
				CAST(ISNULL(fts.IsBroker, 0) AS BIT) AS IsBroker,
				(fts.RevenueTotal / CAST(fts.QtySeat AS DECIMAL(18,6))) TotalRevenue,
				fts.TM_purchase_price PurchasePrice,
				fts.TM_pc_ticket PcTicketValue,
				fts.RevenueSurcharge Surcharge,
				fts.QtySeatFSE,
				fts.TM_pc_ticket AS PcTicket,
				fts.TM_pc_tax AS PcTax,
				fts.TM_pc_licfee AS PcLicenseFee,
				fts.TM_pc_other1 AS PcOther1,
				fts.TM_pc_other2 AS PcOther2,
				fts.PaidAmount,
				fts.OwedAmount,
				fts.TM_order_num AS OrderNum,
				fts.TM_order_line_item AS OrderLineItem,
				fts.TM_retail_ticket_type AS RetailTicketType,
				fts.TM_retail_qualifiers AS RetailQualifiers,
				fts.TM_sales_source_name AS SalesSource,
				fts.TM_group_sales_name AS GroupSalesName,
				fts.CreatedBy AS ArchticsAddUser,
				drep_trans.ETL__SSID_TM_acct_id AS DimCustomerIdSalesRep, 
				drep_cust.ETL__SSID_TM_acct_id DimCustomerId_TransSalesRep,
				fts.DimTicketCustomerId,
				dtcust.DimRepId,
				dtcust.CustomerId,
				dtcust.FullName CustomerName,
				drep_cust.FullName AccountRep
			INTO #FTS
			FROM ro.vw_FactTicketSales fts
			INNER JOIN ro.vw_DimItem di ON fts.DimItemId = di.DimItemId
			INNER JOIN ro.vw_DimPlan dpl ON fts.DimPlanId = dpl.DimPlanId 
			INNER JOIN ro.vw_DimPriceCode dpc ON fts.DimPriceCodeId = dpc.DimPriceCodeId
			INNER JOIN ro.vw_DimTicketClass dtc ON fts.DimTicketClassId = dtc.DimTicketClassId
			INNER JOIN ro.vw_DimTicketType dtt ON fts.DimTicketTypeId = dtt.DimTicketTypeId
			INNER JOIN ro.vw_DimPlanType dpt ON fts.DimPlanTypeId = dpt.DimPlanTypeId
			INNER JOIN ro.vw_DimSeatType dstp ON fts.DimSeatTypeId = dstp.DimSeatTypeId
			INNER JOIN ro.vw_DimSeatStatus ftsss ON fts.DimSeatStatusId = ftsss.DimSeatStatusId
			INNER JOIN ro.vw_DimSalesCode dsc ON fts.DimSalesCodeId = dsc.DimSalesCodeId
			INNER JOIN ro.vw_DimPromo dpm ON fts.DimPromoId = dpm.DimPromoID
			INNER JOIN ro.vw_DimRep drep_trans ON fts.DimRepId = drep_trans.DimRepId
			INNER JOIN ro.vw_DimTicketCustomer dtcust ON fts.DimTicketCustomerId = dtcust.DimTicketCustomerId
			INNER JOIN ro.vw_DimRep drep_cust ON dtcust.DimRepId = drep_cust.DimRepId
			INNER JOIN ro.vw_DimSeason ds ON  fts.DimSeasonId = ds.DimSeasonId
			WHERE (fts.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR fts.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR di.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR di.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dpl.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dpl.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dpc.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dpc.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dtc.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dtc.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dtt.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dtt.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dpt.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dpt.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dstp.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dstp.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR ftsss.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR ftsss.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dsc.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dsc.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dpm.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dpm.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR drep_trans.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR drep_trans.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dtcust.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR dtcust.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR drep_trans.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR drep_trans.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR ds.ETL__CreatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR ds.ETL__UpdatedDate >= DATEADD(dd, -@DaysBack, GETDATE())
						OR @InitialLoad = 1)
				AND ds.SeasonClass = 'Seating'

			IF OBJECT_ID('tempdb..#FI') IS NOT NULL
			BEGIN
				DROP TABLE #FI
			END

			SELECT
				fi.FactInventoryId, 
				fi.DimArenaId, 
				fi.DimSeasonId, 
				fi.DimEventId, 
				fi.DimSeatId, 
				dst.SectionName,
				dst.RowName,
				TRY_CAST(dst.Seat AS INT) AS Seat,
				(TRY_CAST(dst.Seat AS INT) - 1) AS SeatRight,
				(TRY_CAST(dst.Seat AS INT) + 1) AS SeatLeft,
				dst.Config_Location AS SeatLocationMapping,
				dst.Config_LevelName AS SeatLevelName,
				dst.DefaultPriceCode AS ManifestedPriceCode,
				dst.config_isCapacityEligible,
				CAST(dst.TM_class_name AS NVARCHAR(255)) AS ManifestedClassName,
				CAST(0 AS DECIMAL(18,6)) AS ManifestedSeatValue,
				CAST(CASE WHEN fi.FactAvailSeatsId IS NULL OR fi.FactAvailSeatsId <= 0 OR dss.SeatStatusCode = 'SOLD' THEN 0 ELSE 1 END AS BIT) AS IsAvailable,
				CAST(CASE WHEN fi.FactHeldSeatsId IS NULL OR fi.FactHeldSeatsId <= 0 THEN 0 ELSE 1 END AS BIT) AS IsHeld,
				CAST(CASE WHEN fi.FactTicketSalesId IS NULL OR fi.FactTicketSalesId <= 0 THEN 0 ELSE 1 END AS BIT) AS IsSold,
				CAST(CASE WHEN dss.IsKill = 1 OR dst.config_iscapacityeligible = 0 OR dst.TM_class_name = 'Killed' OR dst.TM_class_name = 'Kills' THEN 0 ELSE 1 END AS BIT) AS IsSaleable,
				fi.ETL__SourceSystem, 
				fi.ETL__CreatedBy, 
				fi.ETL__CreatedDate, 
				fi.ETL__UpdatedDate, 
				fi.ETL__SSID_TM_event_id, 
				fi.ETL__SSID_TM_section_id, 
				fi.ETL__SSID_TM_row_id, 
				fi.ETL__SSID_TM_seat, 
				fi.DimSeatStatusId, 
				fi.SeatValue, 
				fi.FactTicketSalesId, 
				fi.FactAttendanceId, 
				fi.FactTicketActivityId_Resold, 
				fi.FactTicketActivityId_Tranferred, 
				fi.ETL__SSID, 
				fi.FactAvailSeatsId, 
				fi.FactHeldSeatsId, 
				fi.ETL_Sync_DeltaHashKey
			INTO #FI
			FROM ro.vw_FactInventory fi
			INNER JOIN ro.vw_DimSeat dst  
				ON  fi.DimSeatId = dst.DimSeatId
			INNER JOIN ro.vw_DimSeatStatus dss 
				ON  fi.DimSeatStatusid = dss.DimseatStatusId
			LEFT OUTER JOIN #FactInventory_ChangeLog cl
				ON  fi.FactInventoryId = cl.FactInventoryId
			INNER JOIN ro.vw_DimSeason ds
				ON  fi.DimSeasonId = ds.DimSeasonId
			WHERE (cl.FactInventoryId IS NOT NULL
					OR @InitialLoad = 1)
				AND ds.SeasonClass = 'Seating'

			IF OBJECT_ID('tempdb..#DC') IS NOT NULL
			BEGIN
				DROP TABLE #DC
			END
			SELECT 
				AccountId,
				SSID,
				SourceSystem
			INTO #DC
			FROM (
					SELECT DISTINCT 
						dc.AccountId, 
						dc.SSID,
						dc.SourceSystem,
						ROW_NUMBER() OVER (PARTITION BY AccountId ORDER BY customer_matchkey DESC, matchkey_updatedate DESC, DimCustomerId DESC) AS xRowNum
					FROM dbo.DimCustomer dc (NOLOCK) 
					WHERE dc.SourceSystem = 'CRM_Contact'
				) A
			WHERE A.xRowNum = 1

			CREATE CLUSTERED INDEX IX_DC_Temp ON #DC (AccountId)

			IF OBJECT_ID('tempdb..#DC_TM') IS NOT NULL
			BEGIN
				DROP TABLE #DC_TM
			END
			SELECT dc_r2.AccountId, dc_r2.DimCustomerId
			INTO #DC_TM
			FROM ro.vw_DimCustomer dc_r2 
			WHERE dc_r2.SourceSystem = 'TM' 
				AND dc_r2.CustomerType = 'Primary'

			IF OBJECT_ID (N'stg.dbo__FactTicketSeat_V2', N'U') IS NOT NULL 
			BEGIN
				DROP TABLE stg.dbo__FactTicketSeat_V2
			END

			CREATE TABLE stg.dbo__FactTicketSeat_V2 (
				[SaleDate] [DATE] NULL,
				[SaleTime] [TIME](7) NULL,
				[SaleDateTime] [DATETIME] NULL,
				[TicketingAccountId] [INT] NULL,
				[DimArenaId] [INT] NOT NULL,
				[ArenaCode] [NVARCHAR](25) NULL,
				[ArenaName] [NVARCHAR](100) NULL,
				[DimSeasonHeaderId] [INT] NOT NULL,
				[SeasonHeaderCode] [NVARCHAR](50) NULL,
				[SeasonHeaderName] [NVARCHAR](200) NULL,
				[SeasonHeaderDesc] [NVARCHAR](500) NULL,
				[SeasonHeaderClass] [NVARCHAR](50) NULL,
				[SeasonHeaderYear] [INT] NULL,
				[SeasonHeaderIsActive] [BIT] NULL,
				[DimSeasonId] [INT] NOT NULL,
				[SeasonName] [NVARCHAR](100) NULL,
				[SeasonYear] [INT] NULL,
				[SeasonClass] [NVARCHAR](50) NULL,
				[Sport] [NVARCHAR](25) NULL,
				[DimEventHeaderId] [INT] NOT NULL,
				[EventHeaderName] [NVARCHAR](255) NULL,
				[EventHeaderDesc] [NVARCHAR](500) NULL,
				[EventHeaderDate] [DATE] NULL,
				[EventHeaderTime] [TIME](7) NULL,
				[EventHeaderDateTime] [DATETIME] NULL,
				[EventHeaderOpenTime] [DATETIME] NULL,
				[EventHeaderFinishTime] [DATETIME] NULL,
				[EventSeasonNumber] [INT] NULL,
				[EventHeaderHomeNumber] [INT] NULL,
				[EventHeaderGameNumber] [INT] NULL,
				[EventLevel] [NVARCHAR](50) NULL,
				[EventHierarchyL1] [NVARCHAR](255) NULL,
				[EventHierarchyL2] [NVARCHAR](255) NULL,
				[EventHierarchyL3] [NVARCHAR](255) NULL,
				[EventHierarchyL4] [NVARCHAR](255) NULL,
				[EventHierarchyL5] [NVARCHAR](255) NULL,
				[GameType] [NVARCHAR](255) NULL,
				[DimEventId] [INT] NOT NULL,
				[EventCode] [NVARCHAR](50) NULL,
				[EventName] [NVARCHAR](100) NULL,
				[EventDate] [DATE] NULL,
				[EventTime] [TIME](7) NULL,
				[EventDateTime] [DATETIME] NULL,
				[EventClass] [NVARCHAR](50) NULL,
				[MajorCategoryTM] [NVARCHAR](255) NULL,
				[MinorCategoryTM] [NVARCHAR](255) NULL,
				[DimItemId] [INT] NULL,
				[ItemCode] [NVARCHAR](50) NULL,
				[ItemName] [NVARCHAR](255) NULL,
				[ItemPlanOrEvent] [NVARCHAR](25) NULL,
				[DimPlanId] [INT] NULL,
				[PlanCode] [NVARCHAR](50) NULL,
				[PlanName] [NVARCHAR](100) NULL,
				[PlanClass] [NVARCHAR](50) NULL,
				[PlanFSE] [DECIMAL](18, 6) NULL,
				[PlanType] [NVARCHAR](25) NULL,
				[PlanEventCnt] [INT] NULL,
				[DimPriceCodeId] [INT] NULL,
				[PriceCode] [NVARCHAR](25) NULL,
				[PC1] [NVARCHAR](1) NULL,
				[PC2] [NVARCHAR](1) NULL,
				[PC3] [NVARCHAR](1) NULL,
				[PC4] [NVARCHAR](1) NULL,
				[PriceCodeDesc] [NVARCHAR](255) NULL,
				[PriceCodeGroup] [NVARCHAR](50) NULL,
				[DimSeatId] [INT] NOT NULL,
				[SectionName] [NVARCHAR](50) NULL,
				[RowName] [NVARCHAR](50) NULL,
				[Seat] [INT] NULL,
				[SeatLocationMapping] [NVARCHAR](50) NULL,
				[SeatLevelName] [NVARCHAR](50) NULL,
				[DimTicketClassId] [INT] NULL,
				[TicketClassCode] [NVARCHAR](25) NULL,
				[TicketClassName] [NVARCHAR](100) NULL,
				[DimTicketTypeId] [INT] NULL,
				[TicketTypeCode] [NVARCHAR](25) NULL,
				[TicketTypeName] [NVARCHAR](100) NULL,
				[DimPlanTypeId] [INT] NULL,
				[PlanTypeCode] [NVARCHAR](25) NULL,
				[PlanTypeName] [NVARCHAR](100) NULL,
				[DimSeatTypeId] [INT] NULL,
				[SeatTypeCode] [NVARCHAR](25) NULL,
				[SeatTypeName] [NVARCHAR](100) NULL,
				[DimSeatStatusId] [INT] NULL,
				[ClassName] [NVARCHAR](100) NULL,
				[DistStatus] [NVARCHAR](255) NULL,
				[DimSalesCodeId] [INT] NULL,
				[SalesCode] [NVARCHAR](50) NULL,
				[SalesCodeName] [NVARCHAR](100) NULL,
				[DimPromoId] [INT] NULL,
				[PromoCode] [NVARCHAR](50) NULL,
				[PromoName] [NVARCHAR](255) NULL,
				[ManifestedPriceCode] [NVARCHAR](255) NULL,
				[ManifestedClassName] [NVARCHAR](255) NULL,
				[ManifestedSeatValue] [DECIMAL](18, 6) NULL,
				[PostedPriceCode] [NVARCHAR](5) NULL,
				[PostedClassName] [NVARCHAR](100) NULL,
				[PostedSeatValue] [DECIMAL](18, 6) NULL,
				[HeldPriceCode] [NVARCHAR](5) NULL,
				[HeldClassName] [NVARCHAR](100) NULL,
				[HeldSeatValue] [DECIMAL](18, 6) NULL,
				[IsSaleable] [BIT] NULL,
				[IsAvailable] [BIT] NULL,
				[IsHeld] [BIT] NULL,
				[IsReserved] [BIT] NOT NULL,
				[IsSold] [BIT] NULL,
				[IsHost] [BIT] NOT NULL,
				[IsComp] [BIT] NOT NULL,
				[TM_comp_code] [INT] NULL,
				[TM_comp_name] [NVARCHAR](255) NULL,
				[IsPremium] [BIT] NOT NULL,
				[IsSingleEvent] [BIT] NOT NULL,
				[IsPlan] [BIT] NOT NULL,
				[IsPartial] [BIT] NOT NULL,
				[IsGroup] [BIT] NOT NULL,
				[IsRenewal] [BIT] NOT NULL,
				[IsBroker] [BIT] NOT NULL,
				[TotalRevenue] [DECIMAL](38, 20) NULL,
				[PurchasePrice] [DECIMAL](18, 6) NULL,
				[PcTicketValue] [DECIMAL](18, 6) NULL,
				[Surcharge] [DECIMAL](18, 6) NULL,
				[PcTicket] [DECIMAL](18, 6) NULL,
				[PcTax] [DECIMAL](18, 6) NULL,
				[PcLicenseFee] [DECIMAL](18, 6) NULL,
				[PcOther1] [DECIMAL](18, 6) NULL,
				[PcOther2] [DECIMAL](18, 6) NULL,
				[IsAttended] [BIT] NULL,
				[ScanDateTime] [DATETIME] NULL,
				[ScanGate] [NVARCHAR](100) NULL,
				[QtySeat] [INT] NOT NULL,
				[QtySeatFSE] [DECIMAL](38, 20) NULL,
				[PaidAmount] [DECIMAL](18, 6) NULL,
				[OwedAmount] [DECIMAL](18, 6) NULL,
				[OrderNum] [BIGINT] NULL,
				[OrderLineItem] [INT] NULL,
				[RetailTicketType] [NVARCHAR](255) NULL,
				[RetailQualifiers] [NVARCHAR](255) NULL,
				[IsResold] [BIT] NULL,
				[ResoldDimTicketCustomerId] [BIGINT] NULL,
				[ResoldDimCustomerId] [BIGINT] NULL,
				[ResoldCustomerId] [NVARCHAR](50) NULL,
				[ResoldCustomerName] [NVARCHAR](500) NULL,
				[Resold_CRMContactId] [NVARCHAR](100) NULL,
				[ResoldDateTime] [DATETIME] NULL,
				[ResoldPurchasePrice] [DECIMAL](29, 17) NULL,
				[ResoldFees] [DECIMAL](29, 17) NULL,
				[ResoldTotalAmount] [DECIMAL](29, 17) NULL,
				[SalesSource] [NVARCHAR](255) NULL,
				[GroupSalesName] [NVARCHAR](255) NULL,
				[ArchticsAddUser] [NVARCHAR](255) NULL,
				[DimCustomerIdSalesRep] [INT] NULL,
				[DimCustomerId_TransSalesRep] [INT] NULL,
				[SSID_event_id] [INT] NULL,
				[SSID_section_id] [INT] NULL,
				[SSID_row_id] [INT] NULL,
				[SSID_seat] [INT] NULL,
				[config_isCapacityEligible] [BIT] NULL,
				[IsPair] [BIT] NULL,
				[DimTicketCustomerId] [INT] NULL,
				[CustomerId] [NVARCHAR](50) NULL,
				[DimCustomerId] [BIGINT] NULL,
				[CustomerName] [NVARCHAR](500) NULL,
				[CRMContactId] [NVARCHAR](100) NULL,
				[DimRepId] [INT] NULL,
				[AccountRep] [NVARCHAR](500) NULL,
				[ETL__SSID_TM_section_id] [INT] NULL,
				[ETL__SSID_TM_row_id] [INT] NULL,
				[ETL__SSID_TM_seat] [INT] NULL,
				[FactInventoryId] [BIGINT] NULL, 
				[FactTicketSalesId] [BIGINT] NULL, 
				[FactAttendanceId] [BIGINT] NULL, 
				[FactTicketActivityId_Resold] [BIGINT] NULL, 
				[FactTicketActivityId_Tranferred] [BIGINT] NULL, 
				[FactAvailSeatsId] [BIGINT] NULL, 
				[FactHeldSeatsId] [BIGINT] NULL, 
				[ETL__CreatedDate] [DATETIME] NULL
			)

			ALTER TABLE stg.dbo__FactTicketSeat_V2 ADD CONSTRAINT DF_FactTicketSeat_V2__ETL__CreatedDate DEFAULT GETUTCDATE() FOR [ETL__CreatedDate]

			CREATE NONCLUSTERED INDEX NCI_dbo_FactTicketSeat_V2__FactInventoryId ON stg.dbo__FactTicketSeat_V2 (FactInventoryId)

			CREATE CLUSTERED COLUMNSTORE INDEX CCI_dbo_FactTicketSeat_V2 ON stg.dbo__FactTicketSeat_V2 WITH (DROP_EXISTING = OFF)

			INSERT INTO stg.dbo__FactTicketSeat_V2 (
				SaleDate, 
				SaleTime, 
				SaleDateTime, 
				TicketingAccountId, 
				DimArenaId, 
				ArenaCode, 
				ArenaName, 
				DimSeasonHeaderId, 
				SeasonHeaderCode, 
				SeasonHeaderName, 
				SeasonHeaderDesc, 
				SeasonHeaderClass, 
				SeasonHeaderYear, 
				SeasonHeaderIsActive, 
				DimSeasonId, 
				SeasonName, 
				SeasonYear, 
				SeasonClass, 
				Sport, 
				DimEventHeaderId, 
				EventHeaderName, 
				EventHeaderDesc, 
				EventHeaderDate, 
				EventHeaderTime, 
				EventHeaderDateTime, 
				EventHeaderOpenTime, 
				EventHeaderFinishTime, 
				EventSeasonNumber, 
				EventHeaderHomeNumber, 
				EventHeaderGameNumber, 
				EventLevel,
				EventHierarchyL1, 
				EventHierarchyL2, 
				EventHierarchyL3, 
				EventHierarchyL4, 
				EventHierarchyL5, 
				GameType, 
				DimEventId, 
				EventCode, 
				EventName, 
				EventDate, 
				EventTime, 
				EventDateTime, 
				EventClass, 
				MajorCategoryTM, 
				MinorCategoryTM, 
				DimItemId, 
				ItemCode, 
				ItemName, 
				ItemPlanOrEvent, 
				DimPlanId, 
				PlanCode, 
				PlanName, 
				PlanClass, 
				PlanFSE, 
				PlanType, 
				PlanEventCnt, 
				DimPriceCodeId, 
				PriceCode, 
				PC1, 
				PC2, 
				PC3, 
				PC4, 
				PriceCodeDesc, 
				PriceCodeGroup, 
				DimSeatId, 
				SectionName, 
				RowName, 
				Seat, 
				SeatLocationMapping, 
				SeatLevelName, 
				DimTicketClassId, 
				TicketClassCode, 
				TicketClassName, 
				DimTicketTypeId, 
				TicketTypeCode, 
				TicketTypeName, 
				DimPlanTypeId, 
				PlanTypeCode, 
				PlanTypeName, 
				DimSeatTypeId, 
				SeatTypeCode, 
				SeatTypeName, 
				DimSeatStatusId, 
				ClassName, 
				DistStatus, 
				DimSalesCodeId, 
				SalesCode, 
				SalesCodeName, 
				DimPromoId, 
				PromoCode, 
				PromoName, 
				ManifestedPriceCode, 
				ManifestedClassName, 
				ManifestedSeatValue, 
				PostedPriceCode, 
				PostedClassName, 
				PostedSeatValue, 
				HeldPriceCode, 
				HeldClassName, 
				HeldSeatValue, 
				IsSaleable, 
				IsAvailable, 
				IsHeld, 
				IsReserved, 
				IsSold, 
				IsHost, 
				IsComp, 
				TM_comp_code, 
				TM_comp_name, 
				IsPremium, 
				IsSingleEvent, 
				IsPlan, 
				IsPartial, 
				IsGroup, 
				IsRenewal, 
				IsBroker, 
				TotalRevenue, 
				PurchasePrice, 
				PcTicketValue, 
				Surcharge, 
				PcTicket, 
				PcTax, 
				PcLicenseFee, 
				PcOther1, 
				PcOther2, 
				IsAttended, 
				ScanDateTime, 
				ScanGate, 
				QtySeat, 
				QtySeatFSE, 
				PaidAmount, 
				OwedAmount, 
				OrderNum, 
				OrderLineItem, 
				RetailTicketType, 
				RetailQualifiers, 
				IsResold, 
				ResoldDimTicketCustomerId,
				ResoldDimCustomerId, 
				ResoldCustomerId, 
				ResoldCustomerName, 
				Resold_CRMContactId, 
				ResoldDateTime, 
				ResoldPurchasePrice, 
				ResoldFees, 
				ResoldTotalAmount, 
				SalesSource, 
				GroupSalesName, 
				ArchticsAddUser, 
				DimCustomerIdSalesRep, 
				DimCustomerId_TransSalesRep, 
				SSID_event_id, 
				SSID_section_id, 
				SSID_row_id, 
				SSID_seat, 
				config_isCapacityEligible, 
				DimTicketCustomerId,
				CustomerId, 
				DimCustomerId,
				CustomerName, 
				CRMContactId, 
				DimRepId, 
				AccountRep, 
				ETL__SSID_TM_section_id, 
				ETL__SSID_TM_row_id, 
				ETL__SSID_TM_seat,
				FactInventoryId,
				FactTicketSalesId,
				FactAttendanceId,
				FactTicketActivityId_Resold,
				FactTicketActivityId_Tranferred,
				FactAvailSeatsId,
				FactHeldSeatsId
			)
			SELECT
				fts.SaleDate,
				fts.SaleTime,
				fts.SaleDateTime,
				fts.TicketingAccountId,
				fi.DimArenaId,
				da.ArenaCode,
				da.ArenaName,
				dsh.DimSeasonHeaderId,
				dsh.SeasonCode AS SeasonHeaderCode,
				dsh.SeasonName AS SeasonHeaderName, 
				dsh.SeasonDesc AS SeasonHeaderDesc, 
				dsh.SeasonClass AS SeasonHeaderClass, 
				dsh.SeasonYear AS SeasonHeaderYear, 
				dsh.IsActive AS SeasonHeaderIsActive, 
				ds.DimSeasonId,
				ds.SeasonName, 
				ds.SeasonYear, 
				ds.SeasonClass, 
				ds.Config_Org AS Sport, 
				deh.DimEventHeaderId,
				deh.EventName AS EventHeaderName, 
				deh.EventDesc AS EventHeaderDesc, 
				deh.EventDate AS EventHeaderDate, 
				deh.EventTime AS EventHeaderTime, 
				deh.EventDateTime AS EventHeaderDateTime, 
				deh.EventOpenTime AS EventHeaderOpenTime, 
				deh.EventFinishTime AS EventHeaderFinishTime, 
				deh.SeasonEventNumber AS EventSeasonNumber, 
				deh.HomeGameNumber AS EventHeaderHomeNumber, 
				deh.GameTypeNumber AS EventHeaderGameNumber, 
				deh.Config_Category1 AS EventLevel,
				deh.EventHierarchyL1, 
				deh.EventHierarchyL2, 
				deh.EventHierarchyL3, 
				deh.EventHierarchyL4, 
				deh.EventHierarchyL5,
				deh.GameType,
				de.DimEventId,
				de.EventCode, 
				de.EventName, 
				de.EventDate, 
				de.EventTime, 
				de.EventDateTime, 
				de.EventClass,
				de.TM_major_category AS MajorCategoryTM,
				de.TM_minor_category AS MinorCategoryTM,
				fts.DimItemId,
				fts.ItemCode,
				fts.ItemName,
				fts.ItemPlanOrEvent,
				fts.DimPlanId,
				fts.PlanCode,
				fts.PlanName,
				fts.PlanClass,
				fts.PlanFSE,
				fts.PlanType,
				fts.PlanEventCnt,
				fts.DimPriceCodeId,
				fts.PriceCode,
				fts.PC1,
				fts.PC2,
				fts.PC3,
				fts.PC4,
				fts.PriceCodeDesc,
				fts.PriceCodeGroup,	
				fi.DimSeatId,
				fi.SectionName,
				fi.RowName,
				fi.Seat,
				fi.SeatLocationMapping,
				fi.SeatLevelName,
				fts.DimTicketClassId,
				fts.TicketClassCode,
				fts.TicketClassName,
				fts.DimTicketTypeId,
				fts.TicketTypeCode,
				fts.TicketTypeName,
				fts.DimPlanTypeId,
				fts.PlanTypeCode,
				fts.PlanTypeName,
				fts.DimSeatTypeId,
				fts.SeatTypeCode,
				fts.SeatTypeName,
				fts.DimSeatStatusId,
				fts.ClassName,
				fts.DistStatus,
				fts.DimSalesCodeId,
				fts.SalesCode,
				fts.SalesCodeName,
				fts.DimPromoId,
				fts.PromoCode,
				fts.PromoName,
				fi.ManifestedPriceCode,
				fi.ManifestedClassName,
				fi.ManifestedSeatValue,
				fas.ETL__SSID_TM_price_code AS PostedPriceCode,
				fasss.SeatStatusName AS PostedClassName,
				fas.TM_price AS PostedSeatValue,
				fhs.ETL__SSID_TM_price_code AS HeldPriceCode,
				fhsss.SeatStatusName AS HeldClassName,
				fhs.TM_price AS HeldSeatValue,
				fi.IsSaleable,
				fi.IsAvailable,
				fi.IsHeld,
				ISNULL(fts.IsReserved, 0) AS IsReserved,
				fi.IsSold,
				ISNULL(fts.IsHost, 0) AS IsHost,
				ISNULL(fts.IsComp, 0) AS IsComp,
				fts.TM_comp_code,
				fts.TM_comp_name,
				ISNULL(fts.IsPremium, 0) AS IsPremium,
				ISNULL(fts.IsSingleEvent, 0) AS IsSingleEvent,
				ISNULL(fts.IsPlan, 0) AS IsPlan,
				ISNULL(fts.IsPartial, 0) AS IsPartial,
				ISNULL(fts.IsGroup, 0) AS IsGroup,
				ISNULL(fts.IsRenewal, 0) AS IsRenewal,
				ISNULL(fts.IsBroker, 0) AS IsBroker,
				fts.TotalRevenue,
				fts.PurchasePrice,
				fts.PcTicketValue,
				fts.Surcharge,
				fts.PcTicket,
				fts.PcTax,
				fts.PcLicenseFee,
				fts.PcOther1,
				fts.PcOther2,
				CAST(CASE WHEN fi.FactAttendanceId IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS IsAttended,
				fa.ScanDateTime,
				COALESCE(dsg.ScanGateClass, dsg.ScanGateName) AS ScanGate,
				CASE WHEN fi.FactTicketSalesId IS NOT NULL THEN 1 ELSE 0 END AS QtySeat,
				(fts.QtySeatFSE / CAST(CASE WHEN fi.FactTicketSalesId IS NOT NULL THEN 1 ELSE 0 END AS DECIMAL(18,6)) ) AS QtySeatFSE,
				fts.PaidAmount,
				fts.OwedAmount,
				fts.OrderNum,
				fts.OrderLineItem,
				fts.RetailTicketType,
				fts.RetailQualifiers,
				CAST(CASE WHEN fi.FactTicketActivityId_Resold IS NOT NULL THEN 1 ELSE 0 END AS BIT) AS IsResold,
				ftar.DimTicketCustomerId_Recipient AS ResoldDimTicketCustomerId,
				dc_r2.DimCustomerId AS ResoldDimCustomerId,
				dtcust_r.CustomerId AS ResoldCustomerId,
				dtcust_r.FullName AS ResoldCustomerName,
				dc_r.SSID AS Resold_CRMContactId,
				ftar.TransDateTime AS ResoldDateTime,
				ftar.SubTotal / ftar.QtySeat AS ResoldPurchasePrice,
				ftar.Fees / ftar.QtySeat AS ResoldFees,
				ftar.Total / ftar.QtySeat AS ResoldTotalAmount,
				fts.SalesSource,
				fts.GroupSalesName,
				fts.ArchticsAddUser,
				fts.DimCustomerIdSalesRep, 
				fts.DimCustomerId_TransSalesRep,
				fi.ETL__SSID_TM_event_id AS SSID_event_id,
				fi.ETL__SSID_TM_section_id AS SSID_section_id,
				fi.ETL__SSID_TM_row_id AS SSID_row_id,
				fi.ETL__SSID_TM_seat AS SSID_seat,
				fi.config_isCapacityEligible,
				fts.DimTicketCustomerId,
				fts.CustomerId,
				dc_2.DimCustomerId,
				fts.CustomerName,
				dc.SSID AS CRMContactId,
				fts.DimRepId,
				fts.AccountRep,
				fi.ETL__SSID_TM_section_id,
				fi.ETL__SSID_TM_row_id,
				fi.ETL__SSID_TM_seat,
				fi.FactInventoryId,
				fi.FactTicketSalesId,
				fi.FactAttendanceId,
				fi.FactTicketActivityId_Resold,
				fi.FactTicketActivityId_Tranferred,
				fi.FactAvailSeatsId,
				fi.FactHeldSeatsId
			FROM #FI fi
			INNER JOIN ro.vw_DimSeason ds ON fi.DimSeasonId = ds.DimSeasonId
			INNER JOIN ro.vw_DimArena da ON fi.DimArenaId = da.DimArenaId
			INNER JOIN ro.vw_DimEvent de ON fi.DimEventId = de.DimEventId
			INNER JOIN ro.vw_DimEventHeader deh ON de.DimEventHeaderId = deh.DimEventHeaderId
			INNER JOIN ro.vw_DimSeasonHeader dsh ON deh.DimSeasonHeaderId = dsh.DimSeasonHeaderId
			INNER JOIN ro.vw_DimSeatStatus dss ON fi.DimSeatStatusid = dss.DimseatStatusId
			LEFT OUTER JOIN #FTS fts ON fi.FactTicketSalesId = fts.FactTicketSalesId
			LEFT OUTER JOIN ro.vw_FactTicketActivity ftar ON fi.FactTicketActivityId_Resold = ftar.FactTicketActivityId
			LEFT OUTER JOIN ro.vw_FactAttendance fa ON fi.FactAttendanceId = fa.FactAttendanceId
			LEFT OUTER JOIN ro.vw_FactAvailSeats fas ON fi.FactAvailSeatsId = fas.FactAvailSeatsId
			LEFT OUTER JOIN ro.vw_FactHeldSeats fhs ON fi.FactHeldSeatsId = fhs.FactHeldSeatsId
			LEFT OUTER JOIN #DC /*CTE_DimCustomer_CRM*/ /*dbo.DimCustomer*/ dc (NOLOCK) ON fts.CustomerId = dc.AccountId AND dc.SourceSystem = 'CRM_Contact'
			LEFT OUTER JOIN #DC_TM dc_2 ON  fts.CustomerId = dc_2.AccountId
			LEFT OUTER JOIN ro.vw_DimTicketCustomer dtcust_r ON ftar.DimTicketCustomerId_Recipient = dtcust_r.DimTicketCustomerId
			LEFT OUTER JOIN #DC /*CTE_DimCustomer_CRM*/ /*dbo.DimCustomer*/ dc_r (NOLOCK) ON dtcust_r.CustomerId = dc_r.AccountId AND dc_r.SourceSystem = 'CRM_Contact'
			LEFT OUTER JOIN #DC_TM dc_r2 ON  dtcust_r.CustomerId = dc_r2.AccountId
			LEFT OUTER JOIN ro.vw_DimScanGate dsg ON fa.DimScanGateId = dsg.DimScanGateId
			LEFT OUTER JOIN ro.vw_DimSeatStatus fasss ON fas.DimSeatStatusId = fasss.DimSeatStatusId
			LEFT OUTER JOIN ro.vw_DimSeatStatus fhsss ON fhs.DimSeatStatusId = fhsss.DimSeatStatusId

			DELETE fts
			--SELECT *
			FROM dbo.FactTicketSeat_v2 fts
			INNER JOIN stg.dbo__FactTicketSeat_V2 fts_s
				ON  fts.FactInventoryId = fts_s.FactInventoryId

			INSERT INTO dbo.FactTicketSeat_v2 (
				SaleDate, 
				SaleTime, 
				SaleDateTime, 
				TicketingAccountId, 
				DimArenaId, 
				ArenaCode, 
				ArenaName, 
				DimSeasonHeaderId, 
				SeasonHeaderCode, 
				SeasonHeaderName, 
				SeasonHeaderDesc, 
				SeasonHeaderClass, 
				SeasonHeaderYear, 
				SeasonHeaderIsActive, 
				DimSeasonId, 
				SeasonName, 
				SeasonYear, 
				SeasonClass, 
				Sport, 
				DimEventHeaderId, 
				EventHeaderName, 
				EventHeaderDesc, 
				EventHeaderDate, 
				EventHeaderTime, 
				EventHeaderDateTime, 
				EventHeaderOpenTime, 
				EventHeaderFinishTime, 
				EventSeasonNumber, 
				EventHeaderHomeNumber, 
				EventHeaderGameNumber, 
				EventLevel,
				EventHierarchyL1, 
				EventHierarchyL2, 
				EventHierarchyL3, 
				EventHierarchyL4, 
				EventHierarchyL5, 
				GameType, 
				DimEventId, 
				EventCode, 
				EventName, 
				EventDate, 
				EventTime, 
				EventDateTime, 
				EventClass, 
				MajorCategoryTM, 
				MinorCategoryTM, 
				DimItemId, 
				ItemCode, 
				ItemName, 
				ItemPlanOrEvent, 
				DimPlanId, 
				PlanCode, 
				PlanName, 
				PlanClass, 
				PlanFSE, 
				PlanType, 
				PlanEventCnt, 
				DimPriceCodeId, 
				PriceCode, 
				PC1, 
				PC2, 
				PC3, 
				PC4, 
				PriceCodeDesc, 
				PriceCodeGroup, 
				DimSeatId, 
				SectionName, 
				RowName, 
				Seat, 
				SeatLocationMapping, 
				SeatLevelName, 
				DimTicketClassId, 
				TicketClassCode, 
				TicketClassName, 
				DimTicketTypeId, 
				TicketTypeCode, 
				TicketTypeName, 
				DimPlanTypeId, 
				PlanTypeCode, 
				PlanTypeName, 
				DimSeatTypeId, 
				SeatTypeCode, 
				SeatTypeName, 
				DimSeatStatusId, 
				ClassName, 
				DistStatus, 
				DimSalesCodeId, 
				SalesCode, 
				SalesCodeName, 
				DimPromoId, 
				PromoCode, 
				PromoName, 
				ManifestedPriceCode, 
				ManifestedClassName, 
				ManifestedSeatValue, 
				PostedPriceCode, 
				PostedClassName, 
				PostedSeatValue, 
				HeldPriceCode, 
				HeldClassName, 
				HeldSeatValue, 
				IsSaleable, 
				IsAvailable, 
				IsHeld, 
				IsReserved, 
				IsSold, 
				IsHost, 
				IsComp, 
				TM_comp_code, 
				TM_comp_name, 
				IsPremium, 
				IsSingleEvent, 
				IsPlan, 
				IsPartial, 
				IsGroup, 
				IsRenewal, 
				IsBroker, 
				TotalRevenue, 
				PurchasePrice, 
				PcTicketValue, 
				Surcharge, 
				PcTicket, 
				PcTax, 
				PcLicenseFee, 
				PcOther1, 
				PcOther2, 
				IsAttended, 
				ScanDateTime, 
				ScanGate, 
				QtySeat, 
				QtySeatFSE, 
				PaidAmount, 
				OwedAmount, 
				OrderNum, 
				OrderLineItem, 
				RetailTicketType, 
				RetailQualifiers, 
				IsResold, 
				ResoldDimTicketCustomerId,
				ResoldDimCustomerId, 
				ResoldCustomerId, 
				ResoldCustomerName, 
				Resold_CRMContactId, 
				ResoldDateTime, 
				ResoldPurchasePrice, 
				ResoldFees, 
				ResoldTotalAmount, 
				SalesSource, 
				GroupSalesName, 
				ArchticsAddUser, 
				DimCustomerIdSalesRep, 
				DimCustomerId_TransSalesRep, 
				SSID_event_id, 
				SSID_section_id, 
				SSID_row_id, 
				SSID_seat, 
				config_isCapacityEligible, 
				DimTicketCustomerId,
				CustomerId, 
				DimCustomerId,
				CustomerName, 
				CRMContactId, 
				DimRepId, 
				AccountRep, 
				ETL__SSID_TM_section_id, 
				ETL__SSID_TM_row_id, 
				ETL__SSID_TM_seat,
				FactInventoryId,
				FactTicketSalesId,
				FactAttendanceId,
				FactTicketActivityId_Resold,
				FactTicketActivityId_Tranferred,
				FactAvailSeatsId,
				FactHeldSeatsId
			)
			SELECT
				fts.SaleDate, 
				fts.SaleTime, 
				fts.SaleDateTime, 
				fts.TicketingAccountId, 
				fts.DimArenaId, 
				fts.ArenaCode, 
				fts.ArenaName, 
				fts.DimSeasonHeaderId, 
				fts.SeasonHeaderCode, 
				fts.SeasonHeaderName, 
				fts.SeasonHeaderDesc, 
				fts.SeasonHeaderClass, 
				fts.SeasonHeaderYear, 
				fts.SeasonHeaderIsActive, 
				fts.DimSeasonId, 
				fts.SeasonName, 
				fts.SeasonYear, 
				fts.SeasonClass, 
				fts.Sport, 
				fts.DimEventHeaderId, 
				fts.EventHeaderName, 
				fts.EventHeaderDesc, 
				fts.EventHeaderDate, 
				fts.EventHeaderTime, 
				fts.EventHeaderDateTime, 
				fts.EventHeaderOpenTime, 
				fts.EventHeaderFinishTime, 
				fts.EventSeasonNumber, 
				fts.EventHeaderHomeNumber, 
				fts.EventHeaderGameNumber, 
				fts.EventLevel,
				fts.EventHierarchyL1, 
				fts.EventHierarchyL2, 
				fts.EventHierarchyL3, 
				fts.EventHierarchyL4, 
				fts.EventHierarchyL5, 
				fts.GameType, 
				fts.DimEventId, 
				fts.EventCode, 
				fts.EventName, 
				fts.EventDate, 
				fts.EventTime, 
				fts.EventDateTime, 
				fts.EventClass, 
				fts.MajorCategoryTM, 
				fts.MinorCategoryTM, 
				fts.DimItemId, 
				fts.ItemCode, 
				fts.ItemName, 
				fts.ItemPlanOrEvent, 
				fts.DimPlanId, 
				fts.PlanCode, 
				fts.PlanName, 
				fts.PlanClass, 
				fts.PlanFSE, 
				fts.PlanType, 
				fts.PlanEventCnt, 
				fts.DimPriceCodeId, 
				fts.PriceCode, 
				fts.PC1, 
				fts.PC2, 
				fts.PC3, 
				fts.PC4, 
				fts.PriceCodeDesc, 
				fts.PriceCodeGroup, 
				fts.DimSeatId, 
				fts.SectionName, 
				fts.RowName, 
				fts.Seat, 
				fts.SeatLocationMapping, 
				fts.SeatLevelName, 
				fts.DimTicketClassId, 
				fts.TicketClassCode, 
				fts.TicketClassName, 
				fts.DimTicketTypeId, 
				fts.TicketTypeCode, 
				fts.TicketTypeName, 
				fts.DimPlanTypeId, 
				fts.PlanTypeCode, 
				fts.PlanTypeName, 
				fts.DimSeatTypeId, 
				fts.SeatTypeCode, 
				fts.SeatTypeName, 
				fts.DimSeatStatusId, 
				fts.ClassName, 
				fts.DistStatus, 
				fts.DimSalesCodeId, 
				fts.SalesCode, 
				fts.SalesCodeName, 
				fts.DimPromoId, 
				fts.PromoCode, 
				fts.PromoName, 
				fts.ManifestedPriceCode, 
				fts.ManifestedClassName, 
				fts.ManifestedSeatValue, 
				fts.PostedPriceCode, 
				fts.PostedClassName, 
				fts.PostedSeatValue, 
				fts.HeldPriceCode, 
				fts.HeldClassName, 
				fts.HeldSeatValue, 
				fts.IsSaleable, 
				fts.IsAvailable, 
				fts.IsHeld, 
				fts.IsReserved, 
				fts.IsSold, 
				fts.IsHost, 
				fts.IsComp, 
				fts.TM_comp_code, 
				fts.TM_comp_name, 
				fts.IsPremium, 
				fts.IsSingleEvent, 
				fts.IsPlan, 
				fts.IsPartial, 
				fts.IsGroup, 
				fts.IsRenewal, 
				fts.IsBroker, 
				fts.TotalRevenue, 
				fts.PurchasePrice, 
				fts.PcTicketValue, 
				fts.Surcharge, 
				fts.PcTicket, 
				fts.PcTax, 
				fts.PcLicenseFee, 
				fts.PcOther1, 
				fts.PcOther2, 
				fts.IsAttended, 
				fts.ScanDateTime, 
				fts.ScanGate, 
				fts.QtySeat, 
				fts.QtySeatFSE, 
				fts.PaidAmount, 
				fts.OwedAmount, 
				fts.OrderNum, 
				fts.OrderLineItem, 
				fts.RetailTicketType, 
				fts.RetailQualifiers, 
				fts.IsResold, 
				fts.ResoldDimTicketCustomerId,
				fts.ResoldDimCustomerId, 
				fts.ResoldCustomerId, 
				fts.ResoldCustomerName, 
				fts.Resold_CRMContactId, 
				fts.ResoldDateTime, 
				fts.ResoldPurchasePrice, 
				fts.ResoldFees, 
				fts.ResoldTotalAmount, 
				fts.SalesSource, 
				fts.GroupSalesName, 
				fts.ArchticsAddUser, 
				fts.DimCustomerIdSalesRep, 
				fts.DimCustomerId_TransSalesRep, 
				fts.SSID_event_id, 
				fts.SSID_section_id, 
				fts.SSID_row_id, 
				fts.SSID_seat, 
				fts.config_isCapacityEligible, 
				fts.DimTicketCustomerId,
				fts.CustomerId, 
				fts.DimCustomerId,
				fts.CustomerName, 
				fts.CRMContactId, 
				fts.DimRepId, 
				fts.AccountRep, 
				fts.ETL__SSID_TM_section_id, 
				fts.ETL__SSID_TM_row_id, 
				fts.ETL__SSID_TM_seat,
				fts.FactInventoryId,
				fts.FactTicketSalesId,
				fts.FactAttendanceId,
				fts.FactTicketActivityId_Resold,
				fts.FactTicketActivityId_Tranferred,
				fts.FactAvailSeatsId,
				fts.FactHeldSeatsId
			FROM stg.dbo__FactTicketSeat_V2 fts

			IF OBJECT_ID('tempdb..#DimSeat') IS NOT NULL
				DROP TABLE #DimSeat

			SELECT *
			INTO #DimSeat
			FROM ro.vw_DimSeat
			where ISNUMERIC(Seat) = 1

			IF OBJECT_ID('tempdb..#DimSeats') IS NOT NULL
				DROP TABLE #DimSeats

			SELECT fts.DimEventId, fts.DimSeatId, fts.SectionName, fts.RowName, fts.Seat, dsl.Seat AS SeatLeft, dsl.DimSeatId AS SeatLeft_DimSeatId, dsr.Seat AS SeatRight, dsr.DimSeatId AS SeatRight_DimSeatId
			INTO #DimSeats
			FROM stg.dbo__FactTicketSeat_V2 fts
			INNER JOIN #DimSeat ds
				ON fts.DimSeatId = ds.DimSeatId
			LEFT OUTER JOIN #DimSeat dsl
				ON ds.ETL__SSID_TM_manifest_id = dsl.ETL__SSID_TM_manifest_id
				AND ds.ETL__SSID_TM_section_id = dsl.ETL__SSID_TM_section_id
				AND ds.ETL__SSID_TM_row_id = dsl.ETL__SSID_TM_row_id
				AND ds.Seat = (dsl.Seat + 1)
			LEFT OUTER JOIN #DimSeat dsr
				ON ds.ETL__SSID_TM_manifest_id = dsr.ETL__SSID_TM_manifest_id
				AND ds.ETL__SSID_TM_section_id = dsr.ETL__SSID_TM_section_id
				AND ds.ETL__SSID_TM_row_id = dsr.ETL__SSID_TM_row_id
				AND ds.Seat = (dsr.Seat - 1)

			UPDATE fi
			SET IsPair = CAST(CASE
					WHEN 
						(
							(fi.FactTicketSalesId IS NULL)
						)
						AND (
								(
									ls.FactTicketSalesId IS NULL AND ls.Seat IS NOT NULL
								)
							OR (
									rs.FactTicketSalesId IS NULL AND rs.Seat IS NOT NULL
								)
						)
					THEN 1
					ELSE 0
					END AS BIT)
			FROM dbo.FactTicketSeat_V2 fi	
			INNER JOIN (
					SELECT DimSeatId, DimEventId, MAX(SeatLeft_DimSeatId) as SeatLeft_DimSeatId, MAX(SeatRight_DimSeatId) AS SeatRight_DimSeatId
					FROM (
							SELECT DimSeatId, DimEventId, SeatLeft_DimSeatId, SeatRight_DimSeatId
							FROM #DimSeats
							UNION
							SELECT SeatLeft_DimSeatId, DimEventId, NULL, NULL
							FROM #DimSeats
							WHERE SeatLeft_DimSeatId IS NOT NULL
							UNION
							SELECT SeatRight_DimSeatId, DimEventId, NULL, NULL
							FROM #DimSeats
							WHERE SeatRight_DimSeatId IS NOT NULL
						) DS
					GROUP BY DimSeatId, DimEventId
				) ds
				ON  fi.DimSeatId = ds.DimSeatId		
				AND fi.DimEventId = ds.DimEventId
			LEFT OUTER JOIN dbo.FactTicketSeat_V2 ls
				--ON  fi.DimEventId = ls.DimEventId
				--AND fi.ETL__SSID_TM_section_id = ls.ETL__SSID_TM_section_id
				--AND fi.ETL__SSID_TM_row_id = ls.ETL__SSID_TM_row_id
				--AND fi.Seat = (ls.Seat + 1)
				ON ds.DimEventId = ls.DimEventId
				AND ds.SeatLeft_DimSeatId = ls.DimSeatId
			LEFT OUTER JOIN dbo.FactTicketSeat_V2 rs
				--ON  fi.DimEventId = rs.DimEventId
				--AND fi.ETL__SSID_TM_section_id = rs.ETL__SSID_TM_section_id
				--AND fi.ETL__SSID_TM_row_id = rs.ETL__SSID_TM_row_id
				--AND fi.Seat = (rs.Seat - 1)
				ON ds.DimEventId = rs.DimEventId
				AND ds.SeatRight_DimSeatId = rs.DimSeatId
			WHERE fi.IsPair IS NULL
				OR fi.IsPair <> 
						CAST(CASE
							WHEN 
								(
									(fi.FactTicketSalesId IS NULL)
								)
								AND (
										(
											ls.FactTicketSalesId IS NULL AND ls.Seat IS NOT NULL
										)
									OR (
											rs.FactTicketSalesId IS NULL AND rs.Seat IS NOT NULL
										)
								)
							THEN 1
							ELSE 0
							END AS BIT)

			DELETE fts
			--SELECT *
			FROM dbo.FactTicketSeat_v2 fts
			LEFT OUTER JOIN dbo.FactInventory_v2 fi
				ON  fts.FactInventoryId = fi.FactInventoryId
			WHERE fi.FactInventoryId IS NULL

			UPDATE fts
			SET DimCustomerId = dc_2.DimCustomerId
			FROM dbo.FactTicketSeat_V2 fts
			LEFT OUTER JOIN #DC_TM dc_2 ON  fts.CustomerId = dc_2.AccountId
			WHERE fts.DimCustomerId <> dc_2.DimCustomerId
				OR (fts.DimCustomerId IS NULL AND dc_2.DimCustomerId IS NOT NULL)
				OR (fts.DimCustomerId IS NOT NULL AND dc_2.DimCustomerId IS NULL)

			UPDATE fts
			SET ResoldDimCustomerId = dc_r2.DimCustomerId
			FROM dbo.FactTicketSeat_V2 fts
			LEFT OUTER JOIN #DC_TM dc_r2 ON  fts.ResoldCustomerId = dc_r2.AccountId
			WHERE fts.ResoldDimCustomerId <> dc_r2.DimCustomerId
				OR (fts.ResoldDimCustomerId IS NULL AND dc_r2.DimCustomerId IS NOT NULL)
				OR (fts.ResoldDimCustomerId IS NOT NULL AND dc_r2.DimCustomerId IS NULL)

			UPDATE fts
			SET CRMContactId = dc.SSID
			FROM dbo.FactTicketSeat_V2 fts
			LEFT OUTER JOIN #DC dc ON  fts.CustomerId = dc.AccountId
			WHERE fts.CRMContactId <> dc.SSID
				OR (fts.CRMContactId IS NULL AND dc.SSID IS NOT NULL)
				OR (fts.CRMContactId IS NOT NULL AND dc.SSID IS NULL)

			UPDATE fts
			SET Resold_CRMContactId = dc_r.SSID
			FROM dbo.FactTicketSeat_V2 fts
			LEFT OUTER JOIN #DC dc_r ON  fts.ResoldCustomerId = dc_r.AccountId
			WHERE fts.Resold_CRMContactId <> dc_r.SSID
				OR (fts.Resold_CRMContactId IS NULL AND dc_r.SSID IS NOT NULL)
				OR (fts.Resold_CRMContactId IS NOT NULL AND dc_r.SSID IS NULL)

			IF OBJECT_ID (N'stg.dbo__FactTicketSeat_V2', N'U') IS NOT NULL 
			BEGIN
				DROP TABLE stg.dbo__FactTicketSeat_V2
			END

		COMMIT
 
	END TRY  
			
	BEGIN CATCH  
		DECLARE @ErrorMessage NVARCHAR(4000);
		DECLARE @ErrorSeverity INT;
		DECLARE @ErrorState INT;

		SELECT 
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		ROLLBACK;

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState); 
	END CATCH

END
GO
