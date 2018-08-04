SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--FB0DCEBF-EEE3-4797-95B2-5C9DA4519AFC
--AB92B138-05E2-437E-A529-4573BA9C6B23
--EXEC api.GetTransByContactGUID @SSB_CRMSYSTEM_CONTACT_ID = 'AB92B138-05E2-437E-A529-4573BA9C6B23', -- varchar(50)
--                               @SSB_CRMSYSTEM_ACCT_ID = '',    -- varchar(50)
--                               @RowsPerPage = 100,               -- int
--                               @PageNumber = 1                 -- int

--SELECT * FROM dbo.vwDimCustomer_ModAcctId
--WHERE accountid = '17068891'

--SELECT * FROM ods.TM_RetailNonTicket
--WHERE acct_id IN ('16083514','44341941')

/*

SAS  2018-07-25   changed dimticketclass join. Had a bad join from dimticketclassid=dimtickettypeid.

*/

CREATE   PROCEDURE [api].[GetTransByContactGUID]
    (
      @SSB_CRMSYSTEM_CONTACT_ID VARCHAR(50)
	, @SSB_CRMSYSTEM_ACCT_ID VARCHAR(50)
    , @RowsPerPage INT = 500
    , --APIification
      @PageNumber INT = 0 --APIification
    )
AS
    BEGIN

-- =========================================
-- Initial Variables for API
-- =========================================

        DECLARE @totalCount INT
          , @xmlDataNode XML
          , @recordsInResponse INT
          , @remainingCount INT
          , @rootNodeName NVARCHAR(100)
          , @responseInfoNode NVARCHAR(MAX)
          , @finalXml XML;

-- =========================================
-- GUID Table for GUIDS
-- =========================================
DECLARE @GUIDTable TABLE ( GUID VARCHAR(50) );

IF ( @SSB_CRMSYSTEM_ACCT_ID NOT IN ( 'None', 'Test' ) )
    BEGIN
        INSERT  INTO @GUIDTable
                ( GUID
                )
                SELECT DISTINCT
                        z.SSB_CRMSYSTEM_CONTACT_ID
                FROM    Ducks.dbo.vwDimCustomer_ModAcctId z
                WHERE   z.SSB_CRMSYSTEM_ACCT_ID = @SSB_CRMSYSTEM_ACCT_ID;
    END;

IF ( @SSB_CRMSYSTEM_CONTACT_ID NOT IN ( 'None', 'Test' ) )
    BEGIN
        INSERT  INTO @GUIDTable
                ( GUID
                )
                SELECT  @SSB_CRMSYSTEM_CONTACT_ID;
    END;

-- =========================================
-- Base Table Set
-- =========================================


        DECLARE @baseData TABLE
            (
              Team NVARCHAR(255)
			   , Account NVARCHAR(255)
            , SeasonName NVARCHAR(255)
            , OrderNumber NVARCHAR(255)
            , OrderLine NVARCHAR(255)
            , OrderDate DATE
            , Item NVARCHAR(255)
            , ItemName NVARCHAR(255)
			, EventDate NVARCHAR(255)
            , PriceCode NVARCHAR(255)
            , IsComp BIT
            , PromoCode NVARCHAR(255)
            , Qty INT
			, SectionName NVARCHAR(255)
            , RowName NVARCHAR(255)
			, SeatBlock	 NVARCHAR(255)
            , Total DECIMAL(18, 6)
			, SeatPrice DECIMAL(18, 6)
            , AmountOwed DECIMAL(18, 6)
            , AmountPaid DECIMAL(18, 6)
			, SalesRep NVARCHAR(255)
            );

-- =========================================
-- Procedure
-- =========================================


SELECT distinct
        'Ducks' AS Team
      , fts.ETL__SSID_TM_acct_id
      , ds.seasonname
      , fts.TM_order_num AS OrderNumber
      , fts.TM_order_line_item AS OrderLine
      , dd.caldate AS OrderDate
      , di.ItemCode AS Item
      , di.ItemName
	  , de.EventDate
      , dpc.PriceCode
      , fts.IsComp
      , dp2.PromoCode
      , fts.QtySeat AS Qty
	  , ds2.SectionName
	  , ds2.RowName
      , CASE WHEN ds2.Seat = 'unknown' THEN NULL
			 ELSE CONCAT(CONVERT(nvarchar, ds2.Seat) , ':' , CONVERT(nvarchar, ( CONVERT(INT,ds2.Seat)
                                                              + fts.QtySeat
                                                              - 1 ))) 
		END SeatBlock
      , fts.TM_purchase_price AS SeatPrice
      , fts.TM_block_purchase_price
      , fts.OwedAmount
      , fts.PaidAmount
	  , fts.CreatedBy AS SalesRep


INTO #Trans

FROM    dbo.FactTicketSales_V2 AS fts
		JOIN dbo.DimTicketCustomer_V2 dimtc ON dimtc.dimticketcustomerid = fts.dimticketcustomerID
        JOIN dbo.vwDimCustomer_ModAcctId d  ON d.accountID = dimtc.etl__ssid_tm_acct_id AND d.sourcesystem = 'TM' AND d.customertype = 'Primary'
        JOIN [ro].[vw_DimSeason] AS ds ON ds.DimSeasonId = fts.DimSeasonId
        JOIN [ro].[vw_DimItem] AS di ON di.DimItemId = fts.DimItemId
        JOIN [ro].[vw_DimPriceCode] AS dpc ON dpc.DimPriceCodeId = fts.DimPriceCodeId
        JOIN [ro].[vw_DimTicketClass] AS dtc ON dtc.DimTicketClassId = fts.DimTicketClassId
        JOIN [ro].[vw_DimTicketType] AS dtt ON fts.DimTicketTypeId = fts.DimTicketTypeId
        JOIN [ro].[vw_DimPlan] AS dp ON dp.DimPlanId = fts.DimPlanId
        JOIN [ro].[vw_DimDate]  AS dd ON dd.DimDateId = fts.DimDateId
		JOIN [ro].[vw_DimEvent] AS de ON de.DimEventId = fts.DimEventId
        JOIN [ro].[vw_DimPromo] AS dp2 ON dp2.DimPromoID = fts.DimPromoId
        JOIN [ro].[vw_DimSeat] AS ds2 ON ds2.DimSeatId = fts.DimSeatId_Start
WHERE   d.SSB_CRMSYSTEM_CONTACT_ID IN (SELECT GUID FROM @GUIDTable)
--WHERE   d.SSB_CRMSYSTEM_CONTACT_ID IN ('AB92B138-05E2-437E-A529-4573BA9C6B23')
--AND ds2.seat <> 'unknown';
--AND ds2.dimseatid <> -1;
 



UNION 

SELECT distinct	'Honda Center' AS Team
		, n.acct_id
		, NULL
		, null
		, NULL
		, n.transaction_datetime
		, n.event_name
		, n.attraction_name
		, n.event_date
		,CAST(n.retail_price_level AS NVARCHAR(25))
		, NULL
		,null
		,n.num_seats
		,n.section_name
		,n.row_name
		, CONCAT(CONVERT(nvarchar, n.first_seat) , ':' , CONVERT(nvarchar, ( CONVERT(INT,n.first_seat)
                                                              + n.num_seats
                                                              - 1 ))) 
		SeatBlock
		,n.retail_face_value
		,n.retail_purchase_price
		, NULL
        , NULL
        , n.add_user
FROM ods.TM_RetailNonTicket n
JOIN dbo.vwDimCustomer_ModAcctId d
ON d.AccountId = n.acct_id AND d.CustomerType = 'primary' AND d.SourceSystem = 'TM'
WHERE   d.SSB_CRMSYSTEM_CONTACT_ID IN (SELECT GUID FROM @GUIDTable)
--WHERE   d.SSB_CRMSYSTEM_CONTACT_ID IN ('AB92B138-05E2-437E-A529-4573BA9C6B23')


-- =========================================
-- API Pagination
-- =========================================
-- Cap returned results at 1000

        IF @RowsPerPage > 1000
            BEGIN

                SET @RowsPerPage = 1000;

            END;

-- Pull total count

        SELECT  @totalCount = COUNT(*)
        FROM    #Trans AS c;

-- =========================================
-- API Loading
-- =========================================

-- Load base data

        INSERT  INTO @baseData
                SELECT  *
                FROM    #Trans AS c
                ORDER BY c.OrderDate DESC
                      , c.OrderNumber
                      OFFSET ( @PageNumber ) * @RowsPerPage ROWS

FETCH NEXT @RowsPerPage ROWS ONLY;

-- Set records in response

        SELECT  @recordsInResponse = COUNT(*)
        FROM    @baseData;
-- Create XML response data node

        SET @xmlDataNode = (
                             SELECT ISNULL(Team, '') AS Team
                                 
                                  , ISNULL(SeasonName,'') AS SeasonName
                                  , ISNULL(OrderNumber,'') AS OrderNumber
                                  , ISNULL(OrderLine,'') AS OrderLine
                                  , ISNULL(Account,'') AS Account
                                  , ISNULL(OrderDate,'') AS OrderDate
                                  , ISNULL(Item,'') AS Item
                                  , ISNULL(ItemName,'') AS ItemName
								  , ISNULL(EventDate,'') AS EventDate                                 
                                  , ISNULL(IsComp,0) AS IsComp                                
                                  , ISNULL(PromoCode,'') AS PromoCode
                                  , ISNULL(Qty,0) AS Qty
                                  , ISNULL(SeatPrice,0) AS SeatPrice
                                  , ISNULL(Total,0) AS Total
								  , ISNULL(SectionName,'') AS SectionName
								  , ISNULL(RowName,'') AS RowName
                                  , ISNULL(SeatBlock,'') AS SeatBlock
								  , ISNULL(SalesRep,'') AS SalesRep
                             FROM   @baseData
                           FOR
                             XML PATH('Parent')
                               , ROOT('Parents')
                           );

        SET @rootNodeName = 'Parents';

		-- Calculate remaining count

        SET @remainingCount = @totalCount - ( @RowsPerPage * ( @PageNumber + 1 ) );

        IF @remainingCount < 0
            BEGIN

                SET @remainingCount = 0;

            END;

			-- Create response info node

        SET @responseInfoNode = ( '<ResponseInfo>' + '<TotalCount>'
                                  + CAST(@totalCount AS NVARCHAR(20))
                                  + '</TotalCount>' + '<RemainingCount>'
                                  + CAST(@remainingCount AS NVARCHAR(20))
                                  + '</RemainingCount>'
                                  + '<RecordsInResponse>'
                                  + CAST(@recordsInResponse AS NVARCHAR(20))
                                  + '</RecordsInResponse>'
                                  + '<PagedResponse>true</PagedResponse>'
                                  + '<RowsPerPage>'
                                  + CAST(@RowsPerPage AS NVARCHAR(20))
                                  + '</RowsPerPage>' + '<PageNumber>'
                                  + CAST(@PageNumber AS NVARCHAR(20))
                                  + '</PageNumber>' + '<RootNodeName>'
                                  + @rootNodeName + '</RootNodeName>'
                                  + '</ResponseInfo>' );
    END;

-- Wrap response info and data, then return    

    IF @xmlDataNode IS NULL
        BEGIN

            SET @xmlDataNode = '<' + @rootNodeName + ' />';

        END;

    SET @finalXml = '<Root>' + @responseInfoNode
        + CAST(@xmlDataNode AS NVARCHAR(MAX)) + '</Root>';

    SELECT  CAST(@finalXml AS XML);

DROP TABLE #Trans;

GO
