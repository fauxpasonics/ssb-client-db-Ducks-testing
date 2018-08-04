SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

------------------------------------------------------------------------------- 
-- Author name: Scott Sales
-- Created date: 2018-05-31
-- Purpose: Team wants 2 more fields added to this CDO
-- Copyright © 2018, SSB, All Rights Reserved 
------------------------------------------------------------------------------- 
-- Modification History -- 
-- 01/01/0000: developer full name 
-- Change notes:
-- Peer reviewed by: Kaitlyn Sniffin
-- Peer review notes: Ran query with new feilds added and runs fine
-- Peer review date: 2018-05-31
-- Deployed by: 
-- Deployment date: 
-- Deployment notes: 
------------------------------------------------------------------------------- 
------------------------------------------------------------------------------- 

CREATE PROC [etl].[Eloqua_Ticket_Transactions_Attendance]
AS
BEGIN

    TRUNCATE TABLE ro.Eloqua_Ticket_Transactions_Attendance_Combined;


    INSERT ro.Eloqua_Ticket_Transactions_Attendance_Combined
    SELECT CONCAT(fts.ETL__SSID_TM_acct_id, ':', e.EventCode, ':', ss.SectionName, ':', ss.RowName, ':', ss.Seat) Factticketseat_Key,
           ds.SeasonName,
           fts.ETL__SSID_TM_acct_id AS ArchticsID,
           dt.FirstName,
           dt.LastName,
           dt.EmailPrimary,
           dt.AccountRep,
           fts.TM_purchase_price,
           t.TicketTypeName,
           e.EventCode,
           e.EventName,
           e.EventDate,
           s.SeatTypeName,
           CONCAT(ss.SectionName, +':', +ss.RowName, +':', +ss.Seat) AS SeatLocation,
           CASE
               WHEN fa.ScanDateTime IS NOT NULL THEN
                   1
               ELSE
                   0
           END AttendedEvent,
		  e.TM_major_category AS MajorCategory, --New Fields Added
          e.TM_minor_category AS MinorCategory --New Fields Added
		--  ,activity.TM_activity_name
   
    --		INTO  ro.Eloqua_Ticket_Transactions_Attendance_Combined
    FROM [ro].[vw_FactInventory] fi
        JOIN [ro].[vw_FactTicketSales] fts
            ON fts.FactTicketSalesId = fi.FactTicketSalesId
        INNER JOIN [ro].[vw_DimTicketType] t
            ON t.DimTicketTypeId = fts.DimTicketTypeId
        INNER JOIN [ro].[vw_DimEvent] e
            ON e.DimEventId = fts.DimEventId
        INNER JOIN [ro].[vw_DimSeatType] s
            ON fts.DimSeatTypeId = s.DimSeatTypeId
        INNER JOIN ro.vw_DimSeason ds
            ON ds.DimSeasonId = fts.DimSeasonId
        INNER JOIN [ro].[vw_DimSeat] ss
            ON ss.DimSeatId = fi.DimSeatId
        INNER JOIN [ro].[vw_DimCustomer] dt
            ON dt.AccountId = fts.ETL__SSID_TM_acct_id
               AND dt.SourceSystem = 'TM'
               AND dt.CustomerType = 'Primary'
        LEFT JOIN [ro].[vw_FactAttendance] fa
            ON fa.FactAttendanceId = fi.FactAttendanceId
    WHERE fts.ETL__SSID_TM_acct_id <> -1
          --AND fa.ETL__SSID_TM_acct_id <> -1
          AND dt.EmailPrimary <> ''
          AND dt.AccountId <> -1
          AND
          (
              fts.DimSeasonId IN ( 10, 17, 27, 35, 47, 55, 36 )
              OR ds.SeasonName LIKE ('%premium suite season%')
              OR ds.SeasonName LIKE ('%premium club season%')
              OR ds.SeasonName LIKE ('%Ducks Playoffs')
              OR ds.SeasonName LIKE ('%Ducks Suite Playoffs')
          )
          AND (
--			1=1
			fts.ETL__UpdatedDate >= (GETUTCDATE()-3)
			OR fa.ETL__UpdatedDate = (GETUTCDATE()-3)
          )
    ;


INSERT INTO  ro.Eloqua_Ticket_Transactions_Attendance_Combined
 SELECT CONCAT(fts.ETL__SSID_TM_acct_id, ':', e.EventCode, ':', ss.SectionName, ':', ss.RowName, ':', ss.Seat) Factticketseat_Key,
           ds.SeasonName,
           fts.ETL__SSID_TM_acct_id AS ArchticsID,
           dt.FirstName,
           dt.LastName,
           dt.EmailPrimary,
           dt.AccountRep,
           fts.TM_purchase_price,
           t.TicketTypeName,
           e.EventCode,
           e.EventName,
           e.EventDate,
           s.SeatTypeName,
           CONCAT(ss.SectionName, +':', +ss.RowName, +':', +ss.Seat) AS SeatLocation,
           CASE
               WHEN fa.ScanDateTime IS NOT NULL THEN
                   1
               ELSE
                   0
           END AttendedEvent,
		  e.TM_major_category AS MajorCategory, --New Fields Added
          e.TM_minor_category AS MinorCategory --New Fields Added
		--  ,activity.TM_activity_name 
    --		INTO  ro.Eloqua_Ticket_Transactions_Attendance_Combined
    FROM [ro].[vw_FactInventory] fi
        JOIN [ro].[vw_FactTicketSales] fts
            ON fts.FactTicketSalesId = fi.FactTicketSalesId
        INNER JOIN [ro].[vw_DimTicketType] t
            ON t.DimTicketTypeId = fts.DimTicketTypeId
        INNER JOIN [ro].[vw_DimEvent] e
            ON e.DimEventId = fts.DimEventId
        INNER JOIN [ro].[vw_DimSeatType] s
            ON fts.DimSeatTypeId = s.DimSeatTypeId
        INNER JOIN ro.vw_DimSeason ds
            ON ds.DimSeasonId = fts.DimSeasonId
        INNER JOIN [ro].[vw_DimSeat] ss
            ON ss.DimSeatId = fi.DimSeatId
        INNER JOIN [ro].[vw_DimCustomer] dt
            ON dt.AccountId = fts.ETL__SSID_TM_acct_id
               AND dt.SourceSystem = 'TM'
               AND dt.CustomerType = 'Primary'
		INNER JOIN ro.vw_FactTicketActivity activity
			ON activity.FactTicketActivityId = fi.FactTicketActivityId_Tranferred AND activity.TM_activity_name = 'Forward'
		LEFT JOIN [ro].[vw_FactAttendance] fa
            ON fa.FactAttendanceId = fi.FactAttendanceId
    WHERE fts.ETL__SSID_TM_acct_id <> -1
          --AND fa.ETL__SSID_TM_acct_id <> -1
          AND dt.EmailPrimary <> ''
          AND dt.AccountId <> -1
          AND
          (
              ds.DimSeasonId IN(47,55) AND activity.TM_activity_name = 'Forward'
			 )
          AND (
--			1=1
			fts.ETL__UpdatedDate >= (GETUTCDATE()-3)
			OR fa.ETL__UpdatedDate = (GETUTCDATE()-3)
          );

    SELECT CONCAT(
                     'RETAIL',
                     ':',
                     rnt.acct_id,
                     ':',
                     rnt.event_name,
                     ':',
                     rnt.section_name,
                     ':',
                     rnt.row_name,
                     ':',
                     rnt.first_seat,
                     ':',
                     rnt.last_seat
                 ) Factticketseat_Key,
           'Honda Center' AS SeasonName,
           rnt.acct_id AS ArchticsId,
           dt.FirstName,
           dt.LastName,
           dt.EmailPrimary,
           dt.AccountRep,
           rnt.retail_purchase_price AS TM_purchase_price,
           rnt.retail_ticket_type AS TicketTypeName,
           rnt.event_name AS EventCode,
           rnt.attraction_name AS EventName,
           rnt.event_date AS EventDate,
           CAST(rnt.retail_price_level AS NVARCHAR(50)) AS SeatTypeName,
           CONCAT(rnt.section_name, +':', +rnt.row_name, +':', +rnt.first_seat, +':', +rnt.last_seat) AS SeatLocation,
           '-1' AS AttendedEvent,
		   rnt.major_category_name, --New Fields Added
           rnt.minor_category_name --New Fields Added
                                    --,rnt.primary_act
    INTO #tmpEloqua_Ticket_Transactions_Attendance_Combined
    FROM ods.TM_RetailNonTicket rnt (NOLOCK)
        INNER JOIN [ro].[vw_DimCustomer] dt
            ON dt.AccountId = rnt.acct_id
               AND dt.SourceSystem = 'TM'
               AND dt.CustomerType = 'Primary'
    WHERE rnt.acct_id <> -1
        AND rnt.acct_id <> -2
        AND dt.EmailPrimary <> '' --AND rnt.add_datetime >= (GETDATE()-3)
        AND rnt.attraction_name IS NOT NULL
		AND rnt.UpdateDate >= GETDATE()-3

    UNION
    SELECT CONCAT(
                     'RETAIL',
                     ':',
                     rnt.acct_id,
                     ':',
                     rnt.event_name,
                     ':',
                     rnt.section_name,
                     ':',
                     rnt.row_name,
                     ':',
                     rnt.first_seat,
                     ':',
                     rnt.last_seat
                 ) Factticketseat_Key,
           'Honda Center',
           rnt.acct_id,
           dt.FirstName,
           dt.LastName,
           dt.EmailPrimary,
           dt.AccountRep,
           rnt.retail_purchase_price,
           rnt.retail_ticket_type,
           rnt.event_name,
           CASE
               WHEN Hl.attraction_name <> '' THEN
                   Hl.attraction_name
               ELSE
                   ''
           END Attraction_Name,
                                    --,rnt.primary_act
           rnt.event_date,
           CAST(rnt.retail_price_level AS NVARCHAR(50)) Pricelevel,
           CONCAT(rnt.section_name, +':', +rnt.row_name, +':', +rnt.first_seat, +':', +rnt.last_seat) AS SeatLocation,
           '-1',
		   rnt.major_category_name, --New Fields Added
           rnt.minor_category_name --New Fields Added
    FROM ods.TM_RetailNonTicket rnt
        INNER JOIN [ro].[vw_DimCustomer] dt
            ON dt.AccountId = rnt.acct_id
               AND dt.SourceSystem = 'TM'
               AND dt.CustomerType = 'Primary'
        INNER JOIN [ods].[Honda_Center_Events_Lookup] Hl
            ON rnt.event_date = Hl.event_date
               AND rnt.event_name = Hl.event_name
    WHERE rnt.acct_id <> -1
		AND rnt.acct_id <> -2
		AND dt.EmailPrimary <> ''
		AND (
              rnt.attraction_name IS NULL
              OR rnt.attraction_name = ''
		)
		AND rnt.UpdateDate >= GETDATE()-3
    ;




    CREATE NONCLUSTERED INDEX idx_Factticketseat_Key
    ON #tmpEloqua_Ticket_Transactions_Attendance_Combined (Factticketseat_Key);


    WITH firstStep
    AS (SELECT a.*
        FROM #tmpEloqua_Ticket_Transactions_Attendance_Combined a
            LEFT JOIN ro.Eloqua_Ticket_Transactions_Attendance_Combined b
                ON a.Factticketseat_Key = b.Factticketseat_Key
        WHERE b.Factticketseat_Key IS NULL)
    INSERT ro.Eloqua_Ticket_Transactions_Attendance_Combined
    SELECT *
    FROM firstStep;

END;

GO
