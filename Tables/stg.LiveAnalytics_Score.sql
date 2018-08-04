CREATE TABLE [stg].[LiveAnalytics_Score]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__LiveAnaly__ETL_C__4D362B96] DEFAULT (getdate()),
[ETL_FileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ult_party_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[acct_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cust_source_cd] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[la_id] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_confidence] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_01_score] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_01_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_02_score] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_02_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_03_score] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[model_03_grade] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[LiveAnalytics_Score] ADD CONSTRAINT [PK__LiveAnal__7EF6BFCD182A4BDA] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
