SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






CREATE VIEW [dbo].[vw_SKIDATA_UserProfileMap]
AS
    ( SELECT    p1.UserID
              , p2.PropertyValue AS FirstName
              , p3.PropertyValue AS LastName
              , p4.PropertyValue AS Gender
              , p5.PropertyValue AS Street
              , p6.PropertyValue AS City
              , p7.PropertyValue AS Unit
              , p8.PropertyValue AS Region
              , p9.PropertyValue AS Country
              , p10.PropertyValue AS PostalCode
              , p11.PropertyValue AS Telephone
              , p12.PropertyValue AS Cell
              , p13.PropertyValue AS Email
              , p14.PropertyValue AS Birthdate
              , p15.PropertyValue AS Married
              , p16.PropertyValue AS WeddingAnniversary
              , p17.PropertyValue AS Children
              , p18.PropertyValue AS Tenure
              , p19.PropertyValue AS FacebookID
              , p20.PropertyValue AS FacebookToken
              , p21.PropertyValue AS TwitterID
              , p22.PropertyValue AS TwitterToken
              , p23.PropertyValue AS TwitterTokenSecret
              , p24.PropertyValue AS TicketAccountID
              , p25.PropertyValue AS FavoriteCurrentPlayer
              , p26.PropertyValue AS favorite_kings_player
              , p27.PropertyValue AS FavoriteAllTimePlayer
              , p28.PropertyValue AS favorite_event_at_G1C
              , p29.PropertyValue AS TeamUniqueID
              , p30.PropertyValue AS Photo
              , p31.PropertyValue AS PreferredTimeZone
      FROM      ( SELECT DISTINCT
                            UserID
                  FROM      dbo.vw_SKIDATA_UserProfileRank
                ) AS p1
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p2 ON p1.UserID = p2.UserID
                                                               AND p2.PropertyName = 'FirstName'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p3 ON p1.UserID = p3.UserID
                                                               AND p3.PropertyName = 'LastName'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p4 ON p1.UserID = p4.UserID
                                                               AND p4.PropertyName = 'Gender'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p5 ON p1.UserID = p5.UserID
                                                               AND p5.PropertyName = 'Street'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p6 ON p1.UserID = p6.UserID
                                                               AND p6.PropertyName = 'City'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p7 ON p1.UserID = p7.UserID
                                                               AND p7.PropertyName = 'Unit'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p8 ON p1.UserID = p8.UserID
                                                               AND p8.PropertyName = 'Region'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p9 ON p1.UserID = p9.UserID
                                                               AND p9.PropertyName = 'Country'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p10 ON p1.UserID = p10.UserID
                                                                AND p10.PropertyName = 'PostalCode'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p11 ON p1.UserID = p11.UserID
                                                                AND p11.PropertyName = 'Telephone'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p12 ON p1.UserID = p12.UserID
                                                                AND p12.PropertyName = 'Cell'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p13 ON p1.UserID = p13.UserID
                                                                AND p13.PropertyName = 'Email'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p14 ON p1.UserID = p14.UserID
                                                                AND p14.PropertyName = 'Birthdate'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p15 ON p1.UserID = p15.UserID
                                                                AND p15.PropertyName = 'Married'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p16 ON p1.UserID = p16.UserID
                                                                AND p16.PropertyName = 'WeddingAnniversary'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p17 ON p1.UserID = p17.UserID
                                                                AND p17.PropertyName = 'Children'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p18 ON p1.UserID = p18.UserID
                                                                AND p18.PropertyName = 'Tenure'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p19 ON p1.UserID = p19.UserID
                                                                AND p19.PropertyName = 'FacebookID'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p20 ON p1.UserID = p20.UserID
                                                                AND p20.PropertyName = 'FacebookToken'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p21 ON p1.UserID = p21.UserID
                                                                AND p21.PropertyName = 'TwitterID'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p22 ON p1.UserID = p22.UserID
                                                                AND p22.PropertyName = 'TwitterToken'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p23 ON p1.UserID = p23.UserID
                                                                AND p23.PropertyName = 'TwitterTokenSecret'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p24 ON p1.UserID = p24.UserID
                                                                AND p24.PropertyName = 'TicketAccountID'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p25 ON p1.UserID = p25.UserID
                                                                AND p25.PropertyName = 'FavoriteCurrentPlayer'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p26 ON p1.UserID = p26.UserID
                                                                AND p26.PropertyName = 'favorite_kings_player'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p27 ON p1.UserID = p27.UserID
                                                                AND p27.PropertyName = 'FavoriteAllTimePlayer'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p28 ON p1.UserID = p28.UserID
                                                                AND p28.PropertyName = 'favorite_event_at_G1C'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p29 ON p1.UserID = p29.UserID
                                                                AND p29.PropertyName = 'TeamUniqueID'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p30 ON p1.UserID = p30.UserID
                                                                AND p30.PropertyName = 'Photo'
                LEFT JOIN dbo.vw_SKIDATA_UserProfileRank p31 ON p1.UserID = p31.UserID
                                                               AND p31.PropertyName = 'PreferredTimeZone'
    );







GO
