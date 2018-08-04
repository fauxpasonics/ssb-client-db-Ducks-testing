SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--EXEC [api].[GetWebActivitybyguid] @SSB_CRMSYSTEM_CONTACT_ID = '003D151F-6DC8-4834-8800-094CA84F0F53', -- varchar(50)
--                                  @SSB_CRMSYSTEM_ACCT_ID = '',    -- varchar(50)
--                                  @RowsPerPage = 100,               -- int
--                                  @PageNumber = 0                 -- int


--00CDD8E8-248A-4910-9285-2AEAFC517282
--003D151F-6DC8-4834-8800-094CA84F0F53

CREATE PROCEDURE [api].[GetWebActivitybyguid]
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
          , @finalXml XML



-- =========================================
-- Base Table Set
-- =========================================


        DECLARE @baseData TABLE
            (
			  CreatedAt Datetime,
			  WebActivity nvarchar (2000)
            );


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
                 SELECT  @SSB_CRMSYSTEM_CONTACT_ID
    END;


-- =========================================
-- Procedure
-- =========================================

IF OBJECT_ID('tempdb..#CRM_Email_Data') IS NOT NULL
	DROP TABLE #CRM_Email_Data
SELECT * 
INTO #CRM_Email_Data
FROM ods.Eloqua_WebActivity_CRM_Stage
WHERE   SSB_CRMSYSTEM_CONTACT_ID IN (SELECT GUID FROM @GUIDTable)
ORDER BY CreatedAt desc



--SELECT TOP 100 * FROM #TurnkeyData
--8CCCE298-BDED-4332-8E6A-06EAFC064000


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
        FROM    #CRM_Email_Data AS c;

-- =========================================
-- API Loading
-- =========================================

-- Load base data

        INSERT  INTO @baseData
                SELECT  CreatedAt,WebActivity
                FROM    #CRM_Email_Data AS c
                ORDER BY c.ssb_crmsystem_contact_id,CreatedAt desc
                     
                      OFFSET ( @PageNumber ) * @RowsPerPage ROWS

FETCH NEXT @RowsPerPage ROWS ONLY;

-- Set records in response

        SELECT  @recordsInResponse = COUNT(*)
        FROM    @baseData;
-- Create XML response data node

        SET @xmlDataNode = (
                             SELECT 
                                   ISNULL(CreatedAt,'') AS CreatedAt
                                  , ISNULL(WebActivity,'') AS WebActivty
                               
                                
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






GO
