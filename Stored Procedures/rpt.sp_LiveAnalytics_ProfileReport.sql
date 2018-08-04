SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--Declare @Interest Varchar(255) = 'Arts';
--Declare @Segment1 Varchar(255) = 'Sports';
CREATE PROCEDURE [rpt].[sp_LiveAnalytics_ProfileReport]
AS
WITH CTE_Customer 
AS (
	SELECT *
	FROM ods.LiveAnalytics_Customer
),
CTE_Segments
AS (
		SELECT 'ARTS' AS Segment, *
		FROM CTE_Customer
		WHERE [Int_Arts_Cd] = '1' 
		UNION
		SELECT 'SPORTS' AS Segment, *
		FROM CTE_Customer
		WHERE [Int_Spectator_Sport_Baseb_Cd] = '1' 
				OR [Int_Spectator_Sport_Bsktb_Cd] = '1'
				OR [Int_Spectator_Sport_Footb_Cd] = '1'
				OR [Int_Spectator_Sport_Hockey_Cd] = '1'
				OR [Int_Spectator_Sport_Soccer_Cd] = '1'
				OR [Int_Spectator_Sport_Tennis_Cd] = '1'
				OR [Int_Sports_Grp_Cd] = '1'
		UNION
		SELECT 'MUSIC' AS Segment, *
		FROM CTE_Customer
		WHERE [Int_Music_Grp_Cd] = '1' 
		UNION
		SELECT 'UPSCALE LIVING' AS Segment, *
		FROM CTE_Customer
		WHERE [Int_Upscale_Living_Cd] = '1' 
		UNION
		SELECT 'CULTURAL/ARTISTIC LIVING' AS Segment, *
		FROM CTE_Customer
		WHERE [Int_Cultural_Living_Cd] = '1' 
					
)
SELECT Segment, Category, Metric, MetricValue, MetricValueLabel
FROM (
		SELECT Segment, Category, Age AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Age' AS Category,
					'Age' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN AGE_TWO_YR_INCR_INPUT_INDV BETWEEN 18 AND 24 THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [18-24],
					CAST(SUM(CASE WHEN AGE_TWO_YR_INCR_INPUT_INDV BETWEEN 25 AND 34 THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [25-34],
					CAST(SUM(CASE WHEN AGE_TWO_YR_INCR_INPUT_INDV BETWEEN 35 AND 44 THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [35-44],
					CAST(SUM(CASE WHEN AGE_TWO_YR_INCR_INPUT_INDV BETWEEN 45 AND 54 THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [45-54],
					CAST(SUM(CASE WHEN AGE_TWO_YR_INCR_INPUT_INDV BETWEEN 55 AND 64 THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [55-64],
					CAST(SUM(CASE WHEN AGE_TWO_YR_INCR_INPUT_INDV >= 65 THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [65+],
					CAST(SUM(CASE WHEN AGE_TWO_YR_INCR_INPUT_INDV = ' ' THEN 1 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Undefined],
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY Segment
			) p
		UNPIVOT
			(MetricValue FOR Age IN
				( [18-24], [25-34], [35-44], [45-54], [55-64], [65+], [Undefined] )
			) AS unpvt
		UNION
		SELECT Segment, Category, Gender AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Gender' AS Category,
					'Gender' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN GNDR_INPUT_INDV_CD = 'M' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Male],
					CAST(SUM(CASE WHEN GNDR_INPUT_INDV_CD = 'F' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Female],
					CAST(SUM(CASE WHEN (GNDR_INPUT_INDV_CD != 'M' AND GNDR_INPUT_INDV_CD != 'F') /*or GNDR_INPUT_INDV_CD IS NULL*/ THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Undefined],
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Gender IN
				( [Male], [Female], [Undefined] )
			) AS unpvt
		UNION
		SELECT Segment, Category, Household_Children AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Household_Children' AS Category,
					'Household_Children' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN PRESENCE_CHLDN_NEW_FLG = 'Y' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Yes],
					CAST(SUM(CASE WHEN PRESENCE_CHLDN_NEW_FLG = 'N' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [No],
					CAST(SUM(CASE WHEN PRESENCE_CHLDN_NEW_FLG != 'N' AND PRESENCE_CHLDN_NEW_FLG != 'Y' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Unknown],
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Household_Children IN
				( [Yes], [No], [Unknown] )
			) AS unpvt
		UNION
		SELECT Segment, Category, Education AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Education' AS Category,
					'Education' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN EDU_1ST_INDV_CD = '1' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [High School],
					CAST(SUM(CASE WHEN EDU_1ST_INDV_CD = '2' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [College],
					CAST(SUM(CASE WHEN EDU_1ST_INDV_CD = '3' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Graduate],
					CAST(SUM(CASE WHEN EDU_1ST_INDV_CD = '4' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Vocational],
					CAST(SUM(CASE WHEN EDU_1ST_INDV_CD = ' ' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Undefined],
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Education IN
				( [High School], [College], [Graduate], [Vocational], [Undefined] )
			) AS unpvt
		UNION
		SELECT Segment, Category, Race AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Race' AS Category,
					'Race' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN RACE_CD = 'A' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Asian],
					CAST(SUM(CASE WHEN RACE_CD = 'B' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Afr Am],
					CAST(SUM(CASE WHEN RACE_CD = 'H' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Hispanic],
					CAST(SUM(CASE WHEN RACE_CD = 'W' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Caucasian],
					CAST(SUM(CASE WHEN RACE_CD = ' ' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Undefined],
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Race IN
				( [Asian], [Afr Am], [Hispanic], [Caucasian], [Undefined] )
			) AS unpvt
		UNION
		SELECT Segment, Category, Vehicle_Type AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Vehicle_Type' AS Category,
					'Vehicle_Type' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN VEH_DOMINANT_LIFESTYLE_CD = 'A' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Luxury],
					CAST(SUM(CASE WHEN VEH_DOMINANT_LIFESTYLE_CD = 'B' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Truck],
					CAST(SUM(CASE WHEN VEH_DOMINANT_LIFESTYLE_CD = 'C' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [SUV],
					CAST(SUM(CASE WHEN VEH_DOMINANT_LIFESTYLE_CD = 'D' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Mini Van],
					CAST(SUM(CASE WHEN VEH_DOMINANT_LIFESTYLE_CD = 'E' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Regular],
					CAST(SUM(CASE WHEN VEH_DOMINANT_LIFESTYLE_CD = 'F' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Upper],
					CAST(SUM(CASE WHEN VEH_DOMINANT_LIFESTYLE_CD = 'G' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Basic Sporty],
					CAST(SUM(CASE WHEN VEH_DOMINANT_LIFESTYLE_CD = ' ' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Undefined],
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Vehicle_Type IN
				( [Luxury], [Truck], [SUV], [Mini Van], [Regular], [Upper], [Basic Sporty], [Undefined] )
			) AS unpvt
		UNION
		SELECT Segment, Category, Married_Household AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Married_Household' AS Category,
					'Married_Household' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN MARITAL_STATUS_HH_CD IN ('M', 'A') THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Married],
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Married_Household IN
				( [Married] )
			) AS unpvt
		UNION
		SELECT Segment, Category, Children_Household AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Children_Household' AS Category,
					'Children_Household' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN PRESENCE_CHLDN_NEW_FLG = 'Y' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Children],
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Children_Household IN
				( [Children] )
			) AS unpvt
		UNION
		SELECT Segment, Category, Working_Women_Household AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Working_Women_Household' AS Category,
					'Working_Women_Household' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN WRK_WMN_HH_FLG = 'Y' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS WorkingWomen,
					COUNT(1) AS Customers
				FROM CTE_Segments
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Working_Women_Household IN
				( WorkingWomen )
			) AS unpvt
		UNION
		SELECT Segment, Category, Household_Income AS Metric, MetricValue, FORMAT(MetricValue, 'C', 'en-us') AS MetricValueLabel
		FROM (
				SELECT Category, Metric, Segment, SUM(CAST(Household_Income_x_Count AS BIGINT)) / SUM(Customers) AS Avg_Household_Income
				FROM (
					SELECT 
						'Household_Income' AS Category,
						'Household_Income' AS Metric,
						Segment,
						CASE EST_HH_INC_HIGHER_RANGES_CD
							WHEN '1' THEN '5000'
							WHEN '2' THEN '10000'
							WHEN '3' THEN '15000'
							WHEN '4' THEN '20000'
							WHEN '5' THEN '25000'
							WHEN '6' THEN '30000'
							WHEN '7' THEN '35000'
							WHEN '8' THEN '40000'
							WHEN '9' THEN '45000'
							WHEN 'A' THEN '50000'
							WHEN 'B' THEN '55000'
							WHEN 'C' THEN '60000'
							WHEN 'D' THEN '65000'
							WHEN 'E' THEN '75000'
							WHEN 'F' THEN '100000'
							WHEN 'G' THEN '150000'
							WHEN 'H' THEN '175000'
							WHEN 'I' THEN '200000'
							WHEN 'J' THEN '250000'		
							END AS Household_Income,
						CASE EST_HH_INC_HIGHER_RANGES_CD
							WHEN '1' THEN '5000'
							WHEN '2' THEN '10000'
							WHEN '3' THEN '15000'
							WHEN '4' THEN '20000'
							WHEN '5' THEN '25000'
							WHEN '6' THEN '30000'
							WHEN '7' THEN '35000'
							WHEN '8' THEN '40000'
							WHEN '9' THEN '45000'
							WHEN 'A' THEN '50000'
							WHEN 'B' THEN '55000'
							WHEN 'C' THEN '60000'
							WHEN 'D' THEN '65000'
							WHEN 'E' THEN '75000'
							WHEN 'F' THEN '100000'
							WHEN 'G' THEN '150000'
							WHEN 'H' THEN '175000'
							WHEN 'I' THEN '200000'
							WHEN 'J' THEN '250000'		
							END *  COUNT(1) AS Household_Income_x_Count,
						COUNT(1) AS Customers
					FROM CTE_Segments
					WHERE EST_HH_INC_HIGHER_RANGES_CD <> ''
					GROUP BY 
						Segment,
						EST_HH_INC_HIGHER_RANGES_CD
				) a
				GROUP BY Category, Metric, Segment
			) p
		UNPIVOT
			(MetricValue FOR Household_Income IN
				( Avg_Household_Income )
			) AS unpvt
		UNION
		SELECT Segment, Category, Household_Income_Bucket AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Household_Income_Bucket' AS Category,
					'Household_Income_Bucket' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '1' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Under $10,000],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '2' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$10,000 - $14,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '3' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$15,000 - $19,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '4' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$20,000 - $24,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '5' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$25,000 - $29,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '6' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$30,000 - $34,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '7' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$35,000 - $39,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '8' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$40,000 - $44,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = '9' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$45,000 - $49,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'A' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$50,000 - $54,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'B' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$55,000 - $59,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'C' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$60,000 - $64,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'D' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$65,000 - $74,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'E' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$75,000 - $99,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'F' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$100,000 - $149,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'G' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$150,000 - $174,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'H' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$175,000 - $199,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'I' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$200,000 - $249,999],
					CAST(SUM(CASE WHEN EST_HH_INC_HIGHER_RANGES_CD = 'J' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$250,000 +],
					COUNT(1) AS Customers
				FROM CTE_Segments
				WHERE EST_HH_INC_HIGHER_RANGES_CD <> ''
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Household_Income_Bucket IN
				( [Under $10,000], [$10,000 - $14,999], [$15,000 - $19,999], [$20,000 - $24,999], [$25,000 - $29,999], [$30,000 - $34,999], [$35,000 - $39,999], [$40,000 - $44,999], [$45,000 - $49,999], [$50,000 - $54,999], 
				[$55,000 - $59,999], [$60,000 - $64,999], [$65,000 - $74,999], [$75,000 - $99,999], [$100,000 - $149,999], [$150,000 - $174,999], [$175,000 - $199,999], [$200,000 - $249,999], [$250,000 +])
			) AS unpvt
		UNION
		SELECT Segment, Category, Net_Worth AS Metric, MetricValue, FORMAT(MetricValue, 'C', 'en-us') AS MetricValueLabel
		FROM (
				SELECT Category, Metric, Segment, SUM(CAST(Net_Worth_x_Count AS BIGINT)) / SUM(Customers) AS Avg_Net_Worth
				FROM (
					SELECT 
						'Net_Worth' AS Category,
						'Net_Worth' AS Metric,
						Segment,
						CASE NET_WORTH_GOLD_CD
							WHEN '1' THEN '0'
							WHEN '2' THEN '1'
							WHEN '3' THEN '5000'
							WHEN '4' THEN '10000'
							WHEN '5' THEN '25000'
							WHEN '6' THEN '50000'
							WHEN '7' THEN '100000'
							WHEN '8' THEN '250000'
							WHEN '9' THEN '500000'
							WHEN 'A' THEN '1000000'
							WHEN 'B' THEN '2000000'
							END AS Net_Worth,
						CASE NET_WORTH_GOLD_CD
							WHEN '1' THEN '0'
							WHEN '2' THEN '1'
							WHEN '3' THEN '5000'
							WHEN '4' THEN '10000'
							WHEN '5' THEN '25000'
							WHEN '6' THEN '50000'
							WHEN '7' THEN '100000'
							WHEN '8' THEN '250000'
							WHEN '9' THEN '500000'
							WHEN 'A' THEN '1000000'
							WHEN 'B' THEN '2000000'	
							END *  COUNT(1) AS Net_Worth_x_Count,
						COUNT(1) AS Customers
					FROM CTE_Segments
					WHERE NET_WORTH_GOLD_CD <> ''
					GROUP BY 
						Segment,
						NET_WORTH_GOLD_CD
				) a
				GROUP BY Category, Metric, Segment
			) p
		UNPIVOT
			(MetricValue FOR Net_Worth IN
				( Avg_Net_Worth )
			) AS unpvt
		UNION
		SELECT Segment, Category, Net_Worth_Bucket AS Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Net_Worth_Bucket' AS Category,
					'Net_Worth_Bucket' AS Metric,
					Segment,
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '1' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Less than $1],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '2' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$1 - $4,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '3' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$5,000 - $9,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '4' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$10,000 - $24,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '5' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$25,000 - $49,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '6' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$50,000 - $99,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '7' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$100,000 - $249,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '8' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$250,000 - $499,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = '9' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$500,000 - $999,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = 'A' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [$1,000,000 - $1,999,999],
					CAST(SUM(CASE WHEN NET_WORTH_GOLD_CD = 'B' THEN 1 ELSE 0 END) / CAST(COUNT(1) AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [Greater than $1,999,999],
					COUNT(1) AS Customers
				FROM CTE_Segments
				WHERE NET_WORTH_GOLD_CD <> ''
				GROUP BY 
					Segment
			) p
		UNPIVOT
			(MetricValue FOR Net_Worth_Bucket IN
				( [Less than $1], [$1 - $4,999], [$5,000 - $9,999], [$10,000 - $24,999], [$25,000 - $49,999], [$50,000 - $99,999], [$100,000 - $249,999], [$250,000 - $499,999],
				[$500,000 - $999,999], [$1,000,000 - $1,999,999], [Greater than $1,999,999]
				)
			) AS unpvt
		UNION
		SELECT Segment, Category, DII AS Metric, MetricValue, CONCAT('', MetricValue) AS MetricValueLabel
		FROM (
				SELECT Category, Metric, Segment, SUM(CAST(DII AS BIGINT)) / SUM(Customers) AS Avg_DII
				FROM (
					SELECT 
						'DII' AS Category,
						'DII' AS Metric,
						Segment,
						DISCRETIONARY_INCOME_INDEX_CD * COUNT(1) AS DII,
						COUNT(1) AS Customers
					FROM CTE_Segments
					WHERE DISCRETIONARY_INCOME_INDEX_CD <> ''
					GROUP BY 
						Segment,
						DISCRETIONARY_INCOME_INDEX_CD
				) a
				GROUP BY Category, Metric, Segment
			) p
		UNPIVOT
			(MetricValue FOR DII IN
				( Avg_DII )
			) AS unpvt
		UNION
		SELECT Segment, Category, Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'DII_Bucket' AS Category,
					Segment,
					CASE  
						WHEN DISCRETIONARY_INCOME_INDEX_CD = 0 THEN '0'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 50 THEN '1-50'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 100 THEN '51-100'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 150 THEN '101-150'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 200 THEN '151-200'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 500 THEN '201-500'
						ELSE '+500'
						END AS Metric,
					CAST(COUNT(1) / CAST(ac.TotalCount AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [MetricValue]
				FROM CTE_Segments c
				CROSS JOIN (
						SELECT COUNT(1) AS TotalCount
						FROM CTE_Segments c
						WHERE DISCRETIONARY_INCOME_INDEX_CD <> ''
					) ac
				WHERE DISCRETIONARY_INCOME_INDEX_CD <> ''
				GROUP BY 
					Segment,
					CASE  
						WHEN DISCRETIONARY_INCOME_INDEX_CD = 0 THEN '0'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 50 THEN '1-50'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 100 THEN '51-100'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 150 THEN '101-150'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 200 THEN '151-200'
						WHEN DISCRETIONARY_INCOME_INDEX_CD <= 500 THEN '201-500'
						ELSE '+500'
						END,
					ac.TotalCount
			) p
		UNION
		SELECT Segment, Category, Metric, MetricValue, CONCAT(CAST(MetricValue * 100 AS DECIMAL(19,2)), '%') AS MetricValueLabel
		FROM (
				SELECT 
					'Financial_Score_Index_Bucket' AS Category,
					Segment,
					CASE  
						WHEN FINANCIAL_PCT_SCORE = 0 THEN '0'
						WHEN FINANCIAL_PCT_SCORE <= 250 THEN 'Bottom 25%'
						WHEN FINANCIAL_PCT_SCORE <= 350 THEN '26% - 35%'
						WHEN FINANCIAL_PCT_SCORE <= 500 THEN '35%-50%'
						WHEN FINANCIAL_PCT_SCORE <= 600 THEN '51%-60%'
						WHEN FINANCIAL_PCT_SCORE <= 750 THEN '61%-75%'
						WHEN FINANCIAL_PCT_SCORE <= 900 THEN '76%-90%'
						ELSE '91%-100%'
						END AS Metric,
					CAST(COUNT(1) / CAST(ac.TotalCount AS DECIMAL(19,4)) AS DECIMAL(19,4)) AS [MetricValue]
				FROM CTE_Segments c
				CROSS JOIN (
						SELECT COUNT(1) AS TotalCount
						FROM CTE_Segments c
						WHERE FINANCIAL_PCT_SCORE <> ''
					) ac
				WHERE FINANCIAL_PCT_SCORE <> ''
				GROUP BY 
					Segment,
					CASE  
						WHEN FINANCIAL_PCT_SCORE = 0 THEN '0'
						WHEN FINANCIAL_PCT_SCORE <= 250 THEN 'Bottom 25%'
						WHEN FINANCIAL_PCT_SCORE <= 350 THEN '26% - 35%'
						WHEN FINANCIAL_PCT_SCORE <= 500 THEN '35%-50%'
						WHEN FINANCIAL_PCT_SCORE <= 600 THEN '51%-60%'
						WHEN FINANCIAL_PCT_SCORE <= 750 THEN '61%-75%'
						WHEN FINANCIAL_PCT_SCORE <= 900 THEN '76%-90%'
						ELSE '91%-100%'
						END,
					ac.TotalCount
			) p
	) AllCategories;
GO
