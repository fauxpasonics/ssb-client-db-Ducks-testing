SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vw_DimScanGate] AS ( SELECT * FROM dbo.DimScanGate_V2 )
GO