CREATE TABLE [ods].[TicketBrokerTTG_Inventory]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__TicketBro__ETL_C__1DBCEDF5] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__TicketBro__ETL_U__1EB1122E] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__TicketBro__ETL_I__1FA53667] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDate] [datetime] NOT NULL,
[Opponent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatSection] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatRow] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BeginningSeat] [int] NULL,
[EndSeat] [int] NULL,
[Quantity] [int] NULL,
[Cost] [decimal] (8, 2) NULL,
[Revenue] [decimal] (8, 2) NULL,
[Profit] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Margin] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SaleDate] [datetime] NULL,
[Customer] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[TicketBrokerTTG_Inventory] ADD CONSTRAINT [PK__TicketBr__7EF6BFCD40C4BB96] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
