CREATE TABLE [segmentation].[SegmentationFlatData6a62f258-d4fa-4a6e-b7ff-cca67a47bc05]
(
[id] [uniqueidentifier] NOT NULL,
[DocumentType] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SessionId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Environment] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TenantId] [varchar] (36) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[_rn] [bigint] NULL,
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Archtics_Acct_Id] [int] NULL,
[Attended_By_Originator] [bit] NULL,
[Season_Is_Active] [bit] NULL,
[Season_Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Header_Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Desc] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Class] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Date] [date] NULL,
[Event_Time] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Hierarchy_L1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Hierarchy_L2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Event_Hierarchy_L3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Section_Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Row_Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[First_Seat] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Scan_Time] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Scan_Gate] [int] NOT NULL
)
GO
ALTER TABLE [segmentation].[SegmentationFlatData6a62f258-d4fa-4a6e-b7ff-cca67a47bc05] ADD CONSTRAINT [pk_SegmentationFlatData6a62f258-d4fa-4a6e-b7ff-cca67a47bc05] PRIMARY KEY NONCLUSTERED  ([id])
GO
CREATE CLUSTERED INDEX [cix_SegmentationFlatData6a62f258-d4fa-4a6e-b7ff-cca67a47bc05] ON [segmentation].[SegmentationFlatData6a62f258-d4fa-4a6e-b7ff-cca67a47bc05] ([_rn])
GO
