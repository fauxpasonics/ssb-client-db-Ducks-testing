SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--EXEC api.GetSurveryResponsebyguid @SSB_CRMSYSTEM_CONTACT_ID = '99E061C8-4331-43FB-A0DC-39D2B0F8955D', -- varchar(50)
--                                  @SSB_CRMSYSTEM_ACCT_ID = '',    -- varchar(50)
--                                  @RowsPerPage = 100,               -- int
--                                  @PageNumber = 0                 -- int


--EXEC api.[GetSurveryResponsebyguid]	
--8CCCE298-BDED-4332-8E6A-06EAFC064000

CREATE PROCEDURE [api].[GetSurveryResponsebyguid]
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
              ssb_crmsystem_contact_id NVARCHAR(100),
			  Recordid NVARCHAR (100),
			  AccountID NVARCHAR(25),
			  Questions NVARCHAR (500),
			  Response nvarchar (2000)
            );

-- =========================================
-- Procedure
-- =========================================



DECLARE
 @table         NVARCHAR(257) = N'[Ducks].[etl].[vw_Turnkey_STH_Survey]',
 @key_column    SYSNAME       = N'recordid';
DECLARE
 @colNames  NVARCHAR(MAX) = N'',
 @colValues NVARCHAR(MAX) = N'',
 @sql1      NVARCHAR(MAX) = N'';
SELECT
 @colNames += ',
   ' + QUOTENAME(name),
 @colValues += ',
   ' + QUOTENAME(name)
  + ' = CONVERT(VARCHAR(320), ' + QUOTENAME(name) + ')'
FROM sys.columns
WHERE [object_id] = OBJECT_ID(@table)
AND name <> @key_column;

IF OBJECT_ID('tempdb..#Turnkeysurvey_unpivot') IS NOT NULL
	DROP TABLE #Turnkeysurvey_unpivot
		
	CREATE TABLE #Turnkeysurvey_unpivot--TABLE	 
		(	  Recordid NVARCHAR (100) NOT null,
			  Questions NVARCHAR (500),
			  Response nvarchar (2000))
SET @sql1 = N'
 insert  into #Turnkeysurvey_unpivot (recordid, questions, response) --update first value after SELECT to the key column
select recordid, questions, response
from
(
 SELECT ' + @key_column + @colValues + '
  FROM ' + @table + ' table_alias
) AS t
UNPIVOT
(
 Response FOR Questions IN (' + STUFF(@colNames, 1, 1, '') + ')
) AS up ORDER BY [recordid];';
--PRINT @sql1;
EXEC sp_executesql @sql1;

IF OBJECT_ID('tempdb..#Tmps') IS NOT NULL
	DROP TABLE #Tmps
SELECT m.SSB_CRMSYSTEM_CONTACT_ID, m.AccountId, s.*
INTO #tmps
 FROM #Turnkeysurvey_unpivot  s
JOIN dbo.vwDimCustomer_ModAcctId m
ON s.response = CAST(m.AccountId AS NVARCHAR (500)) AND m.SourceSystem = 'TM' AND m.CustomerType = 'primary'
WHERE m.AccountId <> 0



IF OBJECT_ID('tempdb..#TurnkeyData_guid') IS NOT NULL
	DROP TABLE #TurnkeyData_guid
SELECT t.SSB_CRMSYSTEM_CONTACT_ID, t.AccountId, t.recordid, s.questions, s.response 
INTO #TurnkeyData_guid
FROM #Turnkeysurvey_unpivot   s
JOIN #tmps t
ON s.recordid = t.recordid


--SELECT TOP 100 * FROM #TurnkeyData
--8CCCE298-BDED-4332-8E6A-06EAFC064000

-- =========================================
-- GUID Table for GUIDS
-- =========================================
DECLARE @GUIDTable TABLE ( GUID VARCHAR(50) );

IF ( @SSB_CRMSYSTEM_CONTACT_ID NOT IN ( 'None', 'Test' ) )
    BEGIN
        INSERT  INTO @GUIDTable
                ( GUID
                )
                 SELECT  @SSB_CRMSYSTEM_CONTACT_ID
    END;

IF OBJECT_ID('tempdb..#TurnkeyData') IS NOT NULL
	DROP TABLE #TurnkeyData
SELECT SSB_CRMSYSTEM_CONTACT_ID, AccountId, recordid, questions, response 
INTO #TurnkeyData
FROM #TurnkeyData_guid s
WHERE   SSB_CRMSYSTEM_CONTACT_ID IN (SELECT GUID FROM @GUIDTable)

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
        FROM    #TurnkeyData AS c;

-- =========================================
-- API Loading
-- =========================================

-- Load base data

        INSERT  INTO @baseData
                SELECT  *
                FROM    #TurnkeyData AS c
                ORDER BY c.AccountId 
                     
                      OFFSET ( @PageNumber ) * @RowsPerPage ROWS

FETCH NEXT @RowsPerPage ROWS ONLY;

-- Set records in response

        SELECT  @recordsInResponse = COUNT(*)
        FROM    @baseData;
-- Create XML response data node

        SET @xmlDataNode = (
                             SELECT ISNULL(Recordid, '') AS Recordid
                                  , ISNULL(SSB_CRMSYSTEM_CONTACT_ID, '') AS SSB_CRMSYSTEM_CONTACT_ID
                                  , ISNULL(AccountID,'') AS AccountID
                                  , ISNULL(Questions,'') AS Questions
                                  , ISNULL(Response,'') AS Response
                                
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
