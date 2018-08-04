CREATE TABLE [segmentation].[SegmentationFlatData0108bcb5-643e-4939-959b-375bed5da091]
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
ALTER TABLE [segmentation].[SegmentationFlatData0108bcb5-643e-4939-959b-375bed5da091] ADD CONSTRAINT [pk_SegmentationFlatData0108bcb5-643e-4939-959b-375bed5da091] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData0108bcb5-643e-4939-959b-375bed5da091] ON [segmentation].[SegmentationFlatData0108bcb5-643e-4939-959b-375bed5da091] ([_rn])
GO
