SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ro].[vw_DimSalesCode] AS ( SELECT * FROM dbo.DimSalesCode_V2 (NOLOCK) )
GO
