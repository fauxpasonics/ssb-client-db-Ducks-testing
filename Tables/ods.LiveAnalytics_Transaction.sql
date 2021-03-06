CREATE TABLE [ods].[LiveAnalytics_Transaction]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_C__6F8B439A] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_U__707F67D3] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_I__71738C0C] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ult_party_id] [bigint] NULL,
[party_id] [bigint] NULL,
[acct_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[la_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[avs_id] [bigint] NULL,
[event_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_id_hex] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[event_dt] [date] NULL,
[onsale_dt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sale_dt] [date] NULL,
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
ALTER TABLE [ods].[LiveAnalytics_Transaction] ADD CONSTRAINT [PK__LiveAnal__7EF6BFCD5A0FAC0A] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
