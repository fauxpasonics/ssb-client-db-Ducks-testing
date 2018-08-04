CREATE TABLE [ods].[Eloqua_Email]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Em__ETL_C__10216507] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Em__ETL_U__11158940] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Em__ETL_I__1209AD79] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [bigint] NOT NULL,
[Name] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailGroupId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPlainTextEditable] [bit] NULL,
[IsTracked] [bit] NULL,
[BouncebackEmail] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReplyToEmail] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReplyToName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SenderEmail] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SenderName] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SenderPlainTextOnly] [bit] NULL,
[Subject] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FolderId] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Permissions] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedAt] [datetime] NULL,
[CreatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccessedAt] [datetime] NULL,
[CurrentStatus] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Depth] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedAt] [datetime] NULL,
[UpdatedBy] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[Eloqua_Email] ADD CONSTRAINT [PK__Eloqua_E__3214EC27711DF338] PRIMARY KEY CLUSTERED  ([ID])
GO
