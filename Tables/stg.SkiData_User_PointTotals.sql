CREATE TABLE [stg].[SkiData_User_PointTotals]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_C__25B24A21] DEFAULT (getdate()),
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserPointsId] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserId] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPointsEarned] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPointsSpent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeasonPoints] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointsRemaining] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPremium] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[SkiData_User_PointTotals] ADD CONSTRAINT [PK__SkiData___7EF6BFCD2FC531EC] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
