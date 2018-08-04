CREATE TABLE [segmentation].[SegmentationFlatDataf6b377c7-dcd6-43b4-92b4-5417e61f66a3]
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
ALTER TABLE [segmentation].[SegmentationFlatDataf6b377c7-dcd6-43b4-92b4-5417e61f66a3] ADD CONSTRAINT [pk_SegmentationFlatDataf6b377c7-dcd6-43b4-92b4-5417e61f66a3] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatDataf6b377c7-dcd6-43b4-92b4-5417e61f66a3] ON [segmentation].[SegmentationFlatDataf6b377c7-dcd6-43b4-92b4-5417e61f66a3] ([_rn])
GO
