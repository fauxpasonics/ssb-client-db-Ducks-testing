CREATE TABLE [segmentation].[SegmentationFlatDataa33fed4b-68f7-4177-b73e-a5c25ecfebd6]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (14) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contactid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdon] [datetime] NULL,
[createdbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedon] [datetime] NULL,
[modifiedby] [uniqueidentifier] NULL,
[owneridname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatDataa33fed4b-68f7-4177-b73e-a5c25ecfebd6] ADD CONSTRAINT [pk_SegmentationFlatDataa33fed4b-68f7-4177-b73e-a5c25ecfebd6] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatDataa33fed4b-68f7-4177-b73e-a5c25ecfebd6] ON [segmentation].[SegmentationFlatDataa33fed4b-68f7-4177-b73e-a5c25ecfebd6] ([_rn])
GO
