CREATE TABLE [segmentation].[SegmentationFlatDataf6170306-0ee3-4d9c-889d-0d0fd9b6fe88]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (19) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_ID] [bigint] NOT NULL,
[CTR_Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_CreatedAt] [datetime] NULL,
[CTR_Type] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_AssetId] [int] NULL,
[CTR_AssetName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_AssetType] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_ContactId] [int] NULL,
[CTR_EmailClickedThruLink] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_EmailName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_EmailWebLink] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_SubjectLine] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_EmailRecipientId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_EmailAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CTR_CampaignId] [int] NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatDataf6170306-0ee3-4d9c-889d-0d0fd9b6fe88] ADD CONSTRAINT [pk_SegmentationFlatDataf6170306-0ee3-4d9c-889d-0d0fd9b6fe88] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatDataf6170306-0ee3-4d9c-889d-0d0fd9b6fe88] ON [segmentation].[SegmentationFlatDataf6170306-0ee3-4d9c-889d-0d0fd9b6fe88] ([_rn])
GO
