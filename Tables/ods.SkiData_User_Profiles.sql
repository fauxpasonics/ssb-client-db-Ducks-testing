CREATE TABLE [ods].[SkiData_User_Profiles]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_C__09160B73] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_U__0A0A2FAC] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_I__0AFE53E5] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProfileID] [int] NOT NULL,
[UserID] [int] NOT NULL,
[PropertyDefinitionID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyCategory] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyValue] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyText] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastUpdatedDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[SkiData_User_Profiles] ADD CONSTRAINT [PK__SkiData___7EF6BFCDAF5D95EC] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
