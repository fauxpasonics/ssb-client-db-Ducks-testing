CREATE TABLE [segmentation].[SegmentationFlatDataaa6ed8a5-5adb-4f36-8005-d201a5850cf7]
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
ALTER TABLE [segmentation].[SegmentationFlatDataaa6ed8a5-5adb-4f36-8005-d201a5850cf7] ADD CONSTRAINT [pk_SegmentationFlatDataaa6ed8a5-5adb-4f36-8005-d201a5850cf7] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatDataaa6ed8a5-5adb-4f36-8005-d201a5850cf7] ON [segmentation].[SegmentationFlatDataaa6ed8a5-5adb-4f36-8005-d201a5850cf7] ([_rn])
GO
