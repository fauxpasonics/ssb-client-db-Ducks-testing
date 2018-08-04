CREATE TABLE [ods].[SkiData_RewardRedemptions]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_R__ETL_C__78AA9980] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_R__ETL_U__799EBDB9] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_R__ETL_I__7A92E1F2] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RedemptionID] [int] NULL,
[RewardID] [int] NULL,
[PortalID] [int] NULL,
[UserID] [int] NULL,
[TicketAccountID] [int] NULL,
[PointAuditID] [int] NULL,
[PointsPaid] [int] NULL,
[Quantity] [int] NULL,
[Fulfilled] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FulfilledDate] [datetime] NULL,
[DateCreated] [datetime] NULL,
[DateUpdated] [datetime] NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VoucherCodeID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[SkiData_RewardRedemptions] ADD CONSTRAINT [PK__SkiData___7EF6BFCD2076EF14] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
