CREATE TABLE [segmentation].[SegmentationFlatData50626182-5517-4795-b328-fcad7c7876c8]
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
ALTER TABLE [segmentation].[SegmentationFlatData50626182-5517-4795-b328-fcad7c7876c8] ADD CONSTRAINT [pk_SegmentationFlatData50626182-5517-4795-b328-fcad7c7876c8] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData50626182-5517-4795-b328-fcad7c7876c8] ON [segmentation].[SegmentationFlatData50626182-5517-4795-b328-fcad7c7876c8] ([_rn])
GO
