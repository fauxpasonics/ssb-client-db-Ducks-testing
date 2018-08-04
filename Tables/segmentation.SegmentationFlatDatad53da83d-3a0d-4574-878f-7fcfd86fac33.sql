CREATE TABLE [segmentation].[SegmentationFlatDatad53da83d-3a0d-4574-878f-7fcfd86fac33]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PV_ID] [bigint] NOT NULL,
[PV_CreatedAt] [datetime] NULL,
[PV_Type] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PV_ContactId] [int] NULL,
[PV_IPAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PV_Url] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PV_CampaignId] [int] NULL,
[PV_ReferrerUrl] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PV_VisitorId] [int] NULL,
[PV_VisitorExternalId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PV_WebVisitId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PV_IsWebTrackingOptedIn] [bit] NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatDatad53da83d-3a0d-4574-878f-7fcfd86fac33] ADD CONSTRAINT [pk_SegmentationFlatDatad53da83d-3a0d-4574-878f-7fcfd86fac33] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatDatad53da83d-3a0d-4574-878f-7fcfd86fac33] ON [segmentation].[SegmentationFlatDatad53da83d-3a0d-4574-878f-7fcfd86fac33] ([_rn])
GO
