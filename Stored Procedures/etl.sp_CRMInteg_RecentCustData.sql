SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE PROCEDURE [etl].[sp_CRMInteg_RecentCustData]
AS

TRUNCATE TABLE etl.CRMProcess_RecentCustData

DECLARE @Client VARCHAR(50)
SET @Client = 'Ducks' --updateme


SELECT x.dimcustomerid, MAX(x.maxtransdate) maxtransdate, x.team
INTO #tmpTicketSales
	FROM (
	------------TicketPurchases for last 2 years------------------------------------------------------	
		SELECT dc.dimcustomerid, MAX(fts.createdDate) maxtransdate, @Client AS team
		FROM  dbo.DimCustomer dc (NOLOCK)
			INNER JOIN dbo.FactTicketSales_V2 fts
				ON dc.AccountId = fts.ETL__SSID_TM_acct_id AND dc.SourceSystem = 'TM'
		WHERE dc.CustomerType='Primary' AND YEAR(fts.CreatedDate)>= YEAR(GETDATE()) - 2
		GROUP BY dc.dimcustomerid


        UNION
		
		SELECT dc.dimcustomerid, MAX(n.upd_Datetime) maxtransdate, @Client AS team
		FROM dbo.DimCustomer dc WITH (NOLOCK) 
			INNER JOIN ods.TM_Note n
				ON n.acct_id = dc.AccountId
		WHERE dc.CustomerType='Primary' AND CONVERT(DATE,n.upd_Datetime)>='1/1/16'
		GROUP BY dc.DimCustomerId

		UNION
        
		SELECT dc.dimcustomerid, MAX(tex.add_datetime) MaxTransDate, @client Team
		FROM ducks.ods.TM_Tex tex WITH (NOLOCK)
		LEFT JOIN ducks.dbo.dimcustomer dc WITH (NOLOCK) ON tex.assoc_acct_id = dc.accountid AND dc.customertype = 'Primary' AND dc.sourcesystem = 'TM'
		WHERE tex.add_datetime >= DATEADD(YEAR, -2, GETDATE()+2)
		GROUP BY dc.dimcustomerid

		UNION
	----------------Eloqua Activity for the last 2 years------------------------------------------------------	
		SELECT  d.DimCustomerId, MAX(a.CreatedAt) AS maxtransdate, @client AS Team
		FROM ducks.dbo.vwDimCustomer_ModAcctId d 
		JOIN [ods].[Eloqua_ActivityEmailOpen] a
			ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua'
			WHERE YEAR(a.createdat) >= YEAR(GETDATE()) - 2
		GROUP BY d.DimCustomerId 
		
		
		
		UNION 
		
		SELECT d.DimCustomerId, MAX(a.CreatedAt) AS maxtransdate, @client AS Team
		FROM ducks.dbo.vwDimCustomer_ModAcctId d 
		JOIN [ods].[Eloqua_ActivityEmailClickThrough] a
			ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua'
			WHERE YEAR(a.createdat) >= YEAR(GETDATE()) - 2
		GROUP BY d.DimCustomerId 
		
		
		--UNION     removed sends
		
		--SELECT d.DimCustomerId, MAX(a.CreatedAt) AS maxtransdate, @client AS Team
		--FROM dbo.vwDimCustomer_ModAcctId d 
		--JOIN  [ods].[Eloqua_ActivityEmailSend] a
		--	ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua'
		--	WHERE YEAR(a.createdat) >= YEAR(GETDATE()) - 2
		--GROUP BY d.DimCustomerId 
		
		
		UNION 
		
		SELECT  d.DimCustomerId, MAX(a.CreatedAt) AS maxtransdate, @client AS Team
		FROM ducks.dbo.vwDimCustomer_ModAcctId d 
		JOIN  [ods].[Eloqua_ActivityEmailSubscribe] a
			ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua'
			WHERE YEAR(a.createdat) >= YEAR(GETDATE()) - 2
		GROUP BY d.DimCustomerId 
		
		
		UNION 
		
		SELECT d.DimCustomerId, MAX(a.CreatedAt) AS maxtransdate, @client AS Team
		FROM ducks.dbo.vwDimCustomer_ModAcctId d 
		JOIN  [ods].[Eloqua_ActivityFormSubmit] a
			ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua'
			WHERE YEAR(a.createdat) >= YEAR(GETDATE()) - 2
		GROUP BY d.DimCustomerId 
		
		
		
		UNION 
		
		SELECT d.DimCustomerId, MAX(a.CreatedAt) AS maxtransdate, @client AS Team
		FROM ducks.dbo.vwDimCustomer_ModAcctId d 
		JOIN  [ods].[Eloqua_ActivityFormSubmit] a
			ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua'
			WHERE YEAR(a.createdat) >= YEAR(GETDATE()) - 2
		GROUP BY d.DimCustomerId 
		
		
		UNION 
		
		SELECT d.DimCustomerId, MAX(a.CreatedAt) AS maxtransdate, @client AS Team
		FROM ducks.dbo.vwDimCustomer_ModAcctId d 
		JOIN  [ods].[Eloqua_ActivityPageView] a
			ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua'
			WHERE YEAR(a.createdat) >= YEAR(GETDATE()) - 2
		GROUP BY d.DimCustomerId 
		
		
		
		UNION 
		
		SELECT d.DimCustomerId, MAX(a.CreatedAt) AS maxtransdate, @client AS Team
		FROM ducks.dbo.vwDimCustomer_ModAcctId d 
		JOIN [ods].[Eloqua_ActivityWebVisit] a
			ON a.contactID = d.ssid AND d.sourcesystem = 'Eloqua'
			WHERE YEAR(a.createdat) >= YEAR(GETDATE()) - 2
		GROUP BY d.DimCustomerId 


		UNION
----------------LIVEA/FanMatch customers who are Client_Walkup_buyers------------------------------------------------------	


		SELECT d.DimCustomerId, MAX(a.client_sale_dt_max) AS maxtransdate, @client AS Team
		FROM ducks.dbo.vwDimCustomer_ModAcctId d 
		JOIN ods.LiveAnalytics_Customer a
			ON a.ult_party_id = d.ssid AND d.sourcesystem = 'LiveAnalytics'
			WHERE a.client_walkup_buyer_ind = '1'
			AND d.CreatedDate  >= YEAR(GETDATE()) - 2
		GROUP BY d.DimCustomerId 


----------------DataUploader Enter to Win Net New Customer------------------------------------------------------	


union


		SELECT  a.DimCustomerId, max(a.createddate)  AS maxtransdate	, @client AS Team								
			--INTO #dimattributes
			FROM dbo.DimCustomer a WITH (NOLOCK)
			INNER JOIN dbo.DimCustomerAttributes b WITH (NOLOCK) ON a.DimCustomerId = b.DimCustomerID
			INNER JOIN dbo.DimCustomerAttributeValues c WITH (NOLOCK) ON b.DimCustomerAttrID = c.DimCustomerAttrID
			WHERE 1=1
			AND ((c.AttributeName ='MiniPlanInterest' AND c.AttributeValue = 'Yes') 
			or(c.AttributeName ='SuiteInterest' AND c.AttributeValue = 'Yes')
			or (c.AttributeName ='GroupInterest' AND c.AttributeValue = 'Yes')
			or(c.AttributeName ='SingleGameTicketInterest' AND c.AttributeValue = 'Yes'))
			group by a.dimcustomerID





		) x
		GROUP BY x.dimcustomerid, x.team



INSERT INTO etl.CRMProcess_RecentCustData (SSID, MaxTransDate, Team)
SELECT SSID, [MaxTransDate], Team FROM [#tmpTicketSales] a 
INNER JOIN ducks.dbo.[vwDimCustomer_ModAcctId] b ON [b].[DimCustomerId] = [a].[DimCustomerId]




GO
