CREATE TABLE [etl].[Configuration]
(
[ConfigurationID] [int] NOT NULL,
[Name] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Value] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Active] [bit] NULL,
[CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Configura__Creat__387C9C80] DEFAULT (getdate()),
[CreatedBy] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Configura__Creat__3970C0B9] DEFAULT (suser_sname()),
[LastUpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Configura__LastU__3A64E4F2] DEFAULT (getdate()),
[LastUpdatedBy] [nvarchar] (400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Configura__LastU__3B59092B] DEFAULT (suser_sname())
)
GO
ALTER TABLE [etl].[Configuration] ADD CONSTRAINT [PK__Configur__95AA539B58A3A4D6] PRIMARY KEY CLUSTERED  ([ConfigurationID])
GO
