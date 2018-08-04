CREATE TABLE [stg].[SkiData_Points]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_P__ETL_C__3123FCCD] DEFAULT (getdate()),
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointAuditID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointActivityTypeName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointActivityTypeId] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointActivityTitle] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointActivityID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PointsAwarded] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AwardDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AwardedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Valid] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContentType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContentID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateCreated] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[SkiData_Points] ADD CONSTRAINT [PK__SkiData___7EF6BFCD8A5F8858] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
