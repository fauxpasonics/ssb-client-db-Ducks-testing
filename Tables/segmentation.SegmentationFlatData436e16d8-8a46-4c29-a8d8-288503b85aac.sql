CREATE TABLE [segmentation].[SegmentationFlatData436e16d8-8a46-4c29-a8d8-288503b85aac]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ult_party_id] [bigint] NULL,
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
[adult_hh_num] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[presence_chldn_new_flg] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[marital_status_hh_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[income_est_hh_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[net_worth_gold_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[discretionary_income_index_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[psx_classic_clus_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[psx_group_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_events_cnt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tkt_qty_avg] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_total] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_spend_per_event] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_tran_platinum_ind] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[e3_dist_to_ven] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RFM_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_confidence] [int] NULL,
[model_01_score] [int] NULL,
[model_01_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_02_score] [int] NULL,
[model_02_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_03_score] [int] NULL,
[model_03_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailPrimary] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MostRecentEventPurchase] [date] NULL,
[MostRecentPurchaseDate] [date] NULL,
[TotalSpend] [decimal] (38, 2) NULL,
[EventName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatData436e16d8-8a46-4c29-a8d8-288503b85aac] ADD CONSTRAINT [pk_SegmentationFlatData436e16d8-8a46-4c29-a8d8-288503b85aac] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData436e16d8-8a46-4c29-a8d8-288503b85aac] ON [segmentation].[SegmentationFlatData436e16d8-8a46-4c29-a8d8-288503b85aac] ([_rn])
GO
