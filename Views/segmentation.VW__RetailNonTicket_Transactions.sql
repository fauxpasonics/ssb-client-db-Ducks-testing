SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [segmentation].[VW__RetailNonTicket_Transactions] AS


SELECT dt.SSB_CRMSYSTEM_CONTACT_ID,
		rnt.id AS RetailNonTicketID,
       rnt.InsertDate,
       rnt.UpdateDate,
       rnt.event_name,
       rnt.section_name,
       rnt.row_name,
       rnt.first_seat,
       rnt.last_seat,
       rnt.num_seats,
       rnt.seat_increment,
       rnt.retail_system_name,
       rnt.acct_id,
       rnt.retail_event_id,
       rnt.retail_acct_num,
       rnt.retail_acct_add_date,
       rnt.came_from_code,
       rnt.retail_price_level,
       rnt.retail_ticket_type,
       rnt.retail_qualifiers,
       rnt.retail_purchase_price,
       rnt.transaction_datetime,
       rnt.retail_opcode,
       rnt.retail_operator_type,
       rnt.refund_flag,
       rnt.add_user,
       rnt.add_datetime,
       rnt.owner_name,
       rnt.owner_name_full,
       rnt.retail_event_code,
       rnt.event_date,
       rnt.attraction_name,
       rnt.major_category_name,
       rnt.minor_category_name,
       rnt.venue_name,
       rnt.primary_act,
       rnt.secondary_act,
       rnt.event_id,
       rnt.retail_facility_fee,
       rnt.retail_mask,
       rnt.retail_service_charge,
       rnt.retail_face_value,
       rnt.retail_face_value_tax,
       rnt.retail_mop,
       rnt.retail_service_charge_tax,
       rnt.retail_distance_charge,
       rnt.seat_state_from,
       rnt.seat_state_to,
       rnt.seat_state_before,
       rnt.tickets_per_seat
      

FROM ods.TM_RetailNonTicket rnt (NOLOCK)
INNER JOIN dbo.vwDimCustomer_ModAcctId dt
	ON dt.AccountId = rnt.acct_id AND dt.SourceSystem = 'TM' AND dt.CustomerType = 'Primary'
WHERE rnt.acct_id <> -1 AND rnt.acct_id <> -2
AND dt.EmailPrimary <> ''--AND rnt.add_datetime >= (GETDATE()-3)
AND rnt.attraction_name IS NOT NULL 

UNION

SELECT dt.SSB_CRMSYSTEM_CONTACT_ID,
		rnt.id,
       rnt.InsertDate,
       rnt.UpdateDate,
       rnt.event_name,
       rnt.section_name,
       rnt.row_name,
       rnt.first_seat,
       rnt.last_seat,
       rnt.num_seats,
       rnt.seat_increment,
       rnt.retail_system_name,
       rnt.acct_id,
       rnt.retail_event_id,
       rnt.retail_acct_num,
       rnt.retail_acct_add_date,
       rnt.came_from_code,
       rnt.retail_price_level,
       rnt.retail_ticket_type,
       rnt.retail_qualifiers,
       rnt.retail_purchase_price,
       rnt.transaction_datetime,
       rnt.retail_opcode,
       rnt.retail_operator_type,
       rnt.refund_flag,
       rnt.add_user,
       rnt.add_datetime,
       rnt.owner_name,
       rnt.owner_name_full,
       rnt.retail_event_code,
       rnt.event_date,
       rnt.attraction_name,
       rnt.major_category_name,
       rnt.minor_category_name,
       rnt.venue_name,
       rnt.primary_act,
       rnt.secondary_act,
       rnt.event_id,
       rnt.retail_facility_fee,
       rnt.retail_mask,
       rnt.retail_service_charge,
       rnt.retail_face_value,
       rnt.retail_face_value_tax,
       rnt.retail_mop,
       rnt.retail_service_charge_tax,
       rnt.retail_distance_charge,
       rnt.seat_state_from,
       rnt.seat_state_to,
       rnt.seat_state_before,
       rnt.tickets_per_seat
    
FROM ods.TM_RetailNonTicket rnt
INNER JOIN dbo.vwDimCustomer_ModAcctId dt
	ON dt.AccountId = rnt.acct_id AND dt.SourceSystem = 'TM' AND dt.CustomerType = 'Primary'
INNER JOIN[ods].[Honda_Center_Events_Lookup] Hl
	ON rnt.event_date = hl.event_date AND rnt.event_name = hl.event_name
WHERE rnt.acct_id <> -1 AND rnt.acct_id <> -2
AND dt.EmailPrimary <> ''
AND (rnt.attraction_name IS NULL OR rnt.attraction_name = '')
GO
