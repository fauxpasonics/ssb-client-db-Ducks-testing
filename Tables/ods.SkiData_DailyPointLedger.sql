CREATE TABLE [ods].[SkiData_DailyPointLedger]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_D__ETL_C__32D73B15] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_D__ETL_U__33CB5F4E] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_D__ETL_I__34BF8387] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [int] NULL,
[TicketAccountID] [int] NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Username] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InitialPoints] [int] NULL,
[PointsEarned] [int] NULL,
[PointsBalance] [int] NULL,
[AnnualSuite] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnnualClub] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Premium] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeasonTicketHolders] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActivityDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[SkiData_DailyPointLedger] ADD CONSTRAINT [PK__SkiData___7EF6BFCD1BFA038D] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
