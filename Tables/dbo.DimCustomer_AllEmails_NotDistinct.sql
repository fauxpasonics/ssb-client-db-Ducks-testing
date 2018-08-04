CREATE TABLE [dbo].[DimCustomer_AllEmails_NotDistinct]
(
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DimCustomerId] [int] NOT NULL,
[SourceSystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SSID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Prefix] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Suffix] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FullName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NameDirtyHash] [binary] (32) NULL,
[NameIsCleanStatus] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailDirtyHash] [binary] (32) NULL,
[EmailIsCleanStatus] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailType] [varchar] (12) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
CREATE CLUSTERED INDEX [ix_DC_AE_DimCustID_EType_EHash] ON [dbo].[DimCustomer_AllEmails_NotDistinct] ([DimCustomerId], [EmailType], [EmailDirtyHash])
GO
