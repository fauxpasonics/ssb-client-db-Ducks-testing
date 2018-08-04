CREATE TABLE [stg].[SkiData_Users]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_C__0E99DA9F] DEFAULT (getdate()),
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Username] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeletedUser] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedOnDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastModifiedOnDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Authorised] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeletedFromSite] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSTH] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPremium] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastLoginDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[SkiData_Users] ADD CONSTRAINT [PK__SkiData___7EF6BFCD26ED28E8] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
