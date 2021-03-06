CREATE TABLE [stg].[TicketBrokerTTG_Inventory]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__TicketBro__ETL_C__2281A312] DEFAULT (getdate()),
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Opponent] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatSection] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatRow] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BeginningSeat] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndSeat] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Quantity] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Cost] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Revenue] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Profit] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Margin] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SaleDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Customer] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[TicketBrokerTTG_Inventory] ADD CONSTRAINT [PK__TicketBr__7EF6BFCD0D6CBEB2] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
