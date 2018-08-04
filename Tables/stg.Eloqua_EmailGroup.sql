CREATE TABLE [stg].[Eloqua_EmailGroup]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Em__ETL_C__1A9EF37A] DEFAULT (getdate()),
[ID] [int] NOT NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailFooterId] [int] NULL,
[IsVisibleInOutlookPlugin] [bit] NULL,
[IsVisibleInPublicSubscriptionList] [bit] NULL,
[SubscriptionLandingPageId] [int] NULL,
[SubscriptionListId] [int] NULL,
[UnsubscriptionLandingPageId] [int] NULL,
[UnsubscriptionListId] [int] NULL,
[UnsubscriptionListDataLookupId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FolderId] [int] NULL,
[Permissions] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedAt] [datetime] NULL,
[CreatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccessedAt] [datetime] NULL,
[CurrentStatus] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Depth] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedAt] [datetime] NULL,
[UpdatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
