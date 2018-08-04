CREATE TABLE [stg].[SkiData_RoleRedemptions]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_R__ETL_C__19176912] DEFAULT (getdate()),
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RewardID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RewardTitle] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RedemptionID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointsPaid] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fulfilled] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RedemptionDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPremium] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[SkiData_RoleRedemptions] ADD CONSTRAINT [PK__SkiData___7EF6BFCD5FEDF69C] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
