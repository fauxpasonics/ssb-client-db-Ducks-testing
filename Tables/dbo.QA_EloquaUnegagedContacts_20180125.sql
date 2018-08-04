CREATE TABLE [dbo].[QA_EloquaUnegagedContacts_20180125]
(
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsBounceback] [bit] NULL,
[IsSubscribed] [bit] NULL,
[SubscriptionDate] [datetime] NULL,
[UnsubscriptionDate] [datetime] NULL,
[CreatedAt] [datetime] NULL,
[CreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedAt] [datetime] NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IncludedinEloquaSegment] [int] NOT NULL,
[LastEmailSentDate_TwoYears] [datetime] NULL,
[CountEmailsSent_TwoYears] [int] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
