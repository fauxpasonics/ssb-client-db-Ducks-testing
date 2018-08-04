CREATE TABLE [segmentation].[SegmentationFlatData7c0e6a85-5be7-42dc-99e7-8531ee01f86c]
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
ALTER TABLE [segmentation].[SegmentationFlatData7c0e6a85-5be7-42dc-99e7-8531ee01f86c] ADD CONSTRAINT [pk_SegmentationFlatData7c0e6a85-5be7-42dc-99e7-8531ee01f86c] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData7c0e6a85-5be7-42dc-99e7-8531ee01f86c] ON [segmentation].[SegmentationFlatData7c0e6a85-5be7-42dc-99e7-8531ee01f86c] ([_rn])
GO
