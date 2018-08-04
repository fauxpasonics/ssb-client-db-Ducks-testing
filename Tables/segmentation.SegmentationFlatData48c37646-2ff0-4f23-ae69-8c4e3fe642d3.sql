CREATE TABLE [segmentation].[SegmentationFlatData48c37646-2ff0-4f23-ae69-8c4e3fe642d3]
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
ALTER TABLE [segmentation].[SegmentationFlatData48c37646-2ff0-4f23-ae69-8c4e3fe642d3] ADD CONSTRAINT [pk_SegmentationFlatData48c37646-2ff0-4f23-ae69-8c4e3fe642d3] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData48c37646-2ff0-4f23-ae69-8c4e3fe642d3] ON [segmentation].[SegmentationFlatData48c37646-2ff0-4f23-ae69-8c4e3fe642d3] ([_rn])
GO
