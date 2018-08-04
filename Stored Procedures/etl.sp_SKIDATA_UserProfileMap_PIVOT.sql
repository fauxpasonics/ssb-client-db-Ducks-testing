SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




Create PROCEDURE [etl].[sp_SKIDATA_UserProfileMap_PIVOT]
AS
    BEGIN

       DROP TABLE ods.SKIDATA_UserProfileMap_PIVOT

        DECLARE @cols AS NVARCHAR(MAX)
          , @query AS NVARCHAR(MAX)

        SELECT  @cols = STUFF((SELECT   ',' + QUOTENAME(PropertyName)
                               FROM     dbo.vw_SKIDATA_UserProfileRank
                               GROUP BY PropertyName
                               ORDER BY PropertyName
                FOR           XML PATH('')
                                , TYPE
            ).value('.', 'NVARCHAR(MAX)'), 1, 1, '')


        SET @query = 'SELECT UserID, ' + @cols + ' 
			  INTO ods.SKIDATA_UserProfileMap_PIVOT
			  FROM 
             (
                SELECT UserID, PropertyName, PropertyValue
                FROM dbo.vw_SKIDATA_UserProfileRank

            ) x
            PIVOT 
            (
                MIN(PropertyValue)
                FOR PropertyName IN (' + @cols + ')
            ) p'

        EXECUTE(@query)

        --EXECUTE (
        --'DROP  VIEW [ro].[vw_SKIDATA_UserProfileMap_PIVOT]')

        --EXECUTE (
        --'CREATE VIEW [ro].[vw_SKIDATA_UserProfileMap_PIVOT] AS (

        --SELECT *
        --FROM ods.SKIDATA_UserProfileMap_PIVOT WITH (NOLOCK)
        --)')

    END


GO
