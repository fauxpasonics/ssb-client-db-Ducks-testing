CREATE TABLE [stg].[SkiData_DucksDollars]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_D__ETL_C__2859ACA2] DEFAULT (getdate()),
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LRSUserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RewardTitle] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QuantityRedeemed] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InitialBalance] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentBalance] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BalanceSpent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPointsEarned] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointsRemaining] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPointsSpent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnnualClub] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnnualSuite] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Premium] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[SkiData_DucksDollars] ADD CONSTRAINT [PK__SkiData___7EF6BFCD2A32CCBB] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
