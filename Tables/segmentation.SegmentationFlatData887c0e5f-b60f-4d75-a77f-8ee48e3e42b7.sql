CREATE TABLE [segmentation].[SegmentationFlatData887c0e5f-b60f-4d75-a77f-8ee48e3e42b7]
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
ALTER TABLE [segmentation].[SegmentationFlatData887c0e5f-b60f-4d75-a77f-8ee48e3e42b7] ADD CONSTRAINT [pk_SegmentationFlatData887c0e5f-b60f-4d75-a77f-8ee48e3e42b7] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData887c0e5f-b60f-4d75-a77f-8ee48e3e42b7] ON [segmentation].[SegmentationFlatData887c0e5f-b60f-4d75-a77f-8ee48e3e42b7] ([_rn])
GO
