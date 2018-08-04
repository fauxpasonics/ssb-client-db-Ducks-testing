SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROC  [etl].[Eloqua_Category_Flags_Outbound_load_old20180305] AS


TRUNCATE TABLE  ods.Eloqua_Category_Flags_Outbound 

SELECT DISTINCT ETL__SSID_TM_acct_id
INTO #STH17
FROM dbo.factticketsales_v2
WHERE dimseasonid IN (27,35)
AND DimTicketTypeId = 2
AND ETL__SSID_TM_acct_id <> -1

SELECT DISTINCT ETL__SSID_TM_acct_id
INTO  #STH16
FROM dbo.factticketsales_v2
WHERE dimseasonid = 10
AND DimTicketTypeId = 2
AND ETL__SSID_TM_acct_id <> -1

SELECT DISTINCT cs.ETL__SSID_TM_acct_id
INTO #RookieSTH
FROM #STH17 cs
LEFT OUTER JOIN #STH16 ls 
ON cs.ETL__SSID_TM_acct_id = ls.ETL__SSID_TM_acct_id
WHERE ls.ETL__SSID_TM_acct_id IS NULL



INSERT INTO ods.Eloqua_Category_Flags_Outbound 
			SELECT
			f.ETL__SSID_TM_acct_id
			,m.emailprimary																	
			,MAX(CASE WHEN f.dimtickettypeID = 2 THEN 1 ELSE 0 END)					sth								
			,CASE WHEN COUNT(rs.ETL__SSID_TM_acct_id) > 0 THEN 1 ELSE 0 END 	    RookieSTH 		
			,MAX(CASE WHEN f.dimtickettypeID = 4 THEN 1 ELSE 0 END) 				MiniPlan 		
			,MAX(CASE WHEN f.dimtickettypeID = 9 THEN 1 ELSE 0 END) 				MicroPlan 		
			,MAX(CASE WHEN f.dimtickettypeID = 5 THEN 1 ELSE 0 END) 				SingleGame 	
			,MAX(CASE WHEN f.dimtickettypeID = 8 THEN 1 ELSE 0 END) 				Club
			,MAX(CASE WHEN f.dimtickettypeID = 10 THEN 1 ELSE 0 END) 				Suite		
			,MAX(CASE WHEN tex_buyer.activity = 'ES' THEN 1 ELSE 0 END) 			SecondaryBuyer 	
			,MAX(CASE WHEN tex_reseller.activity = 'ES' THEN 1 ELSE 0 END)        	SecondaryReseller 
			,MAX(CASE WHEN tex_forwarder.activity IN ('F','X') THEN 1 ELSE 0 END) 	SecondaryForwarder
			,MAX(CASE WHEN tex_receiver.activity IN ('F','X') THEN 1 ELSE 0 END)  	SecondaryReceiver 
			,MAX(CASE WHEN m.accounttype = 'Broker' THEN 1 ELSE 0 END) 				BROKER 			
--layer in max datetime instead of flags
--INTO ods.Eloqua_Category_Flags_Outbound 
FROM dbo.FactTicketSales_V2 f WITH (NOLOCK)--442890
JOIN dbo.DimTicketType_V2 t WITH (NOLOCK)
ON t.DimTicketTypeId = f.DimTicketTypeId
JOIN  dbo.vwDimCustomer_ModAcctId m WITH (NOLOCK)
ON f.ETL__SSID_TM_acct_id = m.AccountId AND m.SourceSystem = 'TM' AND m.CustomerType = 'Primary' --851633
LEFT JOIN ods.tm_tex tex_buyer WITH (NOLOCK)
	ON m.AccountId = tex_buyer.assoc_acct_id AND m.CustomerType = 'Primary' AND m.SourceSystem = 'TM' AND tex_buyer.activity IN ('ES')--939883
LEFT JOIN ods.tm_tex tex_reseller WITH (NOLOCK)
	ON m.AccountId = tex_reseller.acct_id AND m.CustomerType = 'Primary' AND m.SourceSystem = 'TM' AND tex_reseller.activity IN ('ES')
LEFT JOIN ods.tm_tex tex_forwarder WITH (NOLOCK)
	ON m.AccountId = tex_forwarder.acct_id AND m.CustomerType = 'Primary' AND m.SourceSystem = 'TM' AND tex_forwarder.activity IN ('F','X')
LEFT JOIN ods.tm_tex tex_receiver WITH (NOLOCK)
	ON m.AccountId = tex_receiver.assoc_acct_id AND m.CustomerType = 'Primary' AND m.SourceSystem = 'TM' AND tex_receiver.activity IN ('F','X')
LEFT JOIN #RookieSTH RS
	ON f.ETL__SSID_TM_acct_id = rs.ETL__SSID_TM_acct_id
WHERE f.ETL__SSID_TM_acct_id <> -1
AND f.DimSeasonId IN (27,10,35)
GROUP BY f.ETL__SSID_TM_acct_id,m.EmailPrimary



GO
