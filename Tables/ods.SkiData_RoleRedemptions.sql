CREATE TABLE [ods].[SkiData_RoleRedemptions]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_R__ETL_C__1BF3D5BD] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_R__ETL_U__1CE7F9F6] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_R__ETL_I__1DDC1E2F] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RewardID] [int] NULL,
[RewardTitle] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [int] NULL,
[RedemptionID] [int] NULL,
[PointsPaid] [int] NULL,
[Fulfilled] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RedemptionDate] [datetime] NULL,
[IsPremium] [bit] NULL
)
GO
ALTER TABLE [ods].[SkiData_RoleRedemptions] ADD CONSTRAINT [PK__SkiData___7EF6BFCD7F34F8DA] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
