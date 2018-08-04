CREATE TABLE [ro].[Eloqua_Ticket_Transactions_Attendance]
(
[Factticketseat_Key] [nvarchar] (216) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__SSID_TM_acct_id] [int] NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailPrimary] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[accountrep] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TM_purchase_price] [decimal] (18, 6) NULL,
[TicketTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDesc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDate] [date] NULL,
[seattypename] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatLocation] [nvarchar] (152) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AttendedEvent] [int] NOT NULL
)
GO
