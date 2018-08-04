CREATE TABLE [segmentation].[SegmentationFlatData657f1259-755f-4a1f-a0bb-397c7cbb750f]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_AccountName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_BouncebackDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_IsBounceback] [bit] NULL,
[C_IsSubscribed] [bit] NULL,
[C_PostalCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Province] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SubscriptionDate] [datetime] NULL,
[C_UnsubscriptionDate] [datetime] NULL,
[C_CreatedAt] [datetime] NULL,
[C_CreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_AccessedAt] [datetime] NULL,
[C_CurrentStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Depth] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_UpdatedAt] [datetime] NULL,
[C_UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Company] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Address1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Address2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Address3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_City] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Country] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MobilePhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_BusinessPhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Fax] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SalesPerson] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatData657f1259-755f-4a1f-a0bb-397c7cbb750f] ADD CONSTRAINT [pk_SegmentationFlatData657f1259-755f-4a1f-a0bb-397c7cbb750f] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData657f1259-755f-4a1f-a0bb-397c7cbb750f] ON [segmentation].[SegmentationFlatData657f1259-755f-4a1f-a0bb-397c7cbb750f] ([_rn])
GO
