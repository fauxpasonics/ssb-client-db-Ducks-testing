CREATE TABLE [stg].[SkiData_DailyPointLedger]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_D__ETL_C__2FFACE6A] DEFAULT (getdate()),
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Username] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InitialPoints] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointsEarned] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointsBalance] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnnualSuite] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnnualClub] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Premium] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeasonTicketHolders] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActivityDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[SkiData_DailyPointLedger] ADD CONSTRAINT [PK__SkiData___7EF6BFCDCF3FA73B] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
