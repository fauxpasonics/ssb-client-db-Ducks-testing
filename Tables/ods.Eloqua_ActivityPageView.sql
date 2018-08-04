CREATE TABLE [ods].[Eloqua_ActivityPageView]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_C__793DFFAF] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_U__7A3223E8] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Ac__ETL_I__7B264821] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [bigint] NOT NULL,
[CreatedAt] [datetime] NULL,
[Type] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContactId] [int] NULL,
[IPAddress] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Url] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampaignId] [int] NULL,
[ReferrerUrl] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VisitorId] [int] NULL,
[VisitorExternalId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WebVisitId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsWebTrackingOptedIn] [bit] NULL
)
GO
ALTER TABLE [ods].[Eloqua_ActivityPageView] ADD CONSTRAINT [PK__Eloqua_A__3214EC2708F274DF] PRIMARY KEY CLUSTERED  ([ID])
GO
CREATE NONCLUSTERED INDEX [IDX_EloquaPageView_ContactID] ON [ods].[Eloqua_ActivityPageView] ([ContactId]) INCLUDE ([CampaignId], [CreatedAt], [ID], [IPAddress], [IsWebTrackingOptedIn], [ReferrerUrl], [Type], [Url], [VisitorExternalId], [VisitorId], [WebVisitId])
GO
