CREATE TABLE [mdm].[tmp_flag_data]
(
[dimcustomerid] [int] NOT NULL,
[sourcesystem] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ssid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ssb_crmsystem_acct_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_HOUSEHOLD_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_PRIMARY_FLAG] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SSB_CRMSYSTEM_ACCT_PRIMARY_FLAG] [int] NULL,
[SSB_CRMSYSTEM_HOUSEHOLD_PRIMARY_FLAG] [int] NULL,
[Source System Priority] [int] NOT NULL,
[Primary Contact] [int] NOT NULL,
[Premium/Season Ticket Buyer] [int] NOT NULL,
[Premium/Season Ticket Max Purchase Date] [date] NOT NULL,
[Group/Mini/Micro/Partial Plan Buyer] [int] NOT NULL,
[Group/Mini/Micro/Partial Plan Max Purchase Date] [date] NOT NULL,
[Single Game Ticket Buyer] [int] NOT NULL,
[Single Game Ticket Max Purchase Date] [date] NOT NULL,
[Max Updated Date] [datetime] NULL
)
GO
