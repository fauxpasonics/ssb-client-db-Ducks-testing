CREATE TABLE [stg].[Eloqua_Campaign]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Ca__ETL_C__30E33A54] DEFAULT (getdate()),
[ID] [int] NOT NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActualCost] [numeric] (38, 6) NULL,
[BudgetedCost] [numeric] (38, 6) NULL,
[CampaignType] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CrmId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndAt] [datetime] NULL,
[EndValues] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsMemberAllowedReEntry] [bit] NULL,
[IsReadOnly] [bit] NULL,
[Product] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Region] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartAt] [datetime] NULL,
[CreatedAt] [datetime] NULL,
[CreatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccessedAt] [datetime] NULL,
[CurrentStatus] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Depth] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedAt] [datetime] NULL,
[UpdatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Permissions] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ScheduledFor] [datetime] NULL,
[SourceTemplatedId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FolderId] [int] NULL,
[CampaignType1] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Five] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Four] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Three] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Two] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CLREndDate] [date] NULL
)
GO
ALTER TABLE [stg].[Eloqua_Campaign] ADD CONSTRAINT [PK__Eloqua_C__3214EC279538F65C] PRIMARY KEY CLUSTERED  ([ID])
GO
