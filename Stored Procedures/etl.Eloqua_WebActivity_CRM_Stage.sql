SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





--SELECT * FROM ods.Eloqua_WebActivity_CRM_Stage
--where



CREATE PROC [etl].[Eloqua_WebActivity_CRM_Stage] AS

DROP TABLE ods.Eloqua_WebActivity_CRM_Stage

--------------------------------Eloqu Promotional Infomration----------------------------------------------------------------------------------------------------------------------------------
--IF OBJECT_ID('tempdb..#PromoWebVisitDate') IS NOT NULL
--    DROP TABLE #PromoWebVisitDate
--SELECT distinct  m.SSB_CRMSYSTEM_CONTACT_ID, C.ID
--INTO  #PromoWebVisitDate
--FROM ducks.[ods].[Eloqua_ActivityWebVisit] wv
--JOIN ducks.[ods].[Eloqua_Contact] c
--	ON wv.ContactId = c.ID
--JOIN ducks.dbo.vwDimCustomer_ModAcctId m
--	ON m.ssid = c.id AND m.SourceSystem = 'Eloqua'
--WHERE 1=1--wv.CreatedAt >= (GETDATE() - 30)



--SELECT DISTINCT m.SSB_CRMSYSTEM_CONTACT_ID,p.id 
--INTO #PromoWebVisitDates
--FROM dbo.vwDimCustomer_ModAcctId m
--JOIN #PromoWebVisitDate p
--ON p.SSB_CRMSYSTEM_CONTACT_ID = m.SSB_CRMSYSTEM_CONTACT_ID
--WHERE 1=1
--AND (m.EmailPrimary NOT LIKE '@anaheimducks.com' 
--						OR m.EmailPrimary NOT LIKE '@hondacenter.com' 
--						OR m.EmailPrimary NOT LIKE '@the-rinks.com' 
--						OR  m.EmailPrimary NOT LIKE '@hsventures.org')
--					AND m.AddressPrimaryStreet <> '2695 E Katella Ave'
--						AND m.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')


--IF OBJECT_ID('tempdb..#PromoTicketTypeCriteria') IS NOT NULL
--    DROP TABLE #PromoTicketTypeCriteria
--SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.ID
--INTO  #PromoTicketTypeCriteria
--FROM Ducks.dbo.FactTicketSales_V2 fts
--	JOIN ducks.dbo.DimTicketCustomer_V2 t
--		ON t.dimticketcustomerID = fts.DimTicketCustomerId
--	JOIN ducks.dbo.DimCustomer d
--		ON CAST(d.AccountId AS NVARCHAR(255)) = t.ETL__SSID AND d.SourceSystem = t.ETL__SourceSystem AND d.CustomerType = 'Primary'
--	JOIN ducks.dbo.vwDimCustomer_ModAcctId ssbid
--		ON ssbid.DimCustomerId = d.DimCustomerId
--	JOIN #PromoWebVisitDates wv
--		ON wv.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
--	JOIN Ducks.dbo.DimDate dd
--		ON dd.DimDateId = fts.DimDateId
--	JOIN ducks.dbo.DimTicketType_V2 tt
--		ON tt.DimTicketTypeId = fts.DimTicketTypeId
--	WHERE 1=1 -- dd.CalDate >= (GETDATE() - 30)
--	AND fts.DimTicketTypeId NOT IN (2,3,4,9) 
--					--AND (ssbid.EmailPrimary NOT LIKE '@anaheimducks.com' 
--					--	OR ssbid.EmailPrimary NOT LIKE '@hondacenter.com' 
--					--	OR ssbid.EmailPrimary NOT LIKE '@the-rinks.com' 
--					--	OR  ssbid.EmailPrimary NOT LIKE '@hsventures.org')
--					--AND ssbid.AccountRep NOT LIKE 'ADHC%'
--					--AND ssbid.AddressPrimaryStreet <> '2695 E Katella Ave'
--					--	AND ssbid.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')


--IF OBJECT_ID('tempdb..#PromoURL') IS NOT NULL
--    DROP TABLE #PromoURL
--SELECT  ssbid.SSB_CRMSYSTEM_CONTACT_ID, MAX(wv.createdat) CreatedAt, CONCAT('Promotional',+ ': ',+ wv.FirstPageViewUrl) AS WebActivity
--INTO  #PromoURL
--FROM #promoTicketTypeCriteria tt
--JOIN ducks.[ods].[Eloqua_Contact] c
--	ON C.Id = TT.id
--JOIN ducks.[ods].[Eloqua_ActivityWebVisit] wv
--	ON wv.ContactId = c.ID
--JOIN ducks.dbo.vwDimCustomer_ModAcctId ssbid
--	ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = tt.SSB_CRMSYSTEM_CONTACT_ID
--WHERE (wv.firstpageviewurl IN('https://www.nhl.com/ducks/tickets/promo-packs'
--,'https://www.nhl.com/ducks/schedule/2017-10-01/PT'
--,'https://www.nhl.com/ducks/schedule/2017-10-01/PT/list'
--,'https://www.nhl.com/ducks/schedule/2017-11-01/PT'
--,'https://www.nhl.com/ducks/schedule/2017-11-01/PT/list'
--,'https://www.nhl.com/ducks/schedule/2017-12-01/PT'
--,'https://www.nhl.com/ducks/schedule/2017-12-01/PT/list'
--,'https://www.nhl.com/ducks/schedule/2018-01-01/PT'
--,'https://www.nhl.com/ducks/schedule/2018-01-01/PT/list'
--,'https://www.nhl.com/ducks/schedule/2018-02-01/PT'
--,'https://www.nhl.com/ducks/schedule/2018-02-01/PT/list'
--,'https://www.nhl.com/ducks/schedule/2018-03-01/PT'
--,'https://www.nhl.com/ducks/schedule/2018-03-01/PT/list'
--,'https://www.nhl.com/ducks/schedule/2018-04-01/PT'
--,'https://www.nhl.com/ducks/schedule/2018-04-01/PT/list'
--,'https://www.nhl.com/ducks/fans/promo-schedule'
--,'https://www.nhl.com/ducks/tickets'
--,'https://www.nhl.com/ducks/tickets/single-game-tickets'
--,'https://www1.ticketmaster.com/'
--,'https://www.ticketmaster.com/ ')
--OR (wv.firstpageviewurl LIKE '%Ticketmaster.com%' AND (wv.firstpageviewurl LIKE '%did=beer%' OR wv.firstpageviewurl LIKE '%did=soda%')))
--AND 1=1-- wv.CreatedAt >= (GETDATE() - 30)
--					--AND (ssbid.EmailPrimary NOT LIKE '@anaheimducks.com' 
--					--	OR ssbid.EmailPrimary NOT LIKE '@hondacenter.com' 
--					--	OR ssbid.EmailPrimary NOT LIKE '@the-rinks.com' 
--					--	OR  ssbid.EmailPrimary NOT LIKE '@hsventures.org')
--					--AND ssbid.AccountRep NOT LIKE 'ADHC%'
--					--AND ssbid.AddressPrimaryStreet <> '2695 E Katella Ave'
--					--	AND ssbid.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')

--GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.FirstPageViewUrl






----------------------------------Eloqua Premium Infomration----------------------------------------------------------------------------------------------------------------------------------
--IF OBJECT_ID('tempdb..#PremiumWebVisitDate') IS NOT NULL
--    DROP TABLE #PremiumWebVisitDate
--SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID, C.ID, wv.CreatedAt, wv.FirstPageViewUrl AS WebActivity
--INTO  #PremiumWebVisitDate
--FROM ducks.[ods].[Eloqua_ActivityWebVisit] wv
--JOIN ducks.[ods].[Eloqua_Contact] c
--	ON wv.ContactId = c.ID
--JOIN ducks.dbo.vwDimCustomer_ModAcctId ssbid
--	ON ssbid.ssid = c.id AND ssbid.SourceSystem = 'Eloqua'
--WHERE 1=1 --wv.CreatedAt >= (GETDATE() - 30)
--and wv.firstpageviewurl IN('http://www.hondacenter.com/premium-seating/luxury-suites/'
--,'http://www.hondacenter.com/premium-seating/club-seats/'
--,'http://www.hondacenter.com/premium-seating/ducks-rental-suites/'
--,'http://www.hondacenter.com/premium-seating/premium-perks/'
--,'http://www.hondacenter.com/premium-seating/seating-map/')


--SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID, C.ID, fs.CreatedAt, fs.AssetName
--INTO #PremiumWebVisitDateUnion
--FROM ducks.ods.Eloqua_ActivityFormSubmit fs
--JOIN ducks.[ods].[Eloqua_Contact] c
--	ON fs.ContactId = c.ID
--JOIN ducks.dbo.vwDimCustomer_ModAcctId ssbid
--	ON ssbid.ssid = c.id AND ssbid.SourceSystem = 'Eloqua'
--WHERE 1=1-- fs.CreatedAt >= (GETDATE() - 30)
--AND fs.assetname IN('Ducks_BetweenBenches_Interest_2017.09.15' ,'Ducks_SuiteMiniPlans_2017.08.16') --need to add in the form submittes associated to the URLs below
----,'http://www.hondacenter.com/premium-seating/premium-seating-experience'
----,'http://www.hondacenter.com/premium-seating/my-account/')





--SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, p.ID, p.CreatedAt,p.WebActivity 
--INTO #PremiumWebVisitDates
--FROM #PremiumWebVisitDate p
--JOIN dbo.vwDimCustomer_ModAcctId ssbid
--ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = p.SSB_CRMSYSTEM_CONTACT_ID
--					AND (ssbid.EmailPrimary NOT LIKE '@anaheimducks.com' 
--						OR ssbid.EmailPrimary NOT LIKE '@hondacenter.com' 
--						OR ssbid.EmailPrimary NOT LIKE '@the-rinks.com' 
--						OR  ssbid.EmailPrimary NOT LIKE '@hsventures.org')
--					AND ssbid.AddressPrimaryStreet <> '2695 E Katella Ave'
--						AND ssbid.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')


--union

--SELECT ssbid.SSB_CRMSYSTEM_CONTACT_ID, p.ID, p.CreatedAt, p.AssetName
--FROM #PremiumWebVisitDateUnion p
--JOIN dbo.vwDimCustomer_ModAcctId ssbid
--ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = p.SSB_CRMSYSTEM_CONTACT_ID
--					AND (ssbid.EmailPrimary NOT LIKE '@anaheimducks.com' 
--						OR ssbid.EmailPrimary NOT LIKE '@hondacenter.com' 
--						OR ssbid.EmailPrimary NOT LIKE '@the-rinks.com' 
--						OR  ssbid.EmailPrimary NOT LIKE '@hsventures.org')
--					AND ssbid.AddressPrimaryStreet <> '2695 E Katella Ave'
--						AND ssbid.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')


--IF OBJECT_ID('tempdb..#PremiumTicketTypeCriteria') IS NOT NULL
--    DROP TABLE #PremiumTicketTypeCriteria
--SELECT DISTINCT  ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.createdat AS ActivityTime, CONCAT('Premium',+ ': ',+ wv.WebActivity) AS WebActivity
--INTO  #PremiumTicketTypeCriteria 
--FROM Ducks.dbo.FactTicketSales_V2 fts
--	JOIN ducks.dbo.DimTicketCustomer_V2 t
--		ON t.dimticketcustomerID = fts.DimTicketCustomerId
--	JOIN ducks.dbo.DimCustomer d
--		ON CAST(d.AccountId AS NVARCHAR(255)) = t.ETL__SSID AND d.SourceSystem = t.ETL__SourceSystem AND d.CustomerType = 'Primary'
--	JOIN ducks.dbo.vwDimCustomer_ModAcctId ssbid
--		ON ssbid.DimCustomerId = d.DimCustomerId
--	JOIN #PremiumWebVisitDates wv
--		ON wv.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
--	JOIN Ducks.dbo.DimDate dd
--		ON dd.DimDateId = fts.DimDateId
--	JOIN ducks.dbo.DimTicketType_V2 tt
--		ON tt.DimTicketTypeId = fts.DimTicketTypeId
--	WHERE 1=1-- dd.CalDate >= (GETDATE() - 30)
--	AND fts.DimTicketTypeId NOT IN (2,4)  
--					--AND (ssbid.EmailPrimary NOT LIKE '@anaheimducks.com' 
--					--	OR ssbid.EmailPrimary NOT LIKE '@hondacenter.com' 
--					--	OR ssbid.EmailPrimary NOT LIKE '@the-rinks.com' 
--					--	OR  ssbid.EmailPrimary NOT LIKE '@hsventures.org')
--					--AND ssbid.AccountRep NOT LIKE 'ADHC%'
--					--AND ssbid.AddressPrimaryStreet <> '2695 E Katella Ave'
--					--	AND ssbid.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')







----------------------------------Eloqua Form Submission----------------------------------------------------------------------------------------------------------------------------------
--IF OBJECT_ID('tempdb..#FormSubmissionWebVisitDate') IS NOT NULL
--    DROP TABLE #FormSubmissionWebVisitDate
--SELECT  DISTINCT  ssbid.SSB_CRMSYSTEM_CONTACT_ID, fs.CreatedAt,CONCAT('Form', + ': ', + fs.AssetName) AS WebActivty
--INTO #FormSubmissionWebVisitDate
--FROM ducks.[ods].[Eloqua_ActivityFormSubmit] fs
--JOIN ducks.[ods].[Eloqua_Contact] c
--	ON fs.ContactId = c.ID
--JOIN ducks.dbo.vwDimCustomer_ModAcctId ssbid
--	ON ssbid.ssid = c.id AND ssbid.SourceSystem = 'Eloqua'
--WHERE 1=1 --fs.CreatedAt >= (GETDATE() - 30)
--AND fs.AssetName = 'Ducks_Schedule_Relase_Boost_TicketInterest_2017.06.22'
					


--SELECT DISTINCT ssbid.SSB_CRMSYSTEM_CONTACT_ID, f.CreatedAt,f.WebActivty
--INTO #FormSubmissionWebVisitDates
--FROM #FormSubmissionWebVisitDate f
--JOIN dbo.vwDimCustomer_ModAcctId ssbid
--ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = f.SSB_CRMSYSTEM_CONTACT_ID
--					AND (ssbid.EmailPrimary NOT LIKE '@anaheimducks.com' 
--						OR ssbid.EmailPrimary NOT LIKE '@hondacenter.com' 
--						OR ssbid.EmailPrimary NOT LIKE '@the-rinks.com' 
--						OR  ssbid.EmailPrimary NOT LIKE '@hsventures.org')
--					AND ssbid.AddressPrimaryStreet <> '2695 E Katella Ave'
--						AND ssbid.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')







--SELECT  DISTINCT  SSB_CRMSYSTEM_CONTACT_ID, CreatedAt, WebActivity
--INTO ods.Eloqua_WebActivity_CRM_Stage
--FROM (

--SELECT * FROM #PromoURL
--UNION
--SELECT * FROM #PremiumTicketTypeCriteria
--UNION
--SELECT * FROM #FormSubmissionWebVisitDates
--)x
--GROUP BY x.SSB_CRMSYSTEM_CONTACT_ID,x.CreatedAt,x.WebActivity
--GO









-----------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------------------





SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID, C.ID
INto #WebVisitDate
FROM ducks.[ods].[Eloqua_ActivityWebVisit] wv
JOIN ducks.[ods].[Eloqua_Contact] c
	ON wv.ContactId = c.ID
JOIN ducks.dbo.dimcustomerssbid ssbid
	ON ssbid.ssid = c.id AND ssbid.SourceSystem = 'Eloqua'
WHERE 1=1 --wv.CreatedAt >= (GETDATE() - 30)



SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.ID
INTO   #TicketTypeCriteria
FROM Ducks.dbo.FactTicketSales_V2 fts
	JOIN ducks.dbo.DimTicketCustomer_V2 t
		ON t.dimticketcustomerID = fts.DimTicketCustomerId
	JOIN ducks.dbo.DimCustomer d
		ON CAST(d.AccountId AS NVARCHAR(255)) = t.ETL__SSID AND d.SourceSystem = t.ETL__SourceSystem AND d.CustomerType = 'Primary'
	JOIN ducks.dbo.dimcustomerssbid ssbid
		ON ssbid.DimCustomerId = d.DimCustomerId
	JOIN #WebVisitDate wv
		ON wv.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
	JOIN Ducks.dbo.DimDate dd
		ON dd.DimDateId = fts.DimDateId
	JOIN ducks.dbo.DimTicketType_V2 tt
		ON tt.DimTicketTypeId = fts.DimTicketTypeId
	WHERE 1=1 --dd.CalDate >= (GETDATE() - 30)
	AND fts.DimTicketTypeId NOT IN (2,3,4,9)
	AND (d.EmailPrimary NOT LIKE '%@anaheimducks.com' 
		OR d.EmailPrimary NOT LIKE '%@hondacenter.com' 
		OR d.EmailPrimary NOT LIKE '%@the-rinks.com' 
		OR d.EmailPrimary NOT LIKE '%@ticketexchangebyticketmaster.com'
		OR d.EmailPrimary NOT LIKE '%@ticketmaster.com'
		OR  d.EmailPrimary NOT LIKE '%@hsventures.org')
	AND d.AddressPrimaryStreet <> '2695 E Katella Ave'
		AND d.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')




SELECT  ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.CreatedAt, CONCAT('Ticket',+ ': ',+ wv.FirstPageViewUrl) AS WebActivity
INTO #Eloqua_Ticket_Information
FROM #TicketTypeCriteria tt
JOIN ducks.[ods].[Eloqua_Contact] c
	ON C.Id = TT.id
JOIN ducks.[ods].[Eloqua_ActivityWebVisit] wv
	ON wv.ContactId = c.ID
JOIN ducks.dbo.dimcustomerssbid ssbid
	ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = tt.SSB_CRMSYSTEM_CONTACT_ID
WHERE wv.firstpageviewurl IN ('https://www.nhl.com/ducks/tickets/season-tickets'
,'https://www.nhl.com/ducks/tickets/seating-map-pricing'
,'https://www.nhl.com/ducks/tickets/dedication-program'
,'https://www.nhl.com/ducks/tickets/request-more-ticketing-info'
,'https://www.nhl.com/ducks/tickets/mini-plans'
,'https://www.nhl.com/ducks/tickets/mini-plans/weekend'
,'https://duckshondacenter.formstack.com/forms/13gameweekendplan_201718'
,'https://www.nhl.com/ducks/tickets/mini-plans/15-game-pick-em'
,'https://duckshondacenter.formstack.com/forms/15gamepickemplan201718'
,'https://www.nhl.com/ducks/tickets/mini-plans/12-game-gold'
,'https://duckshondacenter.formstack.com/forms/12gamegoldplan_201718'
,'https://www.nhl.com/ducks/tickets/mini-plans/12-game-orange'
,'https://duckshondacenter.formstack.com/forms/12gameorangeplan_201718 '
,'https://www.nhl.com/ducks/tickets/mini-plans/22-game-half-season'
,'https://duckshondacenter.formstack.com/forms/22gamehalfseasonplan_201718'
,'https://www.nhl.com/ducks/tickets/miniplans-24gamepickem'
,'https://duckshondacenter.formstack.com/forms/24gamepickemplan201718'
,'https://www.nhl.com/ducks/tickets/partial-sth-terms-and-conditions'
,'https://www.nhl.com/ducks/tickets/micro-plans'
,'https://duckshondacenter.formstack.com/forms/hall_of_fame_pack'
,'https://duckshondacenter.formstack.com/forms/hall_of_fame_flex_plan'
,'https://www.nhl.com/ducks/tickets/group-opportunities'
,'https://www.nhl.com/ducks/tickets/group-seating'
,'https://www.nhl.com/ducks/tickets/group-theme-nights-2017-18'
,'https://www.nhl.com/ducks/tickets/group-tickets-fundraising'
,'https://www.nhl.com/ducks/tickets/group-tickets-faqs'
,'https://www.nhl.com/ducks/tickets/request-more-group-information')
and 1=1 --wv.createdat >= (GETDATE() - 30)
GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID,wv.CreatedAt,wv.FirstPageViewUrl







--------------------------------Eloqu Promotional Infomration----------------------------------------------------------------------------------------------------------------------------------

SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID, C.ID
INTO  #PromoWebVisitDate
FROM ducks.[ods].[Eloqua_ActivityWebVisit] wv
JOIN ducks.[ods].[Eloqua_Contact] c
	ON wv.ContactId = c.ID
JOIN ducks.dbo.dimcustomerssbid ssbid
	ON ssbid.ssid = c.id AND ssbid.SourceSystem = 'Eloqua'
WHERE 1=1 --wv.CreatedAt >= (GETDATE() - 30)



SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.ID
INTO #PromoTicketTypeCriteria
FROM Ducks.dbo.FactTicketSales_V2 fts
	JOIN ducks.dbo.DimTicketCustomer_V2 t
		ON t.dimticketcustomerID = fts.DimTicketCustomerId
	JOIN ducks.dbo.DimCustomer d
		ON CAST(d.AccountId AS NVARCHAR(255)) = t.ETL__SSID AND d.SourceSystem = t.ETL__SourceSystem AND d.CustomerType = 'Primary'
	JOIN ducks.dbo.dimcustomerssbid ssbid
		ON ssbid.DimCustomerId = d.DimCustomerId
	JOIN #PromoWebVisitDate wv
		ON wv.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
	JOIN Ducks.dbo.DimDate dd
		ON dd.DimDateId = fts.DimDateId
	JOIN ducks.dbo.DimTicketType_V2 tt
		ON tt.DimTicketTypeId = fts.DimTicketTypeId
	WHERE 1=1 -- dd.CalDate >= (GETDATE() - 30)
	AND fts.DimTicketTypeId NOT IN (2,3,4,9) 
	AND (d.EmailPrimary NOT LIKE '%@anaheimducks.com' 
		OR d.EmailPrimary NOT LIKE '%@hondacenter.com' 
		OR d.EmailPrimary NOT LIKE '%@the-rinks.com' 
		OR d.EmailPrimary NOT LIKE '%@ticketexchangebyticketmaster.com'
		OR d.EmailPrimary NOT LIKE '%@ticketmaster.com'
		OR d.EmailPrimary NOT LIKE '%@hsventures.org')
	AND d.AddressPrimaryStreet <> '2695 E Katella Ave'
		AND d.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')


SELECT  ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.createdat, CONCAT('Promotional',+ ': ',+ wv.FirstPageViewUrl) AS WebActivity
INTO   #PromoURL
FROM #TicketTypeCriteria tt
JOIN ducks.[ods].[Eloqua_Contact] c
	ON C.Id = TT.id
JOIN ducks.[ods].[Eloqua_ActivityWebVisit] wv
	ON wv.ContactId = c.ID
JOIN ducks.dbo.dimcustomerssbid ssbid
	ON ssbid.SSB_CRMSYSTEM_CONTACT_ID = tt.SSB_CRMSYSTEM_CONTACT_ID
WHERE (wv.firstpageviewurl IN('https://www.nhl.com/ducks/tickets/promo-packs'
,'https://www.nhl.com/ducks/schedule/2017-10-01/PT'
,'https://www.nhl.com/ducks/schedule/2017-10-01/PT/list'
,'https://www.nhl.com/ducks/schedule/2017-11-01/PT'
,'https://www.nhl.com/ducks/schedule/2017-11-01/PT/list'
,'https://www.nhl.com/ducks/schedule/2017-12-01/PT'
,'https://www.nhl.com/ducks/schedule/2017-12-01/PT/list'
,'https://www.nhl.com/ducks/schedule/2018-01-01/PT'
,'https://www.nhl.com/ducks/schedule/2018-01-01/PT/list'
,'https://www.nhl.com/ducks/schedule/2018-02-01/PT'
,'https://www.nhl.com/ducks/schedule/2018-02-01/PT/list'
,'https://www.nhl.com/ducks/schedule/2018-03-01/PT'
,'https://www.nhl.com/ducks/schedule/2018-03-01/PT/list'
,'https://www.nhl.com/ducks/schedule/2018-04-01/PT'
,'https://www.nhl.com/ducks/schedule/2018-04-01/PT/list'
,'https://www.nhl.com/ducks/fans/promo-schedule'
,'https://www.nhl.com/ducks/tickets'
,'https://www.nhl.com/ducks/tickets/single-game-tickets'
,'https://www1.ticketmaster.com/'
,'https://www.ticketmaster.com/ ')
OR (wv.firstpageviewurl LIKE '%Ticketmaster.com%' AND (wv.firstpageviewurl LIKE '%did=beer%' OR wv.firstpageviewurl LIKE '%did=soda%')))
AND 1=1 --wv.CreatedAt >= (GETDATE() - 30)

GROUP BY ssbid.SSB_CRMSYSTEM_CONTACT_ID,wv.CreatedAt,wv.FirstPageViewUrl








--------------------------------Eloqua Premium Infomration----------------------------------------------------------------------------------------------------------------------------------

SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.CreatedAt,wv.firstpageviewurl
INTO   #PremiumWebVisitDate
FROM ducks.[ods].[Eloqua_ActivityWebVisit] wv
JOIN ducks.[ods].[Eloqua_Contact] c
	ON wv.ContactId = c.ID
JOIN ducks.dbo.dimcustomerssbid ssbid
	ON ssbid.ssid = c.id AND ssbid.SourceSystem = 'Eloqua'
WHERE 1=1 --wv.CreatedAt >= (GETDATE() - 30)
and wv.firstpageviewurl IN('http://www.hondacenter.com/premium-seating/luxury-suites/'
,'http://www.hondacenter.com/premium-seating/club-seats/'
,'http://www.hondacenter.com/premium-seating/ducks-rental-suites/'
,'http://www.hondacenter.com/premium-seating/premium-perks/'
,'http://www.hondacenter.com/premium-seating/seating-map/')


union

SELECT distinct  ssbid.SSB_CRMSYSTEM_CONTACT_ID,  fs.CreatedAt, fs.assetname
FROM ducks.ods.Eloqua_ActivityFormSubmit fs
JOIN ducks.[ods].[Eloqua_Contact] c
	ON fs.ContactId = c.ID
JOIN ducks.dbo.dimcustomerssbid ssbid
	ON ssbid.ssid = c.id AND ssbid.SourceSystem = 'Eloqua'
WHERE 1=1 --fs.CreatedAt >= (GETDATE() - 30)
AND fs.assetname IN('Ducks_BetweenBenches_Interest_2017.09.15' ,'Ducks_SuiteMiniPlans_2017.08.16') --need to add in the form submittes associated to the URLs below
--,'http://www.hondacenter.com/premium-seating/premium-seating-experience'
--,'http://www.hondacenter.com/premium-seating/my-account/')




SELECT DISTINCT  ssbid.SSB_CRMSYSTEM_CONTACT_ID, wv.createdat, CONCAT('Premium',+ ': ',+ wv.FirstPageViewUrl) AS WebActivity
INTO   #PremiumTicketTypeCriteria
FROM Ducks.dbo.FactTicketSales_V2 fts
	JOIN ducks.dbo.DimTicketCustomer_V2 t
		ON t.dimticketcustomerID = fts.DimTicketCustomerId
	JOIN ducks.dbo.DimCustomer d
		ON CAST(d.AccountId AS NVARCHAR(255)) = t.ETL__SSID AND d.SourceSystem = t.ETL__SourceSystem AND d.CustomerType = 'Primary'
	JOIN ducks.dbo.dimcustomerssbid ssbid
		ON ssbid.DimCustomerId = d.DimCustomerId
	JOIN #PremiumWebVisitDate wv
		ON wv.SSB_CRMSYSTEM_CONTACT_ID = ssbid.SSB_CRMSYSTEM_CONTACT_ID
	JOIN Ducks.dbo.DimDate dd
		ON dd.DimDateId = fts.DimDateId
	JOIN ducks.dbo.DimTicketType_V2 tt
		ON tt.DimTicketTypeId = fts.DimTicketTypeId
	WHERE 1=1 -- dd.CalDate >= (GETDATE() - 30)
	AND fts.DimTicketTypeId NOT IN (2,4)
	AND (d.EmailPrimary NOT LIKE '%@anaheimducks.com' 
		OR d.EmailPrimary NOT LIKE '%@hondacenter.com' 
		OR d.EmailPrimary NOT LIKE '%@the-rinks.com' 
		OR d.EmailPrimary NOT LIKE '%@ticketexchangebyticketmaster.com'
		OR d.EmailPrimary NOT LIKE '%@ticketmaster.com'
		OR  d.EmailPrimary NOT LIKE '%@hsventures.org')
	AND d.AddressPrimaryStreet <> '2695 E Katella Ave'  
		AND d.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')




--------------------------------Eloqua Form Submission----------------------------------------------------------------------------------------------------------------------------------
SELECT DISTINCT  ssbid.SSB_CRMSYSTEM_CONTACT_ID, fs.CreatedAt, CONCAT('Form', + ': ', + fs.AssetName) AS WebActivty
INTO   #FormSubmissionWebVisitDate
FROM ducks.[ods].[Eloqua_ActivityFormSubmit] fs
JOIN ducks.[ods].[Eloqua_Contact] c
	ON fs.ContactId = c.ID
JOIN ducks.dbo.vwDimCustomer_ModAcctId ssbid
	ON ssbid.ssid = c.id AND ssbid.SourceSystem = 'Eloqua'
WHERE 1=1 --fs.CreatedAt >= (GETDATE() - 30)
AND fs.AssetName = 'Ducks_Schedule_Relase_Boost_TicketInterest_2017.06.22'
AND (ssbid.EmailPrimary NOT LIKE '%@anaheimducks.com' 
	OR ssbid.EmailPrimary NOT LIKE '%@hondacenter.com' 
	OR ssbid.EmailPrimary NOT LIKE '%@the-rinks.com' 
	OR ssbid.EmailPrimary NOT LIKE '%@ticketexchangebyticketmaster.com'
	OR ssbid.EmailPrimary NOT LIKE '%@ticketmaster.com'
	OR  ssbid.EmailPrimary NOT LIKE '%@hsventures.org')
AND ssbid.AddressPrimaryStreet <> '2695 E Katella Ave'
	AND SSBID.PhonePrimary NOT IN('(714) 940-2900','(877) 945-3946')







SELECT  DISTINCT  SSB_CRMSYSTEM_CONTACT_ID, CreatedAt, WebActivity
INTO ods.Eloqua_WebActivity_CRM_Stage
FROM (

SELECT * FROM #PromoURL
UNION
SELECT * FROM #PremiumTicketTypeCriteria
UNION
SELECT * FROM #FormSubmissionWebVisitDate
UNION
SELECT * FROM #Eloqua_Ticket_Information
)x
GROUP BY x.SSB_CRMSYSTEM_CONTACT_ID,x.CreatedAt,x.WebActivity
GO
