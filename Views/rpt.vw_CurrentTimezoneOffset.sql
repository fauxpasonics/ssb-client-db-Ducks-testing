SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [rpt].[vw_CurrentTimezoneOffset]
AS
--Using CTE because of the chance of this running during DST change.  UTC would be ahead of local time and we could be subtracting one less hour than we should.
WITH CTE_CurrentDate
AS (
		SELECT UTCOffset, GETUTCDATE() AS CurrentDateTime, DATEADD(hh, UTCOFFSET, GETUTCDATE()) AS CurrentLocalDateTime, CAST(DATEADD(hh, UTCOFFSET, GETUTCDATE()) AS DATE) AS CurrentLocalDate
		FROM ro.vw_DimDate
		WHERE CalDate = CAST(GETUTCDATE() AS DATE)
	)
SELECT dd.UTCOffset, GETUTCDATE() AS CurrentDateTime
FROM ro.vw_DimDate dd
INNER JOIN CTE_CurrentDate cd
	ON  dd.CalDate = cd.CurrentLocalDate;
GO
