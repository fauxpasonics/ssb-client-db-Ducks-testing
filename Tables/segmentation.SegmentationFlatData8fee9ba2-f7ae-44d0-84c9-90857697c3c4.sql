CREATE TABLE [segmentation].[SegmentationFlatData8fee9ba2-f7ae-44d0-84c9-90857697c3c4]
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
ALTER TABLE [segmentation].[SegmentationFlatData8fee9ba2-f7ae-44d0-84c9-90857697c3c4] ADD CONSTRAINT [pk_SegmentationFlatData8fee9ba2-f7ae-44d0-84c9-90857697c3c4] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData8fee9ba2-f7ae-44d0-84c9-90857697c3c4] ON [segmentation].[SegmentationFlatData8fee9ba2-f7ae-44d0-84c9-90857697c3c4] ([_rn])
GO
