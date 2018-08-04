CREATE TABLE [ro].[Eloqua_TM_Transactions2]
(
[Factticketseat_Key] [nvarchar] (165) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__SSID_TM_acct_id] [int] NULL,
[EmailPrimary] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[accountrep] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketTypeName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDate] [date] NULL,
[seattypename] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatLocation] [nvarchar] (152) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AttendedEvent] [int] NOT NULL
)
GO
