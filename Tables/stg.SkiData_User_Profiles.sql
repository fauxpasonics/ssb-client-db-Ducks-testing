CREATE TABLE [stg].[SkiData_User_Profiles]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__SkiData_U__ETL_C__1E112859] DEFAULT (getdate()),
[ETL_SourceFileName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProfileID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyDefinitionID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyCategory] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DataType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyValue] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PropertyText] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastUpdatedDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [stg].[SkiData_User_Profiles] ADD CONSTRAINT [PK__SkiData___7EF6BFCD409C5F28] PRIMARY KEY CLUSTERED  ([ETL_ID])
GO
