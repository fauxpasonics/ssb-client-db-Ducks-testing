CREATE TABLE [segmentation].[SegmentationFlatData956d2248-6fce-4691-842d-92c9b39e47ca]
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
ALTER TABLE [segmentation].[SegmentationFlatData956d2248-6fce-4691-842d-92c9b39e47ca] ADD CONSTRAINT [pk_SegmentationFlatData956d2248-6fce-4691-842d-92c9b39e47ca] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData956d2248-6fce-4691-842d-92c9b39e47ca] ON [segmentation].[SegmentationFlatData956d2248-6fce-4691-842d-92c9b39e47ca] ([_rn])
GO
