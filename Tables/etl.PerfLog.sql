CREATE TABLE [etl].[PerfLog]
(
[Id] [bigint] NOT NULL IDENTITY(1, 1),
[StartTime] [datetime] NOT NULL,
[EndTime] [datetime] NOT NULL,
[ProcessTime] [time] NOT NULL
)
GO
ALTER TABLE [etl].[PerfLog] ADD CONSTRAINT [PK__PerfLog__3214EC0784C98443] PRIMARY KEY CLUSTERED  ([Id])
GO
