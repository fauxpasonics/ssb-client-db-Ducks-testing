CREATE TABLE [stg].[LiveAnalytics_Transaction]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_C__744FF8B7] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ult_party_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[party_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[acct_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[la_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[avs_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_id_hex] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_dt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[onsale_dt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sale_dt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tran_amt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pmt_submethod_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[host_sys_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ovrrd_tran_opr_type_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[major_cat_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[major_cat_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[minor_cat_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[minor_cat_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prmy_atrcn_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prmy_atrcn_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[secondary_atrcn_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[secondary_atrcn_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ven_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ven_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ven_city_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ven_state_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ven_postal_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ven_ctry_nm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[LiveAnalytics_Transaction] ADD CONSTRAINT [PK__LiveAnal__7EF6BFCDACBA84A9] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
