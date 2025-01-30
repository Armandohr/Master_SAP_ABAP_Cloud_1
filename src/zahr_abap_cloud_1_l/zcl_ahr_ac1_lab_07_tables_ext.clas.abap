CLASS zcl_ahr_ac1_lab_07_tables_ext DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES: BEGIN OF ty_flights,
             iduser     TYPE c LENGTH 40,
             aircode    TYPE /dmo/carrier_id,
             flightnum  TYPE /dmo/connection_id,
             key        TYPE land1,
             seat       TYPE /dmo/plane_seats_occupied,
             flightdate TYPE /dmo/flight_date,
           END OF ty_flights.

    TYPES: BEGIN OF ty_airlines,
             carrid    TYPE /dmo/carrier_id,
             connid    TYPE /dmo/connection_id,
             countryfr TYPE land1,
             airfrom   TYPE /dmo/airport_from_id,
             countryto TYPE land1,
           END OF ty_airlines.

    TYPES: BEGIN OF ty_spfli,
             carrid        TYPE /dmo/carrier_id,
             connid        TYPE /dmo/connection_id,
             flight_date   TYPE /dmo/flight_date,
             airport_from  TYPE /dmo/airport_from_id,
             country_from  TYPE land1,
             city_from     TYPE /dmo/city,
             airport_to    TYPE /dmo/airport_to_id,
             country_to    TYPE land1,
             city_to       TYPE /dmo/city,
             dep_time      TYPE /dmo/flight_departure_time,
             arr_time      TYPE /dmo/flight_arrival_time,
             distance_unit TYPE msehi,
             distance      TYPE /dmo/flight_distance,
           END OF ty_spfli.

    TYPES tt_spfli TYPE STANDARD TABLE OF ty_spfli.

    DATA lt_spfli        TYPE STANDARD TABLE OF ty_spfli.
    DATA ls_spfli        TYPE ty_spfli.
    DATA ls_spfli_2      TYPE ty_spfli.

    DATA lt_my_flights   TYPE STANDARD TABLE OF ty_flights.
    DATA lt_flights_info TYPE STANDARD TABLE OF ty_flights.

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA mt_flights_type TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY.
    DATA mt_airline      TYPE STANDARD TABLE OF /dmo/connection WITH EMPTY KEY.
    DATA lt_final        TYPE SORTED TABLE OF ty_flights WITH NON-UNIQUE KEY aircode.
    DATA mt_scarr        TYPE STANDARD TABLE OF /dmo/carrier WITH EMPTY KEY.
    DATA mt_airlines     TYPE STANDARD TABLE OF ty_airlines.

    METHODS for_method IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS for_nested_method IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS multiple_select IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS sort_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS modify_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS delete_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS clear_free_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS collect_instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS let_instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS base_instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS grouping_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS group_key IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS for_groups IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS range_table IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS enumerations IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_07_tables_ext IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. FOR
    for_method( io_out = out ).

    " 2. FOR Anidado
    for_nested_method( io_out = out ).

    " 3. Añadir múltiples líneas (SELECT)
    multiple_select( io_out = out ).

    " 4. Ordenar registros
    sort_records( io_out = out ).

    " 5. Modificar registros
    modify_records( io_out = out ).

    "6 6.Eliminar registros
    delete_records( io_out = out ).

    "7. clear y free
    clear_free_records( io_out = out ).

    "8. Instrucción COLLECT
    collect_instruction( io_out = out ).

    "9. Instrucción LET
    let_instruction( io_out = out ).

    "10. Instrucción BASE.
    base_instruction( io_out = out ).

    "11. Agrupación de registros.
    grouping_records( io_out = out ).

    "12. Agrupar por clave
    group_key( io_out = out ).

    "13. For Groups
    for_groups( io_out = out ).

    "14. Tablas de rangos
    range_table( io_out = out ).

    "15. Enumeraciones
    enumerations( io_out = out ).

  ENDMETHOD.

  METHOD for_method.

    io_out->write( |for_method| ).

    lt_my_flights = VALUE #( FOR i = 1 WHILE i <= 15
                             ( iduser     = |AHR-{ 1234 + i }|
                               aircode    = |MX|
                               flightnum  = 0000 + i
                               key        = |MXN|
                               seat       = 0 + i
                               flightdate = cl_abap_context_info=>get_system_date( ) ) ).

    io_out->write( data = lt_my_flights
                   name = 'lt_my_flights' ).

    lt_flights_info = VALUE #( FOR ls_my_flight IN lt_my_flights
                               ( iduser     = ls_my_flight-iduser
                                 aircode    = 'CL'
                                 flightnum  = ls_my_flight-flightnum + 10
                                 key        = 'COP'
                                 seat       = ls_my_flight-seat
                                 flightdate = ls_my_flight-flightdate ) ).

    io_out->write( data = lt_flights_info
                   name = 'lt_my_flights' ).

  ENDMETHOD.

  METHOD for_nested_method.

    io_out->write( |for_nested_method| ).

    SELECT FROM /dmo/flight AS fli
    FIELDS fli~*
    ORDER BY PRIMARY KEY
    INTO TABLE @mt_flights_type.

    io_out->write( data = mt_flights_type
                   name = 'mt_flights_type' ).

    SELECT FROM /dmo/connection AS con
    FIELDS con~*
    INTO TABLE @mt_airline.

    io_out->write( data = mt_airline
                   name = 'mt_airline' ).

    lt_final = VALUE #( FOR ls_flight_type IN mt_flights_type WHERE ( carrier_id = 'SQ' )
                        FOR ls_airline IN mt_airline WHERE ( connection_id = ls_flight_type-connection_id )
                        ( iduser     = sy-mandt
                          aircode    = ls_flight_type-carrier_id
                          flightnum  = ls_airline-connection_id
                          key        = ls_airline-airport_from_id
                          seat       = ls_flight_type-seats_occupied
                          flightdate = ls_flight_type-flight_date ) ).

    io_out->write( data = lt_final
                   name = 'lt_final' ).

  ENDMETHOD.

  METHOD multiple_select.

    io_out->write( |multiple_select| ).

    SELECT FROM @mt_airline AS al
     INNER JOIN /dmo/airport AS airf
        ON airf~airport_id = al~airport_from_id
     INNER JOIN /dmo/airport AS airt
        ON airt~airport_id = al~airport_to_id
    FIELDS al~carrier_id AS carrid,
           al~connection_id AS connid,
           airf~country AS countryfr,
           al~airport_from_id AS airfrom,
           airt~country AS countryto
     WHERE al~airport_from_id = 'FRA'
      INTO CORRESPONDING FIELDS OF TABLE @mt_airlines.

    io_out->write( data = mt_airlines
                   name = 'mt_airlines' ).

  ENDMETHOD.

  METHOD sort_records.

    SORT mt_airlines BY connid DESCENDING.

    io_out->write( data = mt_airlines
                   name = 'mt_airlines' ).

  ENDMETHOD.

  METHOD modify_records.

    io_out->write( |modify_records| ).

    SELECT
      FROM /dmo/flight AS fli
             INNER JOIN
               /dmo/connection AS con ON con~carrier_id = fli~carrier_id
                 INNER JOIN
                   /dmo/airport AS airf ON airf~airport_id = con~airport_from_id
                     INNER JOIN
                       /dmo/airport AS airt ON airt~airport_id = con~airport_to_id
      FIELDS fli~carrier_id      AS carrid,
             fli~connection_id   AS connid,
             fli~flight_date,
             con~airport_from_id AS airport_from,
             airf~country        AS country_from,
             airf~city           AS city_from,
             con~airport_to_id   AS airport_to,
             airt~country        AS country_to,
             airt~city           AS city_to,
             con~departure_time  AS dep_time,
             con~arrival_time    AS arr_time,
             con~distance_unit,
             con~distance
      INTO TABLE @DATA(lt_flight).

    lt_spfli = VALUE #( FOR ls_flight IN lt_flight
                        WHERE ( carrid = 'LH' )
                        ( CORRESPONDING #( ls_flight ) ) ).

    io_out->write( data = lt_spfli
                   name = 'lt_spfli' ).

    LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<ls_spfli>) WHERE dep_time > '120000'.

      MODIFY lt_spfli FROM VALUE #( flight_date = cl_abap_context_info=>get_system_date( ) ) TRANSPORTING flight_date.

    ENDLOOP.

    io_out->write( data = lt_spfli
                   name = 'lt_spfli' ).

  ENDMETHOD.

  METHOD delete_records.

    io_out->write( |delete_records| ).

    io_out->write( data = lt_spfli
                   name = 'lt_spfli' ).

    DELETE lt_spfli WHERE city_to = 'Frankfurt/Main'.

    io_out->write( data = lt_spfli
                   name = 'lt_spfli' ).

  ENDMETHOD.

  METHOD clear_free_records.

    io_out->write( |clear_free_records| ).

    io_out->write( data = mt_airlines
                   name = 'mt_airlines' ).

    CLEAR mt_airlines.

    io_out->write( data = mt_airlines
                   name = 'mt_airlines' ).

  ENDMETHOD.

  METHOD collect_instruction.

    io_out->write( |collect_instruction| ).

    TYPES: BEGIN OF lty_seats,
             carrid TYPE /dmo/carrier_id,
             connid TYPE /dmo/connection_id,
             seats  TYPE /dmo/plane_seats_occupied,
             price  TYPE /dmo/flight_price,
           END OF lty_seats.

    DATA lt_seats TYPE HASHED TABLE OF lty_seats WITH UNIQUE KEY carrid connid.
    DATA lt_seats_2 TYPE STANDARD TABLE OF lty_seats.

    SELECT FROM /dmo/flight AS fli
    FIELDS fli~carrier_id,
           fli~connection_id,
           fli~seats_occupied,
           fli~price
      INTO TABLE @lt_seats_2.

    io_out->write( data = lt_seats_2
                   name = 'lt_seats_2' ).

    LOOP AT lt_seats_2 ASSIGNING FIELD-SYMBOL(<ls_seats_2>).
      COLLECT <ls_seats_2> INTO lt_seats.
    ENDLOOP.

    io_out->write( data = lt_seats
                   name = 'lt_seats' ).

  ENDMETHOD.

  METHOD let_instruction.

    io_out->write( |let_instruction| ).

    SELECT FROM /dmo/flight AS fli
    FIELDS fli~*
    INTO TABLE @mt_flights_type.

    SELECT FROM /dmo/carrier AS car
    FIELDS car~*
    INTO TABLE @mt_scarr.

    LOOP AT mt_flights_type ASSIGNING FIELD-SYMBOL(<ls_flights_type>).

      DATA(lv_flights) = CONV string( LET lv_airline_name = mt_scarr[ carrier_id = <ls_flights_type>-carrier_id ]-name
                                          lv_flight_price = mt_flights_type[
                                                                carrier_id    = <ls_flights_type>-carrier_id
                                                                connection_id = <ls_flights_type>-connection_id ]-price
                                          lv_carrier_id   = mt_scarr[
                                                                carrier_id = <ls_flights_type>-carrier_id ]-carrier_id
                                      IN | { lv_carrier_id } / Airline name: { lv_airline_name } / Flight price: { lv_flight_price } | ).

      io_out->write( lv_flights ).

    ENDLOOP.

  ENDMETHOD.

  METHOD base_instruction.

    io_out->write( |base_instruction| ).

    DATA lt_flights_base TYPE STANDARD TABLE OF /dmo/flight.

    lt_flights_base = VALUE #( BASE mt_flights_type
                               ( carrier_id     = 'ZZ'
                                 connection_id  = 9999
                                 flight_date    = cl_abap_context_info=>get_system_date( )
                                 price          = '1234.56'
                                 currency_code  = 'MXN'
                                 plane_type_id  = '123-ASDF'
                                 seats_max      = 300
                                 seats_occupied = 250 ) ).

    lt_flights_base = VALUE #( BASE lt_flights_base ( LINES OF mt_flights_type )
                               ( carrier_id     = 'XX'
                                 connection_id  = 8888
                                 flight_date    = cl_abap_context_info=>get_system_date( )
                                 price          = '1234.56'
                                 currency_code  = 'EUR'
                                 plane_type_id  = '345-ASDF'
                                 seats_max      = 400
                                 seats_occupied = 350 ) ).

    lt_flights_base = CORRESPONDING #( BASE ( lt_flights_base ) mt_flights_type ).

    io_out->write( data = lt_flights_base
                   name = 'lt_flights_base' ).

  ENDMETHOD.

  METHOD grouping_records.
    io_out->write( |grouping_records| ).

    SELECT
       FROM /dmo/flight AS fli
              INNER JOIN
                /dmo/connection AS con ON con~carrier_id = fli~carrier_id
                  INNER JOIN
                    /dmo/airport AS airf ON airf~airport_id = con~airport_from_id
                      INNER JOIN
                        /dmo/airport AS airt ON airt~airport_id = con~airport_to_id
       FIELDS fli~carrier_id      AS carrid,
              fli~connection_id   AS connid,
              fli~flight_date,
              con~airport_from_id AS airport_from,
              airf~country        AS country_from,
              airf~city           AS city_from,
              con~airport_to_id   AS airport_to,
              airt~country        AS country_to,
              airt~city           AS city_to,
              con~departure_time  AS dep_time,
              con~arrival_time    AS arr_time,
              con~distance_unit,
              con~distance
       INTO TABLE @lt_spfli.

    DATA lt_members LIKE lt_spfli.

    LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<ls_spfli>)

        GROUP BY ( country_from = <ls_spfli>-country_from ).

      CLEAR lt_members.

      LOOP AT GROUP <ls_spfli> ASSIGNING FIELD-SYMBOL(<ls_members>).
        lt_members = VALUE #( BASE lt_members ( <ls_members> ) ).
      ENDLOOP.

      io_out->write( data = lt_members
                     name = '<lt_members>' ).
    ENDLOOP.

  ENDMETHOD.

  METHOD group_key.
    io_out->write( |group_key| ).

    SELECT
       FROM /dmo/flight AS fli
              INNER JOIN
                /dmo/connection AS con ON con~carrier_id = fli~carrier_id
                  INNER JOIN
                    /dmo/airport AS airf ON airf~airport_id = con~airport_from_id
                      INNER JOIN
                        /dmo/airport AS airt ON airt~airport_id = con~airport_to_id
       FIELDS fli~carrier_id      AS carrid,
              fli~connection_id   AS connid,
              fli~flight_date,
              con~airport_from_id AS airport_from,
              airf~country        AS country_from,
              airf~city           AS city_from,
              con~airport_to_id   AS airport_to,
              airt~country        AS country_to,
              airt~city           AS city_to,
              con~departure_time  AS dep_time,
              con~arrival_time    AS arr_time,
              con~distance_unit,
              con~distance
       INTO TABLE @lt_spfli.

    DATA lt_members LIKE lt_spfli.

    LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<ls_spfli>)

         GROUP BY ( country_from = <ls_spfli>-country_from
                    airport_from = <ls_spfli>-airport_from ) ASSIGNING FIELD-SYMBOL(<ls_key>).

      CLEAR lt_members.

      LOOP AT GROUP <ls_key> ASSIGNING FIELD-SYMBOL(<ls_members>).
        lt_members = VALUE #( BASE lt_members ( <ls_members> ) ).
      ENDLOOP.

      io_out->write( data = lt_members name = 'lt_members' ).
      io_out->write( data = <ls_key> name = '<ls_key>' ).

    ENDLOOP.

  ENDMETHOD.

  METHOD for_groups.
    io_out->write( |for_groups| ).

    SELECT
       FROM /dmo/flight AS fli
              INNER JOIN
                /dmo/connection AS con ON con~carrier_id = fli~carrier_id
                  INNER JOIN
                    /dmo/airport AS airf ON airf~airport_id = con~airport_from_id
                      INNER JOIN
                        /dmo/airport AS airt ON airt~airport_id = con~airport_to_id
       FIELDS fli~carrier_id      AS carrid,
              fli~connection_id   AS connid,
              fli~flight_date,
              con~airport_from_id AS airport_from,
              airf~country        AS country_from,
              airf~city           AS city_from,
              con~airport_to_id   AS airport_to,
              airt~country        AS country_to,
              airt~city           AS city_to,
              con~departure_time  AS dep_time,
              con~arrival_time    AS arr_time,
              con~distance_unit,
              con~distance
       INTO TABLE @lt_spfli.

    TYPES: lty_spfli LIKE LINE OF lt_spfli,
           ltt_spfli TYPE STANDARD TABLE OF lty_spfli WITH EMPTY KEY.

    TYPES: lty_group_keys TYPE STANDARD TABLE OF /dmo/flight-carrier_id WITH EMPTY KEY.

    io_out->write( VALUE lty_group_keys( FOR GROUPS lv_group OF gs_group IN lt_spfli
                                  GROUP BY gs_group-country_from
                                  DESCENDING
                                  WITHOUT MEMBERS ( lv_group ) ) ).

  ENDMETHOD.

  METHOD range_table.
    io_out->write( |range_table| ).

    DATA lt_range TYPE RANGE OF /dmo/plane_seats_occupied.

    lt_range = VALUE #( ( sign   = 'I'
                          option = 'BT'
                          low    = 200
                          high   = 400 ) ).

    SELECT FROM /dmo/flight AS fli
    FIELDS fli~*
     WHERE fli~seats_occupied IN @lt_range
     ORDER BY fli~seats_occupied
      INTO TABLE @mt_flights_type.

    io_out->write( data = mt_flights_type name = 'mt_flights_type' ).

  ENDMETHOD.

  METHOD enumerations.
    io_out->write( |enumerations| ).

    TYPES: BEGIN OF ENUM mty_currency STRUCTURE currency,
             c_initial VALUE IS INITIAL,
             c_dollar  VALUE 1, "'USD',
             c_euros   VALUE 2, "'EUR',
             c_colpeso VALUE 3, "'COL',
             c_mexpeso VALUE 4, "'MEX',
           END OF ENUM mty_currency STRUCTURE currency.

    DATA: lv_currency TYPE mty_currency.

    lv_currency = currency-c_dollar.
    io_out->write( data = lv_currency name = 'lv_currency' ).

    lv_currency = currency-c_mexpeso.
    io_out->write( data = lv_currency name = 'lv_currency' ).

  ENDMETHOD.

ENDCLASS.
