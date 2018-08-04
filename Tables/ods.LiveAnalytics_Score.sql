CREATE TABLE [ods].[LiveAnalytics_Score]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_C__477D5240] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_U__48717679] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_I__49659AB2] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ult_party_id] [bigint] NOT NULL,
[acct_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_source_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[la_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_confidence] [int] NULL,
[model_01_score] [int] NULL,
[model_01_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_02_score] [int] NULL,
[model_02_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_03_score] [int] NULL,
[model_03_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[LiveAnalytics_Score] ADD CONSTRAINT [PK__LiveAnal__7EF6BFCD04C45650] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
