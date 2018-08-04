CREATE TABLE [segmentation].[SegmentationFlatData78483035-7775-4201-b064-c6a058415d3b]
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
ALTER TABLE [segmentation].[SegmentationFlatData78483035-7775-4201-b064-c6a058415d3b] ADD CONSTRAINT [pk_SegmentationFlatData78483035-7775-4201-b064-c6a058415d3b] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData78483035-7775-4201-b064-c6a058415d3b] ON [segmentation].[SegmentationFlatData78483035-7775-4201-b064-c6a058415d3b] ([_rn])
GO
