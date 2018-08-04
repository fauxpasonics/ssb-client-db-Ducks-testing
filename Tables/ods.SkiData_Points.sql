CREATE TABLE [ods].[SkiData_Points]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_P__ETL_C__34F48DB1] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_P__ETL_U__35E8B1EA] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_P__ETL_I__36DCD623] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointAuditID] [int] NULL,
[UserID] [int] NULL,
[TicketAccountID] [int] NULL,
[SeatID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointActivityTypeName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointActivityTypeId] [int] NULL,
[PointActivityTitle] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointActivityID] [int] NULL,
[PointsAwarded] [int] NULL,
[AwardDate] [datetime] NULL,
[AwardedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Valid] [bit] NULL,
[ContentType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContentID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateCreated] [datetime] NULL
)
GO
ALTER TABLE [ods].[SkiData_Points] ADD CONSTRAINT [PK__SkiData___7EF6BFCD80F55ED4] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
