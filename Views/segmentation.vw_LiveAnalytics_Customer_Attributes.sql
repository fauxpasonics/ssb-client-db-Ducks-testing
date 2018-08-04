SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



 CREATE VIEW [segmentation].[vw_LiveAnalytics_Customer_Attributes] AS
 

 SELECT m.SSB_CRMSYSTEM_CONTACT_ID
			,c.ult_party_id
			,c.acct_id
			,c.cust_source_cd
			,b.la_id
			,c.cust_first_nm
			,c.cust_middle_nm
			,c.cust_last_nm
			,c.cust_addr_line_1
			,c.cust_addr_line_2
			,c.cust_city_nm
			,c.cust_state_nm
			,c.cust_postal_cd
			,c.cust_ctry_nm
			,c.cust_phn_num_1
			,c.cust_phn_num_2
			,c.cust_email_addr
			,c.adult_hh_num
			,c.presence_chldn_new_flg
			,c.marital_status_hh_cd
			,c.income_est_hh_cd
			,c.net_worth_gold_cd
			,c.discretionary_income_index_cd
			,c.psx_classic_clus_cd
			,c.psx_group_id
			,c.e3_events_cnt
			,c.e3_tkt_qty_avg
			,c.e3_spend_total
			,c.e3_spend_per_event
			,c.e3_tran_platinum_ind
			,c.e3_dist_to_ven
			,c.RFM_grade
			,s.model_confidence
			,s.model_01_score
			,s.model_01_grade
			,s.model_02_score
			,s.model_02_grade
			,s.model_03_score
			,s.model_03_grade
			,m.EmailPrimary
			,c.client_walkup_buyer_ind
			,MAX(t.event_dt) AS MostRecentEventPurchase
			,MAX(sale_dt) AS MostRecentPurchaseDate
			,SUM(CAST(tran_amt AS DECIMAL (18,2))) AS TotalSpend
			,x.prmy_atrcn_nm AS EventName

--INTO #tmp


 FROM dbo.vwDimCustomer_ModAcctId m
 JOIN ods.LiveAnalytics_Customer c
 ON c.ult_party_id = m.SSID 
 JOIN ods.LiveAnalytics_Score s
 ON s.ult_party_id = m.SSID
 JOIN ods.LiveAnalytics_Behavior b
 ON b.ult_party_id = m.SSID
 JOIN ods.LiveAnalytics_Transaction t
 ON t.ult_party_id = m.SSID
 JOIN (SELECT ult_party_id,
			  prmy_atrcn_nm,
			  event_dt,
			  ROW_NUMBER() OVER (PARTITION BY ult_party_id ORDER BY event_dt DESC)EventRank
			  FROM ods.LiveAnalytics_Transaction )x
ON x.ult_party_ID = m.ssid
 WHERE m.SourceSystem = 'LiveAnalytics'
 AND x.eventRank = 1
 GROUP BY m.SSB_CRMSYSTEM_CONTACT_ID
			,c.ult_party_id
			,c.acct_id
			,c.cust_source_cd
			,b.la_id
			,c.cust_first_nm
			,c.cust_middle_nm
			,c.cust_last_nm
			,c.cust_addr_line_1
			,c.cust_addr_line_2
			,c.cust_city_nm
			,c.cust_state_nm
			,c.cust_postal_cd
			,c.cust_ctry_nm
			,c.cust_phn_num_1
			,c.cust_phn_num_2
			,c.cust_email_addr
			,c.adult_hh_num
			,c.presence_chldn_new_flg
			,c.marital_status_hh_cd
			,c.income_est_hh_cd
			,c.net_worth_gold_cd
			,c.discretionary_income_index_cd
			,c.psx_classic_clus_cd
			,c.psx_group_id
			,c.e3_events_cnt
			,c.e3_tkt_qty_avg
			,c.e3_spend_total
			,c.e3_spend_per_event
			,c.e3_tran_platinum_ind
			,c.e3_dist_to_ven
			,c.RFM_grade
			,s.model_confidence
			,s.model_01_score
			,s.model_01_grade
			,s.model_02_score
			,s.model_02_grade
			,s.model_03_score
			,s.model_03_grade
			,m.EmailPrimary
			,x.prmy_atrcn_nm 
			,c.client_walkup_buyer_ind

GO
