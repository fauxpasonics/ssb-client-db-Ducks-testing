CREATE TABLE [segmentation].[SegmentationFlatData831dc5d3-2ee1-4738-b019-12307041aeb5]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotbulkemail] [bit] NULL,
[donotbulkpostalmail] [bit] NULL,
[donotemail] [bit] NULL,
[donotfax] [bit] NULL,
[donotphone] [bit] NULL,
[donotpostalmail] [bit] NULL,
[donotsendmm] [bit] NULL,
[owneridname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[createdbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifiedbyname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[opendeals_date] [datetime] NULL,
[str_source] [datetime] NULL,
[str_partnersalespersonname] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatData831dc5d3-2ee1-4738-b019-12307041aeb5] ADD CONSTRAINT [pk_SegmentationFlatData831dc5d3-2ee1-4738-b019-12307041aeb5] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData831dc5d3-2ee1-4738-b019-12307041aeb5] ON [segmentation].[SegmentationFlatData831dc5d3-2ee1-4738-b019-12307041aeb5] ([_rn])
GO
