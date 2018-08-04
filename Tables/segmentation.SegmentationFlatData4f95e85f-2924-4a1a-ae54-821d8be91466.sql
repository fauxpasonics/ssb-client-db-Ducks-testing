CREATE TABLE [segmentation].[SegmentationFlatData4f95e85f-2924-4a1a-ae54-821d8be91466]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CustomerSourceSystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatData4f95e85f-2924-4a1a-ae54-821d8be91466] ADD CONSTRAINT [pk_SegmentationFlatData4f95e85f-2924-4a1a-ae54-821d8be91466] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData4f95e85f-2924-4a1a-ae54-821d8be91466] ON [segmentation].[SegmentationFlatData4f95e85f-2924-4a1a-ae54-821d8be91466] ([_rn])
GO
