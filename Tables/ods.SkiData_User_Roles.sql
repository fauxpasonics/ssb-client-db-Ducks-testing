CREATE TABLE [ods].[SkiData_User_Roles]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_C__09D52582] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_U__0AC949BB] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_I__0BBD6DF4] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserRoleID] [int] NULL,
[RoleGroupID] [int] NULL,
[RoleGroupName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RoleID] [int] NULL,
[RoleName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [int] NULL,
[TicketAccountID] [int] NULL,
[ExpiryDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EffectiveDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[SkiData_User_Roles] ADD CONSTRAINT [PK__SkiData___7EF6BFCDE9574F75] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
