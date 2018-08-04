CREATE TABLE [segmentation].[SegmentationFlatData4c72a44d-51af-4895-914d-dbde6859f0cf]
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
ALTER TABLE [segmentation].[SegmentationFlatData4c72a44d-51af-4895-914d-dbde6859f0cf] ADD CONSTRAINT [pk_SegmentationFlatData4c72a44d-51af-4895-914d-dbde6859f0cf] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData4c72a44d-51af-4895-914d-dbde6859f0cf] ON [segmentation].[SegmentationFlatData4c72a44d-51af-4895-914d-dbde6859f0cf] ([_rn])
GO
