SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- DECLARE @BatchId NVARCHAR(50) = '00000000-0000-0000-0000-000000000000'
 
-- EXEC etl.TM_Stage_FactTicketSales @BatchId = @BatchId, @Options = '<options><LoadDate>1900-01-01</LoadDate></options>'

-- IF EXISTS (SELECT * FROM sys.procedures WHERE [object_id] = OBJECT_ID('etl.Cust_FactTicketSalesProcessing'))
-- BEGIN    
 
--     EXEC etl.Cust_FactTicketSalesProcessing @BatchId = @BatchId

-- END

-- EXEC [etl].[SSB_StandardModelLoad] @BatchId = @BatchId , @Target = 'etl.vw_FactTicketSales', @Source = 'etl.vw_Load_TM_FactTicketSales', 
-- @BusinessKey = 'ETL__SSID_TM_event_id, ETL__SSID_TM_section_id, ETL__SSID_TM_row_id, ETL__SSID_TM_seat_num', @SourceSystem = 'TM'

CREATE   PROCEDURE [etl].[Cust_FactTicketSalesProcessing]
(
	@BatchId NVARCHAR (50) = '00000000-0000-0000-0000-000000000000',
	@Options NVARCHAR(MAX) = NULL
)
AS

BEGIN

/*****************************************************************************************************************
												Ticket Type
******************************************************************************************************************/

----FULL SEASON----

UPDATE fts
SET fts.DimTicketTypeId = 2
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE ( fts.dimseasonID IN(27,47)
AND ((PC1 NOT in ('B', 'C') AND PC2 = 'R') 
or (PC1 not IN ('B', 'C') AND PC2 = 'U') 
or (PC1 not in('B', 'C') AND PC2 = 'N') 
or (PC1 not in('B', 'C') AND PC2 = 'A') 
or (PC2 = 'L')))

OR (fts.dimseasonID= 10
AND ((PC1 NOT in ('B', 'C','D') AND PC2 = 'R') 
or (PC1 not in ('B', 'C','D') AND PC2 = 'U') 
or (PC1 not in ('B', 'C','D') AND PC2 = 'N') 
or (PC1 not in ('B', 'C','D') AND PC2 = 'A') 
or (PC1 not in ('B', 'C','D') AND PC2 = 'O' AND PC3 = 'P')))


OR(fts.DimSeasonId = 36
AND PC1 NOT IN( 'A','B','C') AND pc2 = 'O')


OR(fts.DimSeasonId = 19
AND PC1 NOT IN('B','C') AND pc2 = 'O')

----HALF SEASON----

UPDATE fts
SET fts.DimTicketTypeId = 3
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47,36,19)
AND PC2 = 'H'


----MINI PLAN----

UPDATE fts
SET fts.DimTicketTypeId = 4
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,10,47)
AND PC2 = 'M' AND PC3 <> 'M')

OR (fts.dimseasonID IN (36,19)
AND PC2 = 'M')

----SINGLE GAME----

UPDATE fts
SET fts.DimTicketTypeId = 5
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(27,47)
AND ((IsHost = 1 OR PC2 = 'B')
OR (PC2 = 'F') 
OR (PC2 = 'K' AND PC3 IN ('B','C','D','E')) 
OR (PC2 ='Q')))

OR(fts.DimSeasonId IN(36,19) 
AND (fts.IsHost = 1 OR pc2 = 'E' OR (PC2 = 'B' AND PC3 IN ('O', 'S', '1', '2', '4', '5', '6'))))

OR (fts.dimseasonID = 10
AND ((IsHost = 1)
 or (PC2 = 'B') 
 OR (PC2 = 'F') 
 OR (PC2 = 'E') 
 OR (PC2 = 'K' and PC3 = 'C')))

----GROUP----

UPDATE fts
SET fts.DimTicketTypeId = 6
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN ( 27,10,47,36,19)
AND PC2 = 'G'


----COMP----

UPDATE fts
SET fts.DimTicketTypeId = 7
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN ( 27,10,47,36,19)
AND PC2 = 'C'

----Ducks Only Club----

UPDATE fts
SET fts.DimTicketTypeId = 12
FROM    stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN ( 27,47)
AND ((PC1 in ('B','C') AND PC2 = 'R')
 or (PC1 in ('B','C') AND PC2 = 'U' AND (PC3 NOT in ('1', '2', '3', 'A') OR pc3 IS null) 
 or (PC1 in ('B','C') AND PC2 = 'N' AND (PC3 NOT in ('1', '2', '3', 'A') OR pc3 IS null) 
 or (PC1 in ('B','C') AND PC2 = 'A' AND (PC3 NOT in ('S', 'N')OR pc3 IS null))))))

 OR (fts.dimseasonID = 10
 AND ((PC1 in ('B','C','D') AND PC2 = 'R') 
 OR (PC1 in ('B','C','D') AND PC2 = 'U' AND (PC3 NOT in ('1', '2', '3', 'A')OR pc3 IS null))
 or (PC1 in ('B','C','D') AND PC2 = 'N' AND (PC3 NOT in ('1', '2', '3', 'A')OR pc3 IS null))
 or (PC1 in ('B','C','D') AND PC2 = 'A' AND (PC3 NOT in ('S', 'N')OR pc3 IS null))
 or (PC1 in ('B','C','D') AND PC2 = 'O' AND PC3 = 'P')))

 OR(fts.DimSeasonId = 36
 AND pc1 IN('A','B','C') AND pc2 = 'O')


  OR(fts.DimSeasonId = 19
 AND pc1 IN('B','C') AND pc2 = 'O')

----ANNUAL CLUB----

UPDATE fts
SET fts.DimTicketTypeId = 8
--select * 
FROM   stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN ( 10)
AND ((PC2 = 'K' AND PC3 <> 'C') 
OR (PC2 = 'U' AND PC3 IN ('1', '2', '3', 'A')) 
OR (PC2 = 'N' AND PC3 IN ('1', '2', '3', 'A'))))

OR

(fts.dimseasonID IN ( 27,47)
AND ((PC2 = 'K' AND PC3 IN ('1', '2', '3', 'A')) 
OR (PC2 = 'U' AND PC3 IN ('1', '2', '3', 'A')) 
OR (PC2 = 'N' AND PC3 IN ('1', '2', '3', 'A'))))


OR (fts.DimSeasonId IN(36,19)
AND ((PC2 = 'A' AND PC3 IN ('1', '2', '3', '5', 'C')) OR (PC2 = 'B' AND PC3 = 'C')))



----MICRO PLAN----

UPDATE fts
SET fts.DimTicketTypeId = 9
FROM    stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN ( 27,47)
AND (PC2 = 'M' AND PC3 = 'M')

OR(fts.dimseasonID = 10
and (PC2 = 'M' AND PC3 = 'M')
OR (PC2 = 'O' and PC3 = '6') 
OR (PC2 = 'S') 
OR (PC2 = 'A' and PC3 = 'N') 
OR (PC2 = 'H' and PC3 = 'P')))


----ANNUAL SUITE----
UPDATE fts
SET fts.DimTicketTypeId =10
FROM   stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,10,35,47,55)
AND ((PC2 = 'A' AND PC3 ='S') 
OR (PC2 = 'S' and PC3 = 'O') 
OR (PC2 = 'D' and PC3 = '1')))


OR(fts.DimSeasonId IN( 36,39,19,22)
AND ((PC2 = 'A' AND PC3 ='S') OR (PC2 = 'S' and PC3 = 'O') OR PC2 = 'D'))

----RENTAL SUITE----
UPDATE fts
SET fts.DimTicketTypeId =11
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (31,39,17,35,55,7,4,22,48)
AND PC1 = 'V' 



/*****************************************************************************************************************
													PLAN TYPE
******************************************************************************************************************/


----NEW----

UPDATE fts
SET fts.DimPlanTypeId = 1
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID in (27,10,47)
		AND( PC2 = 'N' 
		OR PC3 = 'N'))

--	--2016/17 season
--	OR (fts.dimseasonID = 10
--		AND (PC2 = 'N' 
--		OR (PC3 = 'N' and PC2 IN ('H', 'M'))))
--

----RENEW----

UPDATE fts
SET fts.DimPlanTypeId = 2
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE ( fts.dimseasonID in (27,47)
AND ((PC2 IN ('R', 'K') )
OR PC3 = 'R'))

	--2016/17 season
	OR (fts.dimseasonID = 10
	AND PC2 IN ('R', 'K')) 

----UPG----

UPDATE fts
SET fts.DimPlanTypeId = 3
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'U'


----ADD----

UPDATE fts
SET fts.DimPlanTypeId = 4 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(27,47)
AND PC2 = 'A')

OR (fts.dimseasonID =10
AND PC2 = 'A'
AND pc3 <> 'N')

---COMP----

UPDATE fts
SET fts.DimPlanTypeId = 5 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID  IN (27,10,47)
AND PC2 = 'C'

----Community Corner----

UPDATE fts
SET fts.DimPlanTypeId = 7
FROM    stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(27,47)
AND PC2 = 'L')


--2018 Playoffs FullSeason
UPDATE fts
SET fts.DimPlanTypeId = 13
FROM    stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,39,19,22)
AND (PC2 = 'O'))


--2018 Playoffs Half Season
UPDATE fts
SET fts.DimPlanTypeId = 14
FROM    stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,39,19,22)
AND (PC2 = 'H'))


--2018 Playoffs  Mini Plan
UPDATE fts
SET fts.DimPlanTypeId = 15
FROM    stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,39,19,22)
AND (PC2 = 'M'))


--2018 Playoffs Comp
UPDATE fts
SET fts.DimPlanTypeId = 16
FROM    stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,39,19,22)
AND (PC2 = 'C'))


--2018 Playoffs Not A plan
UPDATE fts
SET fts.DimPlanTypeId = 17
FROM    stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,39,19,22)
AND (PC2 NOT IN ('C','M','H') OR ((PC2 <>'O' and PC3 <> 'A'))))



----NOPLAN----

UPDATE fts
SET fts.DimPlanTypeId = 6
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(27,47)
AND ((pc2 NOT IN ('N','R','K','U','C','L','A') AND (PC3 NOT IN ('R','N') OR PC3 IS NULL))
OR	fts.IsHost = 1)

---season16/17

OR (fts.dimseasonID = 10
	AND DimPlanTypeId = -1)

--AND (PC2 <> 'N' and PC3 <>'N')
--AND (PC2 NOT IN ('R', 'K') and PC3 <> 'R')
--AND PC2 <> 'U'
--AND PC2 <> 'C'
--AND (PC2 <> 'A' AND PC3 ='N'))

--AND pc.pricecode IN ('1','2','3','4','5','6','7','8','A','B','C',
--					'D','E','F','G','H','I','J','K','L','M','N',
--					'O','P','Q','R','S','T','U'))





/*****************************************************************************************************************
													TICKET CLASS
******************************************************************************************************************/


----FULL SEASON NEW Full Price----

UPDATE fts
SET fts.DimTicketClassId =3 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE (fts.dimseasonID IN (27,47)
AND PC2 NOT IN ('B','C') AND PC2 = 'N' AND LEN(pricecode.PriceCode) = 2)

OR
(fts.dimseasonID IN (10)
AND PC2 NOT IN ('B','C','D') AND PC2 = 'N' AND LEN(pricecode.PriceCode) = 2)




----FULL SEASON NEW HALF Price----

UPDATE fts
SET fts.DimTicketClassId =4
FROM      stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1 NOT in ('B', 'C') AND PC2 = 'N' and PC3 = 'H')


OR
(fts.dimseasonID IN (10)
AND PC1 NOT in ('B', 'C','D') AND PC2 = 'N' and PC3 = 'H')



----FULL SEASON NEW Full Price FSOP----

UPDATE fts
SET fts.DimTicketClassId =35
FROM      stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID = 10
AND PC1 NOT in ('B', 'C','D') AND PC2 = 'O' and PC3 = 'P'




----FULL SEASON RENEW FULL PRICE----



UPDATE fts
SET fts.DimTicketClassId =5
FROM  stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE (fts.dimseasonID IN (27,47)
AND ((PC1 NOT IN ('B', 'C') AND PC2 = 'R' AND LEN(pricecode.PriceCode) = 2)
OR (PC1 NOT IN ('B', 'C') AND PC2 = 'R' AND (pc3 NOT IN('L','H')OR pc3 IS null))))



OR  (fts.dimseasonID IN (10)
AND ((PC1 NOT IN ('B', 'C','D') AND PC2 = 'R' AND LEN(pricecode.PriceCode) = 2)
OR (PC1 NOT IN ('B', 'C','D') AND PC2 = 'R' AND (pc3 <> 'H'OR pc3 IS null))))




--( fts.dimseasonID IN (27,10)
--AND (PC2 = 'R' AND LEN(PriceCode) = 2))
--OR (fts.dimseasonID = 10
--	AND pricecode.pricecode IN ('1RN','7RU','FRC'))
--

----FULL SEASON RENEW HALF PRICE----



UPDATE fts
SET fts.DimTicketClassId =6
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1 NOT IN ('B', 'C') AND PC2 = 'R' AND PC3 = 'H')


or (fts.dimseasonID IN (10)
AND PC1 NOT IN ('B', 'C','D') AND PC2 = 'R' AND PC3 = 'H')

----FULL SEASON UPGRADE FULL PRICE----

UPDATE fts
SET fts.DimTicketClassId =7 
FROM    stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1 NOT IN ('B', 'C') AND PC2 = 'U' AND LEN(PriceCode) = 2)


OR (fts.dimseasonID IN (10)
AND PC1 NOT IN ('B', 'C','D') AND PC2 = 'U' AND LEN(PriceCode) = 2)

----FULL SEASON UPGRADE HALF PRICE----

UPDATE fts
SET fts.DimTicketClassId =8 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1 NOT IN ('B', 'C') AND PC2 = 'U' AND PC3 = 'H')

OR  (fts.dimseasonID IN (10)
AND PC1 NOT IN ('B', 'C','D') AND PC2 = 'U' AND PC3 = 'H')

----FULL SEASON Add-On Full PRICE----

UPDATE fts
SET fts.DimTicketClassId =9  
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1 NOT IN ('B', 'C') AND PC2 = 'A' AND PC3 = 'O')

OR  (fts.dimseasonID IN (10)
AND PC1 NOT IN ('B', 'C','D') AND PC2 = 'A' AND PC3 = 'O')

----FULL SEASON Add-On HALF PRICE----

UPDATE fts
SET fts.DimTicketClassId =10 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1 NOT IN ('B', 'C') AND PC2 = 'A' AND PC3 = 'H')

OR  (fts.dimseasonID IN (10)
AND PC1 NOT IN ('B', 'C','D') AND PC2 = 'A' AND PC3 = 'H')




----Ducks Only Club Full Season New Full Price----
UPDATE fts
SET fts.DimTicketClassId =43
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1  IN ('B', 'C') AND PC2 = 'N' AND LEN(pricecode.PriceCode) = 2)

OR (fts.dimseasonID IN (10)
AND PC1  IN ('B', 'C','D') AND PC2 = 'N' AND LEN(pricecode.PriceCode) = 2)

----Ducks Only Club Full Season New Half Price----
UPDATE fts
SET fts.DimTicketClassId =44
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1  IN ('B', 'C') AND PC2 = 'N' AND PC3 = 'H')

OR  (fts.dimseasonID IN (10)
AND PC1  IN ('B', 'C','D') AND PC2 = 'N' AND PC3 = 'H')

----Ducks Only Club Full Season New OP----
UPDATE fts
SET fts.DimTicketClassId =5
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID  = 10
AND PC1  IN ('B', 'C','D') AND PC2 = 'O' AND PC3 = 'P'

----Ducks Only Club Full Season Renew Full----
UPDATE fts
SET fts.DimTicketClassId =45 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID  IN(27,47)
AND PC1  IN ('B', 'C') AND PC2 = 'R' AND LEN(pricecode.PriceCode) = 2)

OR (fts.dimseasonID  IN(10)
AND PC1  IN ('B', 'C','D') AND PC2 = 'R' AND LEN(pricecode.PriceCode) = 2)

----Ducks Only Club Full Season Renew Half----
UPDATE fts
SET fts.DimTicketClassId =46
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID  IN (27,47)
AND PC1  IN ('B', 'C') AND PC2 = 'R' AND PC3 = 'H')

OR (fts.dimseasonID  IN (10)
AND PC1  IN ('B', 'C','D') AND PC2 = 'R' AND PC3 = 'H')

----Ducks Only Club Full Season upgrade full---
UPDATE fts
SET fts.DimTicketClassId =47
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID  IN (27,47)
AND PC1  IN ('B', 'C') AND PC2 = 'U' AND LEN(pricecode.PriceCode) = 2)

OR (fts.dimseasonID  IN (10)
AND PC1  IN ('B', 'C','D') AND PC2 = 'U' AND LEN(pricecode.PriceCode) = 2)

----Ducks Only Club Full Season upgrade half----
UPDATE fts
SET fts.DimTicketClassId =48
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID  IN (27,47)
AND PC1  IN ('B', 'C') AND PC2 = 'U' AND PC3 = 'H')

OR (fts.dimseasonID  IN (10)
AND PC1  IN ('B', 'C','D') AND PC2 = 'U' AND PC3 = 'H')

----Ducks Only Club Full Season add on full----
UPDATE fts
SET fts.DimTicketClassId =49
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1  IN ('B', 'C') AND PC2 = 'A' AND PC3 = 'O')

OR  (fts.dimseasonID IN (10)
AND PC1  IN ('B', 'C','D') AND PC2 = 'A' AND PC3 = 'O')

----Ducks Only Club Full Season Addon half---
UPDATE fts
SET fts.DimTicketClassId =50
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,47)
AND PC1  IN ('B', 'C') AND PC2 = 'A' AND PC3 = 'H')

OR  (fts.dimseasonID IN (10)
AND PC1  IN ('B', 'C','D') AND PC2 = 'A' AND PC3 = 'H')


----FULL SEASON Communuity Corner----

UPDATE fts
SET fts.DimTicketClassId = 41
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'L' 

----FULL SEASON Comp----

UPDATE fts
SET fts.DimTicketClassId =40
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'C' 


----HALF SEASON NEW----

UPDATE fts
SET fts.DimTicketClassId =11
FROM     stg.TM_FactTicketSales   fts 
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'H' AND PC3 = 'N'

----HALF SEASON RENEW----

UPDATE fts
SET fts.DimTicketClassId =12 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'H' AND PC3 = 'R'


----MINI PLAN NEW---

UPDATE fts
SET fts.DimTicketClassId =13
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'M' AND PC3 = 'N'


----MINI PLAN RENEW---

UPDATE fts
SET fts.DimTicketClassId =14
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'M' AND PC3 = 'R'

----ANNUAL CLUB NEW 20---

UPDATE fts
SET fts.DimTicketClassId =15
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'N' AND PC3 = '1'

----ANNUAL CLUB NEW 15---

UPDATE fts
SET fts.DimTicketClassId =16
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'N' AND PC3 = '2'


----ANNUAL CLUB NEW 10---

UPDATE fts
SET fts.DimTicketClassId =17
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'N' AND PC3 = '3'


------ANNUAL CLUB NEW ---

UPDATE fts
SET fts.DimTicketClassId =18
FROM     stg.TM_FactTicketSales   fts
INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'N' AND PC3 = 'A'


----ANNUAL CLUB RENEW 20---

UPDATE fts
SET fts.DimTicketClassId =19
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'K' AND PC3 = '1'

----ANNUAL CLUB RENEW 15---

UPDATE fts
SET fts.DimTicketClassId =20  
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'K' AND PC3 = '2'

----ANNUAL CLUB RENEW 10---

UPDATE fts
SET fts.DimTicketClassId =21  
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'K' AND PC3 = '3'


------ANNUAL CLUB RENEW ---

UPDATE fts
SET fts.DimTicketClassId =22  
FROM     stg.TM_FactTicketSales   fts
		INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'K' AND PC3 = 'A'

----ANNUAL CLUB upgrade 20---

UPDATE fts
SET fts.DimTicketClassId =23 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'U' AND PC3 = '1'


----ANNUAL CLUB UPGRADE 15---

UPDATE fts
SET fts.DimTicketClassId =24 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'U' AND PC3 = '2'

----ANNUAL CLUB UPGRADE 10---

UPDATE fts
SET fts.DimTicketClassId =25 
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'U' AND PC3 = '3'

------ANNUAL CLUB UPGRADE ---

UPDATE fts
SET fts.DimTicketClassId =26 
FROM    stg.TM_FactTicketSales   fts
		INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND  PC2 = 'U' AND PC3='A'

----ANNUAL SUITES ANNUAL---

UPDATE fts
SET fts.DimTicketClassId =27
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN (27,10,47)
AND ((PC2 = 'A' AND PC3 = 'S') 
OR (PC2 = 'S' AND PC3 = 'O')))

----ANNUAL SUITES DUCKS ONLY---

UPDATE fts
SET fts.DimTicketClassId =28
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47,35,55)
AND PC2 = 'D'
--PC1 = 'B' and PC2 = 'D' and PC3 = '1'

----SINGLE GAME BOX OFFICE---

UPDATE fts
SET fts.DimTicketClassId =29
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(27,47)
AND ((IsHost = 1 )
OR (PC2 = 'B' AND PC3 IN ('O','1','2','4','5','6','E','V','W','Y','Z'))))

OR (fts.dimseasonID =10
AND ((IsHost = 1 )
OR (PC2 = 'B' AND PC3 IN ('O','1','2'))))

----SINGLE GAME PROMO PACK---

UPDATE fts
SET fts.DimTicketClassId =30 
FROM       dbo.FactTicketSales_V2  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(27,47)
AND ((PC2 = 'B' AND (PC3 NOT IN ('O','1','2','4','5','6', 'E', 'V', 'W', 'Y', 'Z') OR PC3 IS null) )
OR (PC2 = 'F')
OR (PC2 = 'Q') 
OR (PC2 = 'K' AND PC3 IN ('B','C','D','E'))))


OR (fts.dimseasonID = 10
AND ((PC2 = 'B' and (PC3 <> 'S'or PC3 <>'O'))
or (PC2 = 'F') 
OR (PC2 = 'K' and PC3 = 'C')
OR (PriceCode IN ('4B','7B','7E1','8B','8E1','BB','BE1','EB','FB','HB','IB'
,'JB','JE1','KB','LB','LE','LE1','MB','ME1','NB','OB','OE1','PB','PE1','QB','QE1','RB','SB','SE','TB','TE','TE1','UB','UE','UE1'))))



----SINGLE GAME BENCH SEATS---

UPDATE fts
SET fts.DimTicketClassId =31
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'B' AND PC3 = 'S'

----RENTAL SUITE---

UPDATE fts
SET fts.DimTicketClassId =32
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID  IN (31,39,17,35,55,7,4,22,48)
AND PC1='V'




----GROUP---

UPDATE fts
SET fts.DimTicketClassId =33
FROM    stg.TM_FactTicketSales fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2='G'

----MICRO PLAN MM---

UPDATE fts
SET fts.DimTicketClassId =34
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN (27,10,47)
AND PC2 = 'M' 
AND PC3 = 'M'

----MICRO PLAN MMS---

UPDATE fts
SET fts.DimTicketClassId =36
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID = 10
AND PC2= 'S'
----MICRO PLAN MMHP---

UPDATE fts
SET fts.DimTicketClassId =37
FROM    stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID  = 10
AND PC2 = 'H' 
AND PC3 = 'P'

----MICRO PLAN MMO6---

UPDATE fts
SET fts.DimTicketClassId =38
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID = 10
AND PC2 = 'O' 
AND PC3 = '6'

----MICRO PLAN MMAN---

UPDATE fts
SET fts.DimTicketClassId =39
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID =10
AND PC2 = 'A' and PC3='N'

----Playoffs Full Season Option A ---

UPDATE fts
SET fts.DimTicketClassId =73
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =36
AND (PC1 NOT in ('A', 'B', 'C') AND PC2 = 'O' AND PC3 = 'A'))

OR  (fts.dimseasonID =19
AND (PC1 NOT in ( 'B', 'C') AND PC2 = 'O' AND PC3 = 'A'))
----Playoffs Full Season Option B ---

UPDATE fts
SET fts.DimTicketClassId =74
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =36
AND (PC1 NOT in ('A', 'B', 'C') AND PC2 = 'O' AND PC3 = 'B'))

 OR (fts.dimseasonID =10
AND (PC1 NOT in ('B', 'C') AND PC2 = 'O' AND PC3 = 'B'))


----Playoffs Full Season Option C ---

UPDATE fts
SET fts.DimTicketClassId =96
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =19
AND (PC1 NOT in ( 'B', 'C') AND PC2 = 'O' AND PC3 = 'C'))

 

----Playoffs Full Season Addiotional ---

UPDATE fts
SET fts.DimTicketClassId =75
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =36
AND (PC1 NOT in ('A', 'B', 'C') AND PC2 = 'O' AND PC3 = 'Z'))

OR (fts.dimseasonID =19
AND (PC1 NOT in ( 'B', 'C') AND PC2 = 'O' AND PC3 = 'Z'))

----Playoffs Ducks Only Option A ---

UPDATE fts
SET fts.DimTicketClassId =76
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =36
 AND  (PC1 in ('A', 'B', 'C') AND PC2 = 'O' AND PC3 = 'A'))

 OR (fts.dimseasonID =19
 AND  (PC1 in ('B', 'C') AND PC2 = 'O' AND PC3 = 'A'))

----Playoffs Ducks Only Option B ---

UPDATE fts
SET fts.DimTicketClassId =77
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =36
 AND  (PC1 in ('A', 'B', 'C') AND PC2 = 'O' AND PC3 = 'B'))

 or (fts.dimseasonID =19
 AND  (PC1 in ('B', 'C') AND PC2 = 'O' AND PC3 = 'B'))


 ----Playoffs Ducks Only Option C ---

UPDATE fts
SET fts.DimTicketClassId =77
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =19
 AND  (PC1 in ('B', 'C') AND PC2 = 'O' AND PC3 = 'C'))



----Playoffs DUcks Only Additional ---

UPDATE fts
SET fts.DimTicketClassId =78
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
 AND  (PC1 in ('B', 'C') AND PC2 = 'O' AND PC3 = 'Z'))

----Playoffs Hlf Season A ---

UPDATE fts
SET fts.DimTicketClassId =79
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC2 = 'H' AND PC3 = 'A')


----Playoffs Half Season B ---

UPDATE fts
SET fts.DimTicketClassId =80
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC2 = 'H' AND PC3 = 'B')


----Playoffs MIni Plan A---

UPDATE fts
SET fts.DimTicketClassId =81
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC2 = 'M' AND PC3 = 'A')

----Playoffs Mini Plan B---

UPDATE fts
SET fts.DimTicketClassId =82
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC2 = 'M' AND PC3 = 'B')



----Playoffs Annual Club20---

UPDATE fts
SET fts.DimTicketClassId =83
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC2 = 'A' AND PC3 = '1')


----Playoffs Annual Club15 ---

UPDATE fts
SET fts.DimTicketClassId =84
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC2 = 'A' AND PC3 = '2')


----Playoffs Annual Club10---

UPDATE fts
SET fts.DimTicketClassId =85
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC2 = 'A' AND PC3 = '3')


----Playoffs Annual Clubnon---

UPDATE fts
SET fts.DimTicketClassId =86
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE ( fts.dimseasonID =36
AND PC2 = 'A' AND PC3 = 'S')


----Playoffs Annual Club Additional---

UPDATE fts
SET fts.DimTicketClassId =98
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =36
AND PC1 = 'A' AND PC2 = 'O' AND PC3 = 'Z')

OR (fts.dimseasonID =19
and PC2 = 'A' AND PC3 = 'C')




----Playoffs Annual Club Broker Additional---

UPDATE fts
SET fts.DimTicketClassId =98
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID =19
AND PC2 = 'B' AND PC3 = 'C')



----Playoffs Annual Suite Annual---

UPDATE fts
SET fts.DimTicketClassId =87
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND ((PC2 = 'A' AND PC3 = 'S') OR (PC2 = 'S' AND PC3 = 'O')))


----Playoffs Annual Suite Ducks Only ---

UPDATE fts
SET fts.DimTicketClassId =88
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND pc2  = 'D')

----Playoffs Single BO ---

UPDATE fts
SET fts.DimTicketClassId =89
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE ( fts.dimseasonID IN(36,19)
AND (IsHost = 1 OR ((PC2 = 'B' AND PC3 in ('O','1','2','4','5','6')))))


----Playoffs Single Employee---

UPDATE fts
SET fts.DimTicketClassId =90
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE ( fts.dimseasonID IN(36,19)
AND pc2 = 'E')


----Playoffs Single bench Seats ---

UPDATE fts
SET fts.DimTicketClassId =91
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC2 = 'B' AND PC3 = 'S')



----Playoffs Rental Suite ---

UPDATE fts
SET fts.DimTicketClassId =92
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC1 = 'V')


----Playoffs Group---

UPDATE fts
SET fts.DimTicketClassId =93
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC1 = 'G')


----Playoffs Comp---

UPDATE fts
SET fts.DimTicketClassId =94
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(36,19)
AND PC1 = 'C')

---------------------------------------
----Full Season Ticket New Full Price with Loaded Values---

UPDATE fts
SET fts.DimTicketClassId = 100
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(47)
AND PC1 NOT in ('B', 'C') AND PC2 = 'N' AND PC3 = 'L')


----Full Season Ticket Renewal Full Price with Loaded Values---

UPDATE fts
SET fts.DimTicketClassId = 101
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE   (fts.dimseasonID IN(47)
AND PC1 NOT in ('B', 'C') AND PC2 = 'R' AND PC3 = 'L')

----Full Season Ticket Upgrade Full Price with Loaded Values---

UPDATE fts
SET fts.DimTicketClassId =102
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE   (fts.dimseasonID IN(47)
AND PC1 NOT in ('B', 'C') AND PC2 = 'U' AND PC3 = 'L')


----Full Season Ticket Addon Full Price with Loaded Values---

UPDATE fts
SET fts.DimTicketClassId =103
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE   (fts.dimseasonID IN(47)
AND PC1 NOT in ('B', 'C') AND PC2 = 'A' AND PC3 = 'L')

----Ducks Only Club New Full Price with Loaded Values---

UPDATE fts
SET fts.DimTicketClassId =104
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE   (fts.dimseasonID IN(47)
AND PC1  in ('B', 'C') AND PC2 = 'N' AND PC3 = 'L')


----Ducks Only Club Renewal Full Price with Loaded Values----

UPDATE fts
SET fts.DimTicketClassId =105
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE   (fts.dimseasonID IN(47)
AND PC1  in ('B', 'C') AND PC2 = 'R' AND PC3 = 'L')


----Ducks Only Club Upgrade Full Price with Loaded Values----

UPDATE fts
SET fts.DimTicketClassId =106
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE   (fts.dimseasonID IN(47)
AND PC1  in ('B', 'C') AND PC2 = 'U' AND PC3 = 'L')


----Ducks Only Club Addon Full Price with Loaded Values----

UPDATE fts
SET fts.DimTicketClassId =107
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  (fts.dimseasonID IN(47)
AND PC1  in ('B', 'C') AND PC2 = 'A' AND PC3 = 'L')




/*****************************************************************************************************************
															Annual Suite NonDucks Seasons - DimseasonID 31
******************************************************************************************************************/


------------------------------------------------Ticket Types------------------------------------------------------------
--UPDATE fts
--SET fts.DimTicketTypeId = 15
--FROM    stg.TM_FactTicketSales  fts
--        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
--		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
--WHERE fts.dimseasonID IN(31,48)
-- AND PriceCode.pc2 IN ('F','M','N','U','S')
-- AND PriceCode.pc1 IN ('A', 'B', 'C', 'D', 'E', 'F' )

 

UPDATE fts
SET fts.DimTicketTypeId = 15
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(31,48)
 AND PriceCode.PC1 IN ('A', 'B', 'C', 'D', 'E', 'F')
 AND PriceCode.pc2 IN ('F','M','N','U','S')

  
UPDATE fts
SET fts.DimTicketTypeId = 16
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(31,48)
 AND PriceCode.PC1 IN ('G', 'H', 'I', 'J')
  AND PriceCode.pc2 IN ('F','M','N','U','S')


 UPDATE fts
SET fts.DimTicketTypeId = 17
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(31,48)
 AND PriceCode.PC1 IN ('L')
 AND PriceCode.pc2 IN ('F','M','N','U','S')


 UPDATE fts
SET fts.DimTicketTypeId = 24
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(31,48)
 AND PriceCode.PC1 IN ('G')
 AND PriceCode.pc2 IN ('A','S','R')


  UPDATE fts
SET fts.DimTicketTypeId = 25
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(31,48)
 AND PriceCode.PC1 IN ('S')
 AND PriceCode.pc2 IN ('A','S','R')


  UPDATE fts
SET fts.DimTicketTypeId = 26
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(31,48)
 AND PriceCode.PC1 IN ('B')
 AND PriceCode.pc2 IN ('A','S','R')


 ------------------------------------------------Plan Types------------------------------------------------------------
 UPDATE fts
SET fts.DimPlanTypeId = 9
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND pc2 = 'N'

 UPDATE fts
SET fts.DimPlanTypeId = 8
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND pc2 = 'M'

 UPDATE fts
SET fts.DimPlanTypeId = 10
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND pc2 = 'F'

 UPDATE fts
SET fts.DimPlanTypeId = 11
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND pc2 = 'U'

 UPDATE fts
SET fts.DimPlanTypeId = 12
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND pc2 = 'S'


 -----------------------------------------------Ticket Class-----------------------------------------------------------



 UPDATE fts
SET fts.DimTicketClassId =53
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC2 = 'N'


 UPDATE fts
SET fts.DimTicketClassId =54
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC2 = 'M'



 UPDATE fts
SET fts.DimTicketClassId =55
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC2 = 'F'


 UPDATE fts
SET fts.DimTicketClassId =56
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC2 = 'U'

 UPDATE fts
SET fts.DimTicketClassId =57
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC2 = 'S'

 UPDATE fts
SET fts.DimTicketClassId =58
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC2 = 'A' AND PC3 = 'S'

 UPDATE fts
SET fts.DimTicketClassId =59
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC2 = 'S' AND PC3 = 'O'

 UPDATE fts
SET fts.DimTicketClassId =60
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC2 = 'R'

 UPDATE fts
SET fts.DimTicketClassId =61
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(31,48)
AND PC1 = 'V'



/*****************************************************************************************************************
															Annual Club NonDucks Seasons - DimseasonID 30
******************************************************************************************************************/



-------------------------------------------------Ticket Types---------------------------------------------------


UPDATE fts
SET fts.DimTicketTypeId = 23
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID  IN(30,49)
 AND PriceCode.pc2 IN ('F','M','N','U','S')

 
UPDATE fts
SET fts.DimTicketTypeId = 18
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(30,49)
 AND PriceCode.PC1 IN ('G')

  
UPDATE fts
SET fts.DimTicketTypeId = 19
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(30,49)
 AND PriceCode.PC1 IN ('S')


 UPDATE fts
SET fts.DimTicketTypeId = 21
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(30,49)
 AND PriceCode.PC1 IN ('B')


 
  UPDATE fts
SET fts.DimTicketTypeId = 22
FROM    stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE fts.dimseasonID IN(30,49)
 AND (fts.IsHost = 1  OR PC2 = 'G' OR PC2 = 'S' OR PC2 = 'B')


  ------------------------------------------------Plan Types------------------------------------------------------------
 UPDATE fts
SET fts.DimPlanTypeId = 9
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND pc2 = 'N'

 UPDATE fts
SET fts.DimPlanTypeId = 8
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND pc2 = 'M'

 UPDATE fts
SET fts.DimPlanTypeId = 10
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND pc2 = 'F'

 UPDATE fts
SET fts.DimPlanTypeId = 11
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND pc2 = 'U'

 UPDATE fts
SET fts.DimPlanTypeId = 12
FROM   stg.TM_FactTicketSales  fts
        INNER JOIN dbo.DimPriceCode_V2 pc ON pc.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 ds ON ds.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND pc2 = 'S'

------------------------------------------------------------Ticket Class---------------------------------------------------------------------

 UPDATE fts
SET fts.DimTicketClassId =62
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND PC2 = 'N'


 UPDATE fts
SET fts.DimTicketClassId =63
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND PC2 = 'M'



 UPDATE fts
SET fts.DimTicketClassId =64
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND PC2 = 'F'


 UPDATE fts
SET fts.DimTicketClassId =65
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND PC2 = 'U'

 UPDATE fts
SET fts.DimTicketClassId =66
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND PC2 = 'S'

 UPDATE fts
SET fts.DimTicketClassId =67
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND PC2 = 'A' AND PC3 = 'C'


 UPDATE fts
SET fts.DimTicketClassId =68
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND pc2 = 'R'


 UPDATE fts
SET fts.DimTicketClassId =69
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND fts.IsHost = 1



 UPDATE fts
SET fts.DimTicketClassId =70
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND PC2 = 'A' and PC3 = 'T'



 UPDATE fts
SET fts.DimTicketClassId =71
FROM     stg.TM_FactTicketSales   fts
        INNER JOIN dbo.DimPriceCode_V2 PriceCode ON PriceCode.DimPriceCodeId = fts.DimPriceCodeId
		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
WHERE  fts.dimseasonID IN(30,49)
AND PC2 = 'T' AND PC3 = 'O'












/*****************************************************************************************************************
															SEAT TYPE
******************************************************************************************************************/

--UPDATE fts
--SET fts.DimSeatTypeID =2
--FROM     stg.TM_FactTicketSales   fts
--		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
--		JOIN dbo.DimSeat_V2 seat ON seat.DimSeatId = fts.DimSeatId_Start
--WHERE  fts.dimseasonID IN(27,10,47)
--AND SectionName IN ('201','202','203','204','205','206','207','208','209'
--,'210','211','212','213','214','215','216','217','218','219','220','221','222','223'
--,'224','225','226','227','228')


--UPDATE fts
--SET fts.DimSeatTypeID =3 
--FROM     stg.TM_FactTicketSales   fts
--		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
--		JOIN dbo.DimSeat_V2 seat ON seat.DimSeatId = fts.DimSeatId_Start
--WHERE  fts.dimseasonID IN(27,10,31,48,47)
--AND SectionName IN('201A','201B','202A','202B','203A','203B','203WC','204A','204B','204WC','205A','205B','206A'
--,'206B','207A','207B','208A','208B','209A','209B','20RS','210A','210B','211A','211B','212A','212B','212WC','213A'
--,'213B','213WC','214A','214B','215A','215B','216A','216B','217A','217B','217WC','218A','218B','218WC','219A'
--,'219B','21FD','220A','220B','221A','221B','222A','222B','223A','223B','224A','224B','225A','225B','226A','226B','226WC'
--,'227A','227B','227WC','228A','228B')



--UPDATE fts
--SET fts.DimSeatTypeID =4 
--FROM     stg.TM_FactTicketSales   fts
--		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
--		JOIN dbo.DimSeat_V2 seat ON seat.DimSeatId = fts.DimSeatId_Start
--WHERE  fts.dimseasonID IN(27,10,30,49,47)
--AND SectionName IN ('301','302','303','304','305','306','307','308','309','310','311','312','313','314'
--,'315','316','317','318','319','320','321','322','323','324','325','326')

--UPDATE fts
--SET fts.DimSeatTypeID =5 
--FROM     stg.TM_FactTicketSales   fts
--		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
--		JOIN dbo.DimSeat_V2 seat ON seat.DimSeatId = fts.DimSeatId_Start
--WHERE  fts.dimseasonID IN(27,10,31,48,47)
--AND SectionName IN ('301A','301B','302A','302B','302PR','303A','303B','303PL','304A','304B','305A','305B','306A','306B','306PR','307A','307B'
--,'307PL','308A','308B','309A','309B','30BL','30FD','310A','310B','310PR','311A','311B','311PL','312A','312B','312WC','313A','313B','313WC','314A'
--,'314B','314PR','314WC','315A','315B','315WC','316A','316B','316PR','317A','317B','318A','318B','319A','319B','31RS','320A','320B','321A','321B'
--,'322A','322B','323A','323B','324A','324B','325A','325B','326A','326B'
--)


--UPDATE fts
--SET fts.DimSeatTypeID =6 
--FROM     stg.TM_FactTicketSales   fts
--		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
--		JOIN dbo.DimSeat_V2 seat ON seat.DimSeatId = fts.DimSeatId_Start
--WHERE  fts.dimseasonID IN(27,10,47)
--AND SectionName IN ('401','402','403','404','405','406','407','408','409','410','411','412','413','414','415'
--,'416','417','418','419','420','421','422','423','424','425','426','427','428','429','430','431','432','433','434','435'
--,'436','437','438','439','440','441','442','443','444')




--UPDATE fts
--SET fts.DimSeatTypeID =7
--FROM     stg.TM_FactTicketSales   fts
--		JOIN dbo.DimSeason_V2 season ON season.DimSeasonId = fts.DimSeasonId
--		JOIN dbo.DimSeat_V2 seat ON seat.DimSeatId = fts.DimSeatId_Start
--WHERE  fts.dimseasonID IN(27,10,47)
--AND RowName = 'SRO'

END

GO
