CREATE TABLE [segmentation].[SegmentationFlatData6a72a9c1-a705-41fa-b57c-d135d4a4755a]
(
[id] [uniqueidentifier] NULL,
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
[str_lastactivitydate] [datetime] NULL,
[str_openactivitycount] [int] NULL,
[str_openticketopportunity] [bit] NULL,
[str_oppdaysinstage] [int] NULL,
[str_oppproduct] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_oppsource] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_oppstage] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_source] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
