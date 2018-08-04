CREATE TABLE [ods].[SkiData_DucksDollars]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_D__ETL_C__2B36194D] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_D__ETL_U__2C2A3D86] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_D__ETL_I__2D1E61BF] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LRSUserID] [int] NULL,
[TicketAccountID] [int] NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RewardTitle] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[QuantityRedeemed] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InitialBalance] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentBalance] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BalanceSpent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPointsEarned] [int] NULL,
[PointsRemaining] [int] NULL,
[TotalPointsSpent] [int] NULL,
[AnnualClub] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnnualSuite] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Premium] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[SkiData_DucksDollars] ADD CONSTRAINT [PK__SkiData___7EF6BFCD5E42DCCB] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
