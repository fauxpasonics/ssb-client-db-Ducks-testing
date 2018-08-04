CREATE TABLE [ods].[Ducks_STH_Surveysss]
(
[recordid] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[started] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[completed] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modified] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[branched_out] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[over_quota] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[campaign_status] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[culture] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[http_referer] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[http_user_agent] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[remote_addr] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[remote_host] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_page] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_page_number] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modifier] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Account ID] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q1_Reg. Season Games Attended (1=0-5, 2=5-10, 3=10-15, 4=15-20)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q2_Use of Tickets (1=Personal, 2=Business)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q2_1_Use of Tickets_Other_Specified] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_1_Favorite Benefits_Discounted Pricing (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_2_Favorite Benefits_Access to Every Home Game (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_3_Favorite Benefits_Seat Location (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_4_Favorite Benefits_Access to Playoff Strips (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_5_Favorite Benefits_Personal Account Executive (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_6_Favorite Benefits_Dedication Program (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_7_Favorite Benefits_Exclusive STH Events (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_8_Favorite Benefits_Flexible Payment Plans (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_9_Favorite Benefits_Team Store Discount (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q3_10_Favorite Benefits_Other (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q4_1_Use of Unused Tickets_Give to friends/family (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q4_2_Use of Unused Tickets_Give to clients/employees/coworkers (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q4_3_Use of Unused Tickets_Donate to charity (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q4_4_Use of Unused Tickets_Sell tickets through My Ducks Account (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q4_6_Use of Unused Tickets_Leave tickets unused (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q4_7_Use of Unused Tickets_N/A I always use my tickets (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q5_Overall Satisfaction as a STH (1=Very Sat., 4=Very Unsat.)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q6_Reason for being unsatisfied] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q7_Likeliness to Renew Tickets (1=Def. Likely, 4=Def. Not Likely)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_1_Not Renewing Because_Team not going in right direction (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_2_Not Renewing Because_The in-game entertainment (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_3_Not Renewing Because_Can't enjoy the game due to fan behavior (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_4_Not Renewing Because_Overall cost of attending is too high (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_5_Not Renewing Because_Cost of being a STH outweighs the benefits (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_6_Not Renewing Because_I have moved (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_7_Not Renewing Because_Seat Location (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_8_Not Renewing Because_Hassle to get to the arena (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_9_Not Renewing Because_Unable to make enough games to make it worthwhile (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_10_Not Renewing Because_I can buy games i want on the secondary market (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_11_Not Renewing Because_I cannot resell my tickets due to low perceived demand (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_12_Not Renewing Because_I am unsatisfied with the food and beverage option at Honda Center (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q8_13_Not Renewing Because_There has been a change with my STH Partner(s) (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q9_Who Do You Direct Questions Towards? (1=Account Rep, 2= Ticket Office, 3=IDK)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q10_Name of Account Executive (1=DA, 2=KM, 3=MM, 4=CN, 5=NM, 6=IDK) ] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q11_1_Rate Your Rep_Responsiveness (1=Very Sat., 4=Very Unsat., 5=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q11_2_Rate Your Rep_Ability to resolve issues (1=Very Sat., 4=Very Unsat., 5=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q11_3_Rate Your Rep_Keeps me informed (1=Very Sat., 4=Very Unsat., 5=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q11_4_Rate Your Rep_Overall customer service (1=Very Sat., 4=Very Unsat., 5=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q12_Areas for Rep to improve in] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q13_Interest in learning about referring a friend (1=yes, 2=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q14_Interest in Premium Seating program (1=yes, 2=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_1_Sponsor Identified_Honda (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_2_Sponsor Identified_Coca Cola (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_3_Sponsor Identified_Wells Fargo (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_4_Sponsor Identified_Pechanga Resort (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_5_Sponsor Identified_Bud Light (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_6_Sponsor Identified_UCLA (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_7_Sponsor Identified_Toyota (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_8_Sponsor Identified_7up (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_9_Sponsor Identified_Citizens Business Bank (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_10_Sponsor Identified_San Manuel Indian Bingo & Casino (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_11_Sponsor Identified_Coors Light (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_12_Sponsor Identified_USC (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_13_Sponsor Identified_Ford (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_14_Sponsor Identified_Pepsi (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_15_Sponsor Identified_Pacific Premier Bank (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_16_Sponsor Identified_Pala (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_17_Sponsor Identified_Miller Lite (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_18_Sponsor Identified_UC Irvine (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q15_19_Sponsor Identified_I don't Know (1=yes, 0=no)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q16_Likeliness to purchase a product affiliated with the Ducks (1=Strongly Agree, 4= Strongly Disagree, 5=Neither)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q17_1_Engagement Level_TV (1=Very Engaged, 3=Not, 4=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q17_2_Engagement Level_Radio (1=Very Engaged, 3=Not, 4=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q17_3_Engagement Level_Facebook (1=Very Engaged, 3=Not, 4=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q17_4_Engagement Level_Twitter (1=Very Engaged, 3=Not, 4=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q17_5_Engagement Level_Snapchat (1=Very Engaged, 3=Not, 4=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Q17_6_Engagement Level_Instagram (1=Very Engaged, 3=Not, 4=N/A)] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
