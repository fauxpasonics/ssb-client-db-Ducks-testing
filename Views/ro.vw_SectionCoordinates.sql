SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [ro].[vw_SectionCoordinates]
AS

SELECT *
FROM dbo.SectionCoordinates (NOLOCK)
;
GO
