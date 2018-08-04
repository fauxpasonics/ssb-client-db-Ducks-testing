SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO







CREATE PROCEDURE [etl].[Dimcustomer_Attributes_Pivot]
    --(
    --    @SurveyName VARCHAR(MAX)
    --)
AS

--DECLARE @sql NVARCHAR(255)

--        DECLARE @SurveyTableName VARCHAR(MAX)
--        SELECT @SurveyTableName = 'TurnKey' + '_' + REPLACE(REPLACE(@SurveyName, ' ', '_'), '-', '_')

--IF EXISTS (SELECT * FROM sys.tables WHERE name = @SurveyTableName AND type  = 'U')


BEGIN

	--SET @sql= (SELECT CONCAT('drop table kings.', @SurveyTableName))

	--EXEC (@sql)


	DROP TABLE [ODS].[Dimcustomer_Attributes_Pivot]

	end
		



SELECT a.SSID,
	   a.DimCustomerId, 
	   a.SourceSystem,  
       c.AttributeName,
       c.AttributeValue
INTO #dimattributes
FROM dbo.DimCustomer a WITH (NOLOCK)
INNER JOIN dbo.DimCustomerAttributes b WITH (NOLOCK) ON a.DimCustomerId = b.DimCustomerID
INNER JOIN dbo.DimCustomerAttributeValues c WITH (NOLOCK) ON b.DimCustomerAttrID = c.DimCustomerAttrID
WHERE 1=1
ORDER BY a.DimCustomerId
--AND a.DimCustomerId = '938587'



        DECLARE @cols AS NVARCHAR(MAX)
              , @query AS NVARCHAR(MAX)

        SELECT @cols = STUFF((   SELECT   ',' + QUOTENAME(AttributeName)
                                 FROM    #dimattributes
                                 GROUP BY attributename
                                 ORDER BY attributename
                                 FOR XML PATH(''), TYPE
                             ).value('.', 'NVARCHAR(MAX)')
                           , 1
                           , 1
                           , ''
                            )
		

        SET @query = 'SELECT      Dimcustomerid
								, SSID
								, SOURCESYSTEM
								,' + @cols + ' 
					  INTO [ODS].[Dimcustomer_Attributes_Pivot]
					  FROM 
					 (
						SELECT SSID
								, DimcustomerID
								, AttributeName
								, SourceSystem
								, AttributeValue
						FROM #DimAttributes
					) x
					PIVOT 
					(
						Min(AttributeValue)
						FOR AttributeName IN (' + @cols + ')
					) p'

        EXECUTE ( @query )




 --   END






-- SELECT * FROM [ODS].[Dimcustomer_Attributes_Pivot]

GO
