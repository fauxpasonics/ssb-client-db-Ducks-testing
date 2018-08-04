SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[vw_SKIDATA_UserProfileRank] AS 

SELECT  profile_attribute_rank.UserID
      , profile_attribute_rank.ProfileID
      , profile_attribute_rank.PropertyDefinitionID
      , profile_attribute_rank.PropertyCategory
      , profile_attribute_rank.PropertyName
      , profile_attribute_rank.DataType
      , profile_attribute_rank.PropertyValue
      , profile_attribute_rank.PropertyText
      , profile_attribute_rank.LastUpdatedDate
FROM    (
          SELECT    UserID
                  , ProfileID
                  , PropertyDefinitionID
                  , PropertyCategory
                  , PropertyName
                  , DataType
                  , PropertyValue
                  , PropertyText
                  , LastUpdatedDate
                  , ROW_NUMBER() OVER ( PARTITION BY UserID, PropertyName ORDER BY LastUpdatedDate DESC ) AS row_rank
          FROM      ods.SkiData_User_Profiles
        ) profile_attribute_rank
WHERE   profile_attribute_rank.row_rank = 1;




GO
