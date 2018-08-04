CREATE TABLE [ods].[SkiData_User_PointTotals]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_C__288EB6CC] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_U__2982DB05] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_I__2A76FF3E] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserPointsId] [int] NULL,
[UserId] [int] NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPointsEarned] [int] NULL,
[TotalPointsSpent] [int] NULL,
[SeasonPoints] [int] NULL,
[PointsRemaining] [int] NULL,
[IsPremium] [bit] NULL
)
GO
ALTER TABLE [ods].[SkiData_User_PointTotals] ADD CONSTRAINT [PK__SkiData___7EF6BFCD93113397] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
