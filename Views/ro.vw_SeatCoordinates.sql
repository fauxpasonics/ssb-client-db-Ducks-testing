SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ro].[vw_SeatCoordinates]
AS
(
	SELECT 
		SectionName,
		RowName,
		Seat,
		X,
		Y
	FROM dbo.SeatCoordinates (NOLOCK)
);
GO
