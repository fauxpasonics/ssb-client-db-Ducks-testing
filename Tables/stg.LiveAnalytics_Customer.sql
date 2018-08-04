CREATE TABLE [stg].[LiveAnalytics_Customer]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_C__7ECD872A] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ult_party_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[acct_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_source_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[la_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_first_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_middle_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_last_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_addr_line_1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_addr_line_2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_city_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_state_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_postal_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_ctry_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_phn_num_1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_phn_num_2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_email_addr] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[livea_match_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first_indv_first_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first_indv_md_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[second_indv_first_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[second_indv_md_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gndr_input_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gndr_1st_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gndr_2nd_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age_two_yr_incr_input_indv] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age_two_yr_incr_1st_indv] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age_two_yr_incr_2nd_indv] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[race_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[adult_hh_num] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[presence_chldn_new_flg] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[marital_status_hh_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_18_24_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_18_24_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_18_24_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_25_34_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_25_34_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_25_34_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_35_44_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_35_44_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_35_44_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_45_54_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_45_54_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_45_54_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_55_64_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_55_64_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_55_64_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_65_74_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_65_74_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_65_74_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_75_plus_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_75_plus_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_75_plus_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_00_02_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_00_02_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_00_02_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_03_05_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_03_05_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_03_05_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_06_10_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_06_10_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_06_10_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_11_15_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_11_15_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_11_15_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_male_16_17_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_female_16_17_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hh_unk_16_17_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[len_of_resdnc_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dwlng_type_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[suprs_mail_dma_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[occpn_input_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[occpn_1st_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[occpn_2nd_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[wrk_wmn_hh_flg] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[income_est_hh_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[est_hh_inc_higher_ranges_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[est_hh_inc_narrow_ranges_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[est_hh_inc_cd_100pct_inc_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[est_hh_inc_cd_100pct_prec_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[net_worth_gold_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[discretionary_income_index_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[financial_pct_score] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bank_card_hldr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gas_dept_retail_card_hldr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[travel_ent_card_hldr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[credit_card_unk_type_hld_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prem_card_hldr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[upscale_dept_str_card_hldr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pmt_visa_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pmt_mc_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pmt_amex_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pmt_disc_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pmt_other_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[edu_input_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[edu_1st_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[edu_2nd_indv_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mail_ord_buyer_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mail_ord_respndr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[mail_ord_donor_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_theatre_perf_arts_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_arts_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_travel_domestic_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_home_stereo_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_music_player_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_music_avid_lstnr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_music_clctr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_movie_clctr_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_auto_motor_racing_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_footb_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_baseb_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_bsktb_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_hockey_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_soccer_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_spectator_sport_tennis_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_swpstake_contest_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_sports_grp_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_music_grp_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_nascar_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_upscale_living_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[int_cultural_living_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_truck_owner_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_mtrcyc_owner_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_rv_owner_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_known_owned_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[veh_dominant_lifestyle_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[psx_classic_clus_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[psx_group_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[psx_classic_prec_lvl_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_avg_hh_income] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_median_hh_income] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_disposable_inc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_discretionary_inc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_tot_spend] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_ent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_ent_movie] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_ent_livesports] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_ent_livearts] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_ent_museum] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_ent_cablesat] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_equip_sport] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_equip_toy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_equip_videogame] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_equip_artist] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_equip_computer] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_photography] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_rec_vehicle] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ca_hs_rec_home_ent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prizm_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prizm_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prizmsg_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prizmsg_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prizmls_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prizmls_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[msa_cma_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_to_client_ven_mi] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dist_to_client_ven_km] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[brkr_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_sale_dt_max] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_event_dt_max] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_events_cnt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tkt_qty_avg] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_total] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_per_event] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tkt_price_avg] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tkt_price_min] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tkt_price_max] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_txpr_pctile] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tran_platinum_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tran_type_primary_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tran_type_resale_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ancil_parking_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_ancil_upsell_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grp_buyer_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dist_to_ven] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dist_to_ven_local] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dist_201_plus_miles_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_pe_m_concerts] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_pe_m_arts] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_pe_m_sports] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_pe_m_family] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_pe_m_misc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_sow_m_concerts] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_sow_m_arts] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_sow_m_sports] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_sow_m_family] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_sow_m_misc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_tkt_qty_01_02] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_tkt_qty_03_04] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_tkt_qty_05_08] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_tkt_qty_09_plus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_001_025] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_026_050] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_051_100] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_101_200] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_201_plus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_pctile_00_25] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_pctile_25_49] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_pctile_50_74] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_pctile_75_89] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_txpr_pctile_90_100] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_purch_pd_presale] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_purch_pd_onsale] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_purch_pd_firstweek] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_purch_pd_inbetween] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_purch_pd_finalweek] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_channel_internet] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_channel_phone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_channel_mobile] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_channel_box] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_pref_channel_outlet] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[rfm_score] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[rfm_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_101] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_102] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_103] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_104] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_105] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_106] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_107] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_108] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_109] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_110] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_111] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_199] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_201] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_202] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_203] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_204] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_205] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_206] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_207] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_299] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_301] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_302] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_399] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_401] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_402] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_403] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_410] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_412] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_420] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_423] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_430] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_432] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_440] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_442] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_450] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_460] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_470] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_480] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_491] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[propn_score_minor_499] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_event_cnt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_sp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_sale_dt_min] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_sale_dt_max] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_pe_tkt_cnt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_pe_sp] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price_max] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_tkt_price_min] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_walkup_buyer_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[LiveAnalytics_Customer] ADD CONSTRAINT [PK__LiveAnal__7EF6BFCDF959287D] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
