SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO








CREATE VIEW [segmentation].[vw__CRM_ContactGuids1to1] AS

SELECT
      x.SSB_CRMSYSTEM_CONTACT_ID
	  ,contact.contactid
	  ,contact.createdon
	  ,contact.createdbyname
	  ,contact.modifiedon
	  ,contact.modifiedby
	  ,contact.owneridname
	  --,account.LastActivityDate
	  --,DATEDIFF(DAY,account.LastActivityDate,GETDATE()) DaysSinceLastActivity
	  --,LastActivityOwner /*this requires prodcopy.task to be imported*/
	  --,OpenOpp.OpenOpp AS HasOpenOpportunity
	  --,LastOpportunity.createdon AS LastOpportunity_CreatedDate
	  --,LastOpportunity.OwnerName AS LastOpportunity_OwnerName
	  --,LastOpportunity.LastModifiedDate AS LastOpportunity_LastModifiedDate
	  --,LastOpportunity.kore_campaignname AS LastOpportunity_kore_campaignname
	  --,LastOpportunity.kore_productname AS LastOpportunity_kore_productname
	  --,LastOpportunity.kore_season AS LastOpportunity_kore_season
	  --,LastOpportunity.statuscodename AS LastOpportunity_statuscodename
	  --,LastWon.LastWinDate AS LastWon_ClosedWonDate
	  --,LastWon.kore_campaignname AS LastWon_kore_campaignname
	  --,LastWon.kore_productname AS LastWon_kore_productname
	  --,LastWon.kore_season AS LastWon_kore_season
	  --,LastLost.LostReason AS LastLost_kore_primaryobjectionname
	  --,LastLost.kore_campaignname AS LastLost_kore_campaignname
	  --,LastLost.kore_productname AS LastLost_kore_productname
	  --,LastLost.kore_season AS LastLost_kore_season

	  --LastLoss
	  --statuscodename = sales stages or 
	  --statecode = 0 = active 1 = deactivated (soft delete, ignore anything deactivated - same things for contacts)
	  --declined 



FROM (SELECT CAST(contactid AS NVARCHAR(50)) AS contactid,createdon,createdbyname,modifiedon,modifiedby,owneridname 
	  FROM Ducks_Reporting.[Prodcopy].[contact] (NOLOCK)
	  ) contact
INNER JOIN  (SELECT SSB_CRMSYSTEM_CONTACT_ID, SSID, ROW_NUMBER() OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID ORDER BY updateddate DESC, createddate) xRank 
					FROM [dbo].[vwDimCustomer_ModAcctId] (NOLOCK) dc
					WHERE dc.SourceSystem= 'CRM_Contact') x
					ON contact.contactid = x.SSID AND x.xRank = '1'
--LEFT JOIN (SELECT opportunity.kore_contact
--					, opportunity.kore_ticketsalesopportunityid
--			   		 ,opportunity.CreatedOn
--			   		 ,opportunity.owneridname AS OwnerName
--			   		 ,opportunity.modifiedon AS LastModifiedDate
--					 ,opportunity.kore_campaignname
--					 ,opportunity.kore_productname
--					 ,opportunity.kore_season
--					 ,opportunity.statuscodename
--					 ,RANK() OVER(PARTITION BY opportunity.kore_contact ORDER BY opportunity.kore_ticketsalesopportunityid) opportunityRank
--			   FROM Wild_Reporting.[Prodcopy].[TicketSalesOpportunity] (NOLOCK) opportunity
--				JOIN (SELECT kore_contact
--							,MAX(createdon)MaxDate
--					  FROM Wild_Reporting.[Prodcopy].[TicketSalesOpportunity] (NOLOCK)
--					  GROUP BY kore_contact
--					  ) x
--					  ON x.kore_contact = opportunity.kore_contact
--						AND x.MaxDate = opportunity.CreatedOn
--				) LastOpportunity ON LastOpportunity.kore_contact = contact.contactid
--				   AND LastOpportunity.opportunityRank = 1
--LEFT JOIN (SELECT Opportunity.kore_contact
--				, opportunity.kore_ticketsalesopportunityid
--				,opportunity.kore_campaignname
--			    ,opportunity.kore_productname
--				,opportunity.kore_season
--				,LastWin.LastWinDate
--				,RANK() OVER(PARTITION BY opportunity.kore_contact ORDER BY opportunity.kore_ticketsalesopportunityid) opportunityRank
--			FROM Wild_Reporting.[Prodcopy].[TicketSalesOpportunity]  (NOLOCK) opportunity
--				JOIN (SELECT kore_contact
--					,MAX(modifiedon) LastWinDate 
--			FROM Wild_Reporting.[Prodcopy].[TicketSalesOpportunity] (NOLOCK)
--			WHERE statuscodename IN ('Purchased', 'Placed Deposit')
--			GROUP BY kore_contact) LastWin ON LastWin.kore_contact = opportunity.kore_contact
--											 AND LastWin.LastWinDate = Opportunity.modifiedon
--			) LastWon ON LastWon.kore_contact= contact.contactid
--							AND LastWon.opportunityRank = 1
--LEFT JOIN (SELECT Opportunity.kore_contact
--				,opportunity.kore_ticketsalesopportunityid
--				,opportunity.kore_primaryobjectionname LostReason
--				,opportunity.kore_campaignname
--			    ,opportunity.kore_productname
--				,opportunity.kore_season
--				,RANK() OVER(PARTITION BY opportunity.kore_contact ORDER BY opportunity.kore_ticketsalesopportunityid) opportunityRank
--			FROM Wild_Reporting.[Prodcopy].[TicketSalesOpportunity]  (NOLOCK) opportunity
--				JOIN (SELECT kore_contact
--							,MAX(createdon) AS LastLoss
--						FROM Wild_Reporting.[Prodcopy].[TicketSalesOpportunity] (NOLOCK)
--						WHERE statuscodename = 'Declined'
--						GROUP BY kore_contact) LastLoss ON LastLoss.kore_contact = opportunity.kore_contact
--														AND LastLoss.LastLoss = Opportunity.CreatedOn
--			) LastLost ON LastLost.kore_contact= contact.contactid
--							AND LastLost.opportunityRank = 1

	



GO
