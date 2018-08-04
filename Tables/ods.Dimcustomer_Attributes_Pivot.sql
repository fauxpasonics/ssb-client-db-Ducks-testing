CREATE TABLE [ods].[Dimcustomer_Attributes_Pivot]
(
[Dimcustomerid] [int] NOT NULL,
[SSID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SOURCESYSTEM] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CreatedDate] [datetime] NULL,
[BirthdayPartyInterest] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FanNewsletterOptIn] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GroupInterest] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KidsClubInterest] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiniPlanInterest] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeasonTicketInterest] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SingleGameTicketInterest] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SuiteInterest] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TextClubOptIn] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TicketDealsOptIn] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
