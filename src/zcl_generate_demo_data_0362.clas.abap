CLASS zcl_generate_demo_data_0362 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_GENERATE_DEMO_DATA_0362 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  "Delete entries
  delete from zrap_atrav_0362.
  delete from zrap_abook_0362.

  "Insert travel data
  insert zrap_atrav_0362 from (
   select from /dmo/travel
   fields
   uuid( ) as travel_uuid,
   travel_id as travel_id,
   agency_id as agency_id,
   customer_id as customer_id,
   begin_date as begin_date,
   end_date as end_date,
   booking_fee as booking_fee,
   total_price as total_price,
   currency_code as currency_code,
   description as description,
   case status
     when 'B' then 'A'
     when 'X' then 'X'
     else 'O'
   end as overall_status,
   createdby as created_by,
   createdat as created_at,
   lastchangedby as last_changed_by,
   lastchangedat as last_changed_at,
   lastchangedat as local_last_changed_at
   order by travel_id up to 200 rows

   ).

   COMMIT work.

   "Insert booking data
   insert zrap_abook_0362 from (
   select from /dmo/booking as booking
   join zrap_atrav_0362 as z
   on booking~travel_id = z~travel_id
   fields
   uuid( ) as booking_uuid,
   z~travel_uuid as travel_uuid,
   booking~booking_id as booking_id,
   booking~booking_date as booking_date,
   booking~customer_id as customer_id,
   booking~carrier_id as carrier_id,
   booking~connection_id as connection_id,
   booking~flight_date as flight_date,
   booking~flight_price as flight_price,
   booking~currency_code as currency_code,
   z~created_by as created_by,
   z~last_changed_by as last_changed_by,
   z~last_changed_at as local_last_changed_at
   ).
   COMMIT work.
   out->write( 'Travel data generated successfully!' ).
  ENDMETHOD.
ENDCLASS.
