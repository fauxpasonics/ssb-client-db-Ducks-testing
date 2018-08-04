CREATE TABLE [segmentation].[SegmentationFlatData16eae463-98ac-424c-862f-2195559a4dc9]
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
ALTER TABLE [segmentation].[SegmentationFlatData16eae463-98ac-424c-862f-2195559a4dc9] ADD CONSTRAINT [pk_SegmentationFlatData16eae463-98ac-424c-862f-2195559a4dc9] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData16eae463-98ac-424c-862f-2195559a4dc9] ON [segmentation].[SegmentationFlatData16eae463-98ac-424c-862f-2195559a4dc9] ([_rn])
GO
