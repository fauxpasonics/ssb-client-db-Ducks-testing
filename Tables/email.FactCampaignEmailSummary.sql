CREATE TABLE [email].[FactCampaignEmailSummary]
(
[FactCampaignEmailSummaryId] [int] NOT NULL IDENTITY(-2, 1),
[DimCampaignId] [int] NULL,
[DimCampaignActivityTypeId] [int] NULL,
[DimEmailId] [int] NULL,
[ActivityTypeTotal] [int] NULL,
[ActivyTypeUnique] [bit] NULL,
[ActivityTypeMinDate] [datetime] NULL,
[ActivityTypeMaxDate] [datetime] NULL,
[CreatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Creat__0B00B5EA] DEFAULT (user_name()),
[CreatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Creat__0BF4DA23] DEFAULT (getdate()),
[UpdatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactCampa__Updat__0CE8FE5C] DEFAULT (user_name()),
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__FactCampa__Updat__0DDD2295] DEFAULT (getdate())
)
GO
ALTER TABLE [email].[FactCampaignEmailSummary] ADD CONSTRAINT [PK__FactCamp__DF75612B6DD7AD0D] PRIMARY KEY CLUSTERED  ([FactCampaignEmailSummaryId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailSummary_DimCampaignActivityTypeId] ON [email].[FactCampaignEmailSummary] ([DimCampaignActivityTypeId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailSummary_DimCampaignId] ON [email].[FactCampaignEmailSummary] ([DimCampaignId])
GO
CREATE NONCLUSTERED INDEX [idx_FactCampaignEmailSummary_DimEmailId] ON [email].[FactCampaignEmailSummary] ([DimEmailId])
GO
ALTER TABLE [email].[FactCampaignEmailSummary] ADD CONSTRAINT [FK__FactCampa__DimCa__0FC56B07] FOREIGN KEY ([DimCampaignId]) REFERENCES [email].[DimCampaign] ([DimCampaignId])
GO
ALTER TABLE [email].[FactCampaignEmailSummary] ADD CONSTRAINT [FK__FactCampa__DimCa__10B98F40] FOREIGN KEY ([DimCampaignActivityTypeId]) REFERENCES [email].[DimCampaignActivityType] ([DimCampaignActivityTypeId])
GO
ALTER TABLE [email].[FactCampaignEmailSummary] ADD CONSTRAINT [FK__FactCampa__DimEm__11ADB379] FOREIGN KEY ([DimEmailId]) REFERENCES [email].[DimEmail] ([DimEmailID])
GO
