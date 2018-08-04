SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROC [etl].[Eloqua_Category_Flags_Outbound_load]
AS

BEGIN



TRUNCATE TABLE ods.Eloqua_Category_Flags_Outbound; 


SELECT DISTINCT ETL__SSID_TM_acct_id
INTO #STH17
FROM dbo.factticketsales_v2
WHERE dimseasonid IN (27,35)
AND DimTicketTypeId = 2
AND ETL__SSID_TM_acct_id <> -1;
CREATE NONCLUSTERED INDEX idx_STH17 on #STH17(ETL__SSID_TM_acct_id);


SELECT DISTINCT ETL__SSID_TM_acct_id
INTO  #STH16
FROM dbo.factticketsales_v2
WHERE dimseasonid = 10
AND DimTicketTypeId = 2
AND ETL__SSID_TM_acct_id <> -1;
CREATE NONCLUSTERED INDEX idx_STH16 on #STH16(ETL__SSID_TM_acct_id);


SELECT DISTINCT cs.ETL__SSID_TM_acct_id
INTO #RookieSTH
FROM #STH17 cs
LEFT OUTER JOIN #STH16 ls 
ON cs.ETL__SSID_TM_acct_id = ls.ETL__SSID_TM_acct_id
WHERE ls.ETL__SSID_TM_acct_id IS NULL;
CREATE NONCLUSTERED INDEX idx_RookieSTH on #RookieSTH(ETL__SSID_TM_acct_id);


--INSERT INTO ods.Eloqua_Category_Flags_Outbound
	SELECT
	f.ETL__SSID_TM_acct_id
	,m.emailprimary																	
	,CASE WHEN f.dimtickettypeID = 2 THEN seas.SeasonYear ELSE null END						sth								
	,CASE WHEN COUNT(rs.ETL__SSID_TM_acct_id) > 0 THEN seas.SeasonYear ELSE null END 		RookieSTH 		
	,CASE WHEN f.dimtickettypeID IN(4,3) THEN seas.SeasonYear ELSE null END					MiniPlan 		
	,CASE WHEN f.dimtickettypeID = 9 THEN seas.SeasonYear ELSE null END 					MicroPlan 		
	,CASE WHEN f.dimtickettypeID = 5 THEN seas.SeasonYear ELSE null END						SingleGame 	
	,CASE WHEN f.dimtickettypeID = 8 THEN seas.SeasonYear ELSE null END						Club
	,CASE WHEN f.dimtickettypeID = 10 THEN seas.SeasonYear ELSE null END					Suite		
	,CASE WHEN tex_buyer_receiver.activity = 'ES' THEN tex_buyer_receiver.season_year ELSE null END 			SecondaryBuyer 	
	,CASE WHEN tex_reseller_forwarder.activity = 'ES' THEN tex_buyer_receiver.season_year ELSE null END        SecondaryReseller 
	,CASE WHEN tex_reseller_forwarder.activity IN ('F','X') THEN tex_buyer_receiver.season_year ELSE null END 	SecondaryForwarder
	,CASE WHEN tex_buyer_receiver.activity IN ('F','X') THEN tex_buyer_receiver.season_year ELSE null END 	SecondaryReceiver 
	,CASE WHEN m.accounttype = 'Broker' THEN seas.SeasonYear ELSE null END				BROKER 			

INTO  #cateogries
--		select *
FROM dbo.FactTicketSales_V2 f WITH (NOLOCK)
JOIN dbo.DimTicketType_V2 t WITH (NOLOCK)
	ON t.DimTicketTypeId = f.DimTicketTypeId
JOIN dbo.DimSeason_V2 seas
	ON seas.DimSeasonId = f.DimSeasonId
JOIN dbo.vwDimCustomer_ModAcctId m WITH (NOLOCK)
	ON f.ETL__SSID_TM_acct_id = m.AccountId
	AND m.SourceSystem = 'TM'
	AND m.CustomerType = 'Primary'
LEFT JOIN #RookieSTH RS
	ON f.ETL__SSID_TM_acct_id = rs.ETL__SSID_TM_acct_id
LEFT JOIN ods.tm_tex AS tex_buyer_receiver (NOLOCK)
	ON m.AccountId = tex_buyer_receiver.assoc_acct_id
--	AND m.CustomerType = 'Primary'
--	AND m.SourceSystem = 'TM'
	AND tex_buyer_receiver.activity IN ('ES','F','X')
LEFT JOIN ods.tm_tex AS tex_reseller_forwarder (NOLOCK)
	ON m.AccountId = tex_reseller_forwarder.acct_id
--	AND m.CustomerType = 'Primary'
--	AND m.SourceSystem = 'TM'
	AND tex_reseller_forwarder.activity IN ('ES','F','X')

/*
LEFT JOIN ods.tm_tex tex_forwarder WITH (NOLOCK)
	ON m.AccountId = tex_forwarder.acct_id AND m.CustomerType = 'Primary' AND m.SourceSystem = 'TM' AND tex_forwarder.activity IN ('F','X')
LEFT JOIN ods.tm_tex tex_receiver WITH (NOLOCK)
	ON m.AccountId = tex_receiver.assoc_acct_id AND m.CustomerType = 'Primary' AND m.SourceSystem = 'TM' AND tex_receiver.activity IN ('F','X')
*/

WHERE f.ETL__SSID_TM_acct_id <> -1
AND ISNULL(m.EmailPrimary,'')<>''
AND f.DimSeasonId IN (27,10,35)
GROUP BY f.ETL__SSID_TM_acct_id,m.EmailPrimary, seas.SeasonYear,f.dimtickettypeID,tex_buyer_receiver.season_year,tex_buyer_receiver.activity,tex_reseller_forwarder.activity, m.accounttype


SELECT ETL__SSID_TM_acct_id,
	   emailprimary,
       MAX(sth)sth,
       MAX(RookieSTH)RookieSTH,
       MAX(MiniPlan)MiniPlan,
       MAX(MicroPlan)MicroPlan,
       MAX(SingleGame)SingleGame,
       MAX(Club)Club,
       MAX(Suite)Suite,
       MAX(SecondaryBuyer)SecondaryBuyer,
       MAX(SecondaryReseller)SecondaryReseller,
       MAX(SecondaryForwarder)SecondaryForwarder,
       MAX(SecondaryReceiver)SecondaryReceiver,
       MAX(BROKER)Broker 


INTO  #maxyears
FROM #cateogries
GROUP BY ETL__SSID_TM_acct_id,
	   emailprimary



INSERT INTO ods.Eloqua_Category_Flags_Outbound

SELECT ETL__SSID_TM_acct_id,
	   emailprimary	,
        CASE WHEN sth = '2016' THEN '2016-17' WHEN sth = '2017' THEN '2017-18' ELSE NULL END STH,
        CASE WHEN RookieSTH = '2016' THEN '2016-17' WHEN RookieSTH = '2017' THEN '2017-18' ELSE NULL END RookieSTH,
       CASE WHEN MiniPlan = '2016' THEN '2016-17' WHEN MiniPlan = '2017' THEN '2017-18' ELSE NULL END MiniPlan,
       CASE WHEN MicroPlan = '2016' THEN '2016-17' WHEN MicroPlan = '2017' THEN '2017-18' ELSE NULL END MicroPlan,
       CASE WHEN SingleGame = '2016' THEN '2016-17' WHEN SingleGame = '2017' THEN '2017-18' ELSE NULL END SingleGame,
       CASE WHEN Club = '2016' THEN '2016-17' WHEN Club = '2017' THEN '2017-18' ELSE NULL END Club,
       CASE WHEN Suite = '2016' THEN '2016-17' WHEN Suite = '2017' THEN '2017-18' ELSE NULL END Suite,
       CASE WHEN SecondaryBuyer = '2016' THEN '2016-17' WHEN SecondaryBuyer = '2017' THEN '2017-18' ELSE NULL END SecondaryBuyer,
       CASE WHEN SecondaryReseller = '2016' THEN '2016-17' WHEN SecondaryReseller = '2017' THEN '2017-18' ELSE NULL END SecondaryReseller,
       CASE WHEN SecondaryForwarder = '2016' THEN '2016-17' WHEN SecondaryForwarder = '2017' THEN '2017-18' ELSE NULL END SecondaryForwarder,
       CASE WHEN SecondaryReceiver = '2016' THEN '2016-17' WHEN SecondaryReceiver = '2017' THEN '2017-18' ELSE NULL END SecondaryReceiver,
      CASE WHEN BROKER = '2016' THEN '2016-17' WHEN BROKER = '2017' THEN '2017-18' ELSE NULL END  BROKER
	   
--into	ods.Eloqua_Category_Flags_Outbound  
FROM  #maxyears










--TRUNCATE TABLE ods.Eloqua_Category_Flags_Outbound; 


--SELECT DISTINCT ETL__SSID_TM_acct_id
--INTO #STH17
--FROM dbo.factticketsales_v2
--WHERE dimseasonid IN (27,35)
--AND DimTicketTypeId = 2
--AND ETL__SSID_TM_acct_id <> -1;
--CREATE NONCLUSTERED INDEX idx_STH17 on #STH17(ETL__SSID_TM_acct_id);


--SELECT DISTINCT ETL__SSID_TM_acct_id
--INTO  #STH16
--FROM dbo.factticketsales_v2
--WHERE dimseasonid = 10
--AND DimTicketTypeId = 2
--AND ETL__SSID_TM_acct_id <> -1;
--CREATE NONCLUSTERED INDEX idx_STH16 on #STH16(ETL__SSID_TM_acct_id);


--SELECT DISTINCT cs.ETL__SSID_TM_acct_id
--INTO #RookieSTH
--FROM #STH17 cs
--LEFT OUTER JOIN #STH16 ls 
--ON cs.ETL__SSID_TM_acct_id = ls.ETL__SSID_TM_acct_id
--WHERE ls.ETL__SSID_TM_acct_id IS NULL;
--CREATE NONCLUSTERED INDEX idx_RookieSTH on #RookieSTH(ETL__SSID_TM_acct_id);


--INSERT INTO ods.Eloqua_Category_Flags_Outbound
--	SELECT
--	f.ETL__SSID_TM_acct_id
--	,m.emailprimary																	
--	,MAX(CASE WHEN f.dimtickettypeID = 2 THEN 1 ELSE 0 END)							sth								
--	,CASE WHEN COUNT(rs.ETL__SSID_TM_acct_id) > 0 THEN 1 ELSE 0 END 				RookieSTH 		
--	,MAX(CASE WHEN f.dimtickettypeID = 4 THEN 1 ELSE 0 END) 						MiniPlan 		
--	,MAX(CASE WHEN f.dimtickettypeID = 9 THEN 1 ELSE 0 END) 						MicroPlan 		
--	,MAX(CASE WHEN f.dimtickettypeID = 5 THEN 1 ELSE 0 END) 						SingleGame 	
--	,MAX(CASE WHEN f.dimtickettypeID = 8 THEN 1 ELSE 0 END) 						Club
--	,MAX(CASE WHEN f.dimtickettypeID = 10 THEN 1 ELSE 0 END) 						Suite		
--	,MAX(CASE WHEN tex_buyer_receiver.activity = 'ES' THEN 1 ELSE 0 END) 			SecondaryBuyer 	
--	,MAX(CASE WHEN tex_reseller_forwarder.activity = 'ES' THEN 1 ELSE 0 END)        SecondaryReseller 
--	,MAX(CASE WHEN tex_reseller_forwarder.activity IN ('F','X') THEN 1 ELSE 0 END) 	SecondaryForwarder
--	,MAX(CASE WHEN tex_buyer_receiver.activity IN ('F','X') THEN 1 ELSE 0 END)  	SecondaryReceiver 
--	,MAX(CASE WHEN m.accounttype = 'Broker' THEN 1 ELSE 0 END) 						BROKER 			

----		select *
--FROM dbo.FactTicketSales_V2 f WITH (NOLOCK)
--JOIN dbo.DimTicketType_V2 t WITH (NOLOCK)
--	ON t.DimTicketTypeId = f.DimTicketTypeId
--JOIN dbo.vwDimCustomer_ModAcctId m WITH (NOLOCK)
--	ON f.ETL__SSID_TM_acct_id = m.AccountId
--	AND m.SourceSystem = 'TM'
--	AND m.CustomerType = 'Primary'
--LEFT JOIN #RookieSTH RS
--	ON f.ETL__SSID_TM_acct_id = rs.ETL__SSID_TM_acct_id
--LEFT JOIN ods.tm_tex AS tex_buyer_receiver (NOLOCK)
--	ON m.AccountId = tex_buyer_receiver.assoc_acct_id
----	AND m.CustomerType = 'Primary'
----	AND m.SourceSystem = 'TM'
--	AND tex_buyer_receiver.activity IN ('ES','F','X')
--LEFT JOIN ods.tm_tex AS tex_reseller_forwarder (NOLOCK)
--	ON m.AccountId = tex_reseller_forwarder.acct_id
----	AND m.CustomerType = 'Primary'
----	AND m.SourceSystem = 'TM'
--	AND tex_reseller_forwarder.activity IN ('ES','F','X')

--/*
--LEFT JOIN ods.tm_tex tex_forwarder WITH (NOLOCK)
--	ON m.AccountId = tex_forwarder.acct_id AND m.CustomerType = 'Primary' AND m.SourceSystem = 'TM' AND tex_forwarder.activity IN ('F','X')
--LEFT JOIN ods.tm_tex tex_receiver WITH (NOLOCK)
--	ON m.AccountId = tex_receiver.assoc_acct_id AND m.CustomerType = 'Primary' AND m.SourceSystem = 'TM' AND tex_receiver.activity IN ('F','X')
--*/

--WHERE f.ETL__SSID_TM_acct_id <> -1
--AND ISNULL(m.EmailPrimary,'')<>''
--AND f.DimSeasonId IN (27,10,35)
--GROUP BY f.ETL__SSID_TM_acct_id,m.EmailPrimary



END

GO
