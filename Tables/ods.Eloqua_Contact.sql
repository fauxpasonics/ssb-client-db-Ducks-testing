CREATE TABLE [ods].[Eloqua_Contact]
(
[ETL_ID] [int] NOT NULL IDENTITY(1, 1),
[ETL_CreatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Co__ETL_C__5708E33C] DEFAULT (getdate()),
[ETL_UpdatedDate] [datetime] NOT NULL CONSTRAINT [DF__Eloqua_Co__ETL_U__57FD0775] DEFAULT (getdate()),
[ETL_IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Eloqua_Co__ETL_I__58F12BAE] DEFAULT ((0)),
[ETL_DeletedDate] [datetime] NULL,
[ETL_DeltaHashKey] [binary] (32) NULL,
[ID] [int] NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccountName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BouncebackDate] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsBounceback] [bit] NULL,
[IsSubscribed] [bit] NULL,
[PostalCode] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Province] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SubscriptionDate] [datetime] NULL,
[UnsubscriptionDate] [datetime] NULL,
[CreatedAt] [datetime] NULL,
[CreatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AccessedAt] [datetime] NULL,
[CurrentStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Depth] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UpdatedAt] [datetime] NULL,
[UpdatedBy] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Company] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MobilePhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BusinessPhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Fax] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Title] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SalesPerson] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_EmailDisplayName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_State_Prov] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Zip_Postal] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Salutation] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDCContactID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDCLeadID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_DateCreated] [date] NULL,
[C_DateModified] [date] NULL,
[ContactIDExt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDCAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_LastModifiedByExtIntegrateSystem] [date] NULL,
[C_SFDCLastCampaignID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDCLastCampaignStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Company_Revenue1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SFDC_EmailOptOut1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Source___Most_Recent1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Source___Original1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Industry1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Annual_Revenue1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Status1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Job_Role1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_LS___High_Value_Website_Content1] [numeric] (38, 6) NULL,
[C_Lead_Score_Date___Most_Recent1] [date] NULL,
[C_Integrated_Marketing_and_Sales_Funnel_Stage] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Product_Solution_of_Interest1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Region1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_elqPURLName1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Rating___Combined1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_EmailAddressDomain] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_FirstAndLastName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Company_Size1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Score___Last_High_Touch_Event_Date1] [date] NULL,
[C_Lead_Rating___Explicit1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Rating___Implicit1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Score___Explicit1] [numeric] (38, 6) NULL,
[C_Lead_Score___Implicit1] [numeric] (38, 6) NULL,
[C_Lead_Score_Date___Profile___Most_Recent1] [date] NULL,
[C_Employees1] [numeric] (38, 6) NULL,
[C_Territory] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Lead_Score] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_ElqPURLName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Prem_Seat_Info_Other1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Prem_Seat_Info_On1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Preferred_Method_of_Contact1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMContactID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMLeadID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMAccountID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMLastCampaignID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMLastCampaignName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRMLastCampaignStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_LastMSCRMCampaignResponseID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRM_EmailOptOut] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MSCRM_LeadRating] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_County1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C___Seats_Attended1] [numeric] (38, 6) NULL,
[C___Seats_Not_Attended1] [numeric] (38, 6) NULL,
[C_Age1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Annual_Income1] [numeric] (38, 6) NULL,
[C_Annual_Recognition_Description1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Category1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Contact_Id1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Anniversary1] [date] NULL,
[C_Demographic_Birthday1] [date] NULL,
[C_Demographic_Children_s_Names1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Concert_Interests1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Favorite_Destination1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Favorite_Player1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Favorite_Restaurant1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Favorite_Team1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Gender1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Household_Income1] [numeric] (38, 6) NULL,
[C_Demographic_No__of_Children1] [numeric] (38, 6) NULL,
[C_Demographic_Other_Information1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Sports_Interests1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Spouse_Partner_Name1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Discretionary_Income1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Flag_11] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Flag_21] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Flag_31] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Flag_41] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Flag_51] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Group_Type1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Has_Children1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Home_Phone1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Income1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Marital_Status1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Middle_Name1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Model_Capacity1] [numeric] (38, 6) NULL,
[C_Model_Priority1] [numeric] (38, 6) NULL,
[C_Occupation1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Personicx_Cluster1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Premium_Salesperson1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Premium_Serviceperson1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Promo_Code1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Renewal_Status1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Rewards_Password1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Rewards_Username1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Seats_Attended1] [numeric] (38, 6) NULL,
[C_Seats_Not_Attended1] [numeric] (38, 6) NULL,
[C_Seats_Sold1] [numeric] (38, 6) NULL,
[C_Select_a_Seat1] [date] NULL,
[C_Service_Touches1] [numeric] (38, 6) NULL,
[C_Source1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_STH_Id1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Suffix1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Type1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Bulk_E_mails___Ducks1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Bulk_E_mails___Honda_Center1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Annual_Recognition1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Child_Present1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Classical_Music1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Pop_Music1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Rap_Music1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Rock_Music1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Country_Music1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Demographic_Family_Shows1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Do_not_allow_Phone_Calls1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Open_Ticket_Opportunity1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Status1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MD5HashedEmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SHA256HashedEmailAddress] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MD5HashedBusPhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SHA256HashedBusPhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MD5HashedMobilePhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SHA256HashedMobilePhone] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Not_Sync_d_with_CRM1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Serviceperson1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Popup_Received1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_PromoCodeTeemu1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Favorite_NHL_Opponent1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Group_Tickets1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Individual1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Micro_Plans1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Mini_Plans1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Season_Tickets1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Suites_or_Club_Seats1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Search1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Partner1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Promo_Code_TM11] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Promo_Code_TM21] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Promo_Code_TM31] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Promo_Code_TM41] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Appointment_Time_SAS1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Appointment_Time_Online1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Seats_Location1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Seats_Payment_Details1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Rinks_YLTP_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Rinks_ALTP_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Rinks_Customer_Survey_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_CR_Donor_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_WRL_SURVEY_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_UnsubscribedSTH1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_UnsubscribedAnnual1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Loyalty_Program___Newsletter1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Subscribe___GamePreview1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Subscribe___PostgameRecap1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Subscribe___NewsRelease1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Subscribe___TicketDeals1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Subscribe___RinksNewsletter1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Subscribe___WWKidsClub1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Subscribe___DucksCommunity1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_STH_SURVEY_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_MiniPlanExperience_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_GAMEBUYER_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Subscribe___RinksHomeschoolNewsletter1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_DieHardsFeedbackURL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_KidsClubFeedbackURL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Wifi1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Gulls_Salesperson1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Ducks_Salesperson21] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_STH_Survey2017_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Renewal_Rep1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_GAMEBUYER_Survey2017_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_RINKS_Survey2017_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SAS_STH_Account_Rep1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_SAS_Account_ID1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_KidsClub_Survey2017_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_DieHards_Survey2017_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_NoRenew_Survey2017_URL1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_KidsClubShirtYouthMediumCount1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Kits_KidsClubShirtAdultMediumCount1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Kits_DieHardsShirtAdultMediumCount1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Kits_DieHardsShirtAdultXLCount1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Kits_FirstName1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[C_Kits_LastName1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [ods].[Eloqua_Contact] ADD CONSTRAINT [PK__Eloqua_C__3214EC272EF6A039] PRIMARY KEY CLUSTERED  ([ID])
GO
