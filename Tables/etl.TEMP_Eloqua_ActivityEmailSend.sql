CREATE TABLE [etl].[TEMP_Eloqua_ActivityEmailSend]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL,
[ETL_UpdatedDate] [datetime] NOT NULL,
[ETL_IsDeleted] [bit] NOT NULL,
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [bigint] NOT NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedAt] [datetime] NULL,
[Type] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AssetType] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactId] [bigint] NOT NULL,
[EmailName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailWebLink] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailRecipientId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubjectLine] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [etl].[TEMP_Eloqua_ActivityEmailSend] ADD CONSTRAINT [PK__TEMP_Elo__7EF6BFCDDF96FE4D] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
CREATE NONCLUSTERED INDEX [IX_Key] ON [etl].[TEMP_Eloqua_ActivityEmailSend] ([ID]) INCLUDE ([ETL_DeltaHashKey])
GO
