CREATE TABLE [ods].[SkiData_Users]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_C__1176474A] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_U__126A6B83] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_I__135E8FBC] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [int] NULL,
[UserID] [int] NULL,
[Username] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeletedUser] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedOnDate] [datetime] NULL,
[LastModifiedOnDate] [datetime] NULL,
[Authorised] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DeletedFromSite] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSTH] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPremium] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastLoginDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[SkiData_Users] ADD CONSTRAINT [PK__SkiData___7EF6BFCDD2FAE287] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
