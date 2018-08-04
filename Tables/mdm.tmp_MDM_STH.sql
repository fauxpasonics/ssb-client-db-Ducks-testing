CREATE TABLE [mdm].[tmp_MDM_STH]
(
[dimcustomerid] [int] NOT NULL,
[PrimaryCustomer] [int] NOT NULL,
[sth] [int] NULL,
[MaxSTHPurchaseDate] [date] NULL,
[MaxUpdatedDate] [datetime] NULL,
[Grp] [int] NULL,
[accountid] [int] NULL,
[MaxGRPPurchaseDate] [date] NULL,
[Single] [int] NULL,
[MaxSGLPurchaseDate] [date] NULL
)
GO
CREATE CLUSTERED INDEX [ix_MDM_STH] ON [mdm].[tmp_MDM_STH] ([dimcustomerid])
GO
