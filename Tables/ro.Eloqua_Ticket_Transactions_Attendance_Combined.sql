CREATE TABLE [ro].[Eloqua_Ticket_Transactions_Attendance_Combined]
(
[Factticketseat_Key] [nvarchar] (813) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SeasonName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ArchticsID] [int] NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailPrimary] [nvarchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[accountrep] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TM_purchase_price] [decimal] (18, 6) NULL,
[TicketTypeName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EventDate] [date] NULL,
[seattypename] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeatLocation] [nvarchar] (537) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AttendedEvent] [int] NOT NULL,
[MajorCategory] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MinorCategory] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
