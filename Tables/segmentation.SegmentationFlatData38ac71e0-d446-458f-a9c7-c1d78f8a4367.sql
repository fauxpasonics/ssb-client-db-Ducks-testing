CREATE TABLE [segmentation].[SegmentationFlatData38ac71e0-d446-458f-a9c7-c1d78f8a4367]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FS_ID] [bigint] NOT NULL,
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
ALTER TABLE [segmentation].[SegmentationFlatData38ac71e0-d446-458f-a9c7-c1d78f8a4367] ADD CONSTRAINT [pk_SegmentationFlatData38ac71e0-d446-458f-a9c7-c1d78f8a4367] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData38ac71e0-d446-458f-a9c7-c1d78f8a4367] ON [segmentation].[SegmentationFlatData38ac71e0-d446-458f-a9c7-c1d78f8a4367] ([_rn])
GO
