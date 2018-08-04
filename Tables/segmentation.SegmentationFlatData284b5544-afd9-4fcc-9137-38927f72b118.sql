CREATE TABLE [segmentation].[SegmentationFlatData284b5544-afd9-4fcc-9137-38927f72b118]
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
ALTER TABLE [segmentation].[SegmentationFlatData284b5544-afd9-4fcc-9137-38927f72b118] ADD CONSTRAINT [pk_SegmentationFlatData284b5544-afd9-4fcc-9137-38927f72b118] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData284b5544-afd9-4fcc-9137-38927f72b118] ON [segmentation].[SegmentationFlatData284b5544-afd9-4fcc-9137-38927f72b118] ([_rn])
GO
