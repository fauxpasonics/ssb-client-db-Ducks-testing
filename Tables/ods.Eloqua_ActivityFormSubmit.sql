CREATE TABLE [ods].[Eloqua_ActivityFormSubmit]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_C__719CDDE7] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_U__72910220] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_I__73852659] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ID] [bigint] NOT NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedAt] [datetime] NULL,
[Type] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetId] [int] NULL,
[AssetType] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactId] [int] NULL,
[Collection] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormData] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RawData] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignId] [int] NULL
)
GO
ALTER TABLE [ods].[Eloqua_ActivityFormSubmit] ADD CONSTRAINT [PK__Eloqua_A__3214EC27C0B5072B] PRIMARY KEY CLUSTERED  ([ID])
GO
