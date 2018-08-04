CREATE TABLE [ods].[Eloqua_ActivityCampaignMembership]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_C__47A6A41B] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_U__489AC854] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_I__498EEC8D] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [int] NOT NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedAt] [datetime] NULL,
[Type] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetId] [int] NULL,
[AssetType] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactId] [int] NULL,
[Responded] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LeadStage] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignId] [int] NULL
)
GO
ALTER TABLE [ods].[Eloqua_ActivityCampaignMembership] ADD CONSTRAINT [PK__Eloqua_A__3214EC270DAB8AC3] PRIMARY KEY CLUSTERED  ([ID])
GO
