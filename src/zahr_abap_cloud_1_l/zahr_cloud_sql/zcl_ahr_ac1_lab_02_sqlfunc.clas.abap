CLASS zcl_ahr_ac1_lab_02_sqlfunc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.
    METHODS Numeric_Functions              IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Concatenation_Functions        IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Functions_Character_Strings    IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Functions_Dates                IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Functions_Timestamp            IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Functions_Time_Zone            IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Conversions_Dates_Timestamps   IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Conversions_Amounts_Quantities IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Extensions_Date_Properties     IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Universal_Unique_Identifier    IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_02_sqlfunc IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    numeric_functions( io_out = out ).
    Concatenation_Functions( io_out = out ).
    Functions_Character_Strings( io_out = out ).
    Functions_Dates( io_out = out ).
    Functions_Timestamp( io_out = out ).
    Functions_Time_Zone( io_out = out ).
    Conversions_Dates_Timestamps( io_out = out ).
    Conversions_Amounts_Quantities( io_out = out ).
    Extensions_Date_Properties( io_out = out ).
    Universal_Unique_Identifier( io_out = out ).

  ENDMETHOD.

  METHOD numeric_functions.

    io_out->write( |{ cl_abap_char_utilities=>newline } numeric_functions| ).

    " Numerical functions
    SELECT SINGLE FROM /dmo/flight
      FIELDS carrier_id,
             connection_id,
             flight_date,
             price,
             seats_max,
             seats_occupied,
             CAST( price AS FLTP ) / CAST( seats_max AS FLTP ) AS ratio,
             division( price, seats_max, 2 )                   AS division,
             div( seats_max, seats_occupied )                  AS div,
             mod( seats_max, seats_occupied )                  AS mod,
             abs( seats_max - seats_occupied )                 AS abs,
             ceil( price )                                     AS ceil,
             floor( price )                                    AS floor,
             round( price, 2 )                                 AS round
      WHERE carrier_id = 'LH' AND connection_id = '400'
      INTO @DATA(ls_result).

    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD concatenation_functions.

    io_out->write( |{ cl_abap_char_utilities=>newline } concatenation_functions| ).

    SELECT SINGLE FROM /dmo/carrier
      FIELDS carrier_id,
             name,
             concat( name, 'Airlines' )               AS full_name,
             concat_with_space( name, 'Airlines', 1 ) AS full_name_with_space,
             name && ' Airlines'                      AS full_name_ampersand
      WHERE carrier_id = 'AA'
      INTO @DATA(ls_result).

    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD functions_character_strings.

    io_out->write( |{ cl_abap_char_utilities=>newline } functions_character_strings| ).

    " Functions for Character Strings
    SELECT SINGLE FROM /dmo/flight
      FIELDS carrier_id,
             connection_id,
             flight_date,
             left( carrier_id, 2 )             AS left_id,
             right( carrier_id, 2 )            AS right_id,
             lpad( carrier_id, 5, '0' )        AS lpad_id,
             rpad( carrier_id, 5, '0' )        AS rpad_id,
             ltrim( carrier_id, 'L' )          AS ltrim_id,
             rtrim( carrier_id, 'H' )          AS rtrim_id,
             instr( carrier_id, 'LH' )         AS instr_id,
             substring( carrier_id, 1, 2 )     AS substring_id,
             length( carrier_id )              AS length_id,
             replace( carrier_id, 'LH', 'XX' ) AS replace_id,
             lower( carrier_id )               AS lower_id,
             upper( carrier_id )               AS upper_id
      WHERE carrier_id = 'LH'
      INTO @DATA(ls_result).

    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD functions_dates.

    io_out->write( |{ cl_abap_char_utilities=>newline } functions_dates| ).

    " Functions for Dates
    SELECT SINGLE FROM /dmo/flight
      FIELDS carrier_id,
             connection_id,
             flight_date,
             dats_is_valid( flight_date )                  AS valid_date,
             dats_add_days( flight_date, 30 )              AS date_plus_30,
             dats_days_between( flight_date, flight_date ) AS days_between,
             dats_add_months( flight_date, -2 )            AS date_minus_2_months
      WHERE carrier_id = 'LH' AND connection_id = '400'
      INTO @DATA(ls_result).

    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD functions_timestamp.

    io_out->write( |{ cl_abap_char_utilities=>newline } functions_timestamp| ).

    DATA lt_temp_flights TYPE zahr_temp_flight.

    " Functions for Timestamp
    GET TIME STAMP FIELD DATA(lv_timestamp).

    " Insert data into temporary table
    lt_temp_flights = VALUE #( client = 100
                               carrier_id = 'SQ'
                               connection_id = '0001'
                               flight_date = cl_abap_context_info=>get_system_date( )
                               time = lv_timestamp ).

    INSERT zahr_temp_flight FROM @lt_temp_flights.
    TRY.
        SELECT SINGLE
          FROM zahr_temp_flight
        FIELDS carrier_id,
               connection_id,
               flight_date,
               tstmp_is_valid( time ) AS valid_timestamp,
               tstmp_seconds_between( tstmp1 = tstmp_current_utctimestamp( ),
                                      tstmp2 = tstmp_add_seconds( tstmp = time,
                                     seconds = CAST( 60 AS DEC( 15,0 ) ) ),
                                    on_error = @sql_tstmp_seconds_between=>set_to_null ) AS seconds_between
        INTO @DATA(ls_result).

      CATCH cx_sy_open_sql_db INTO DATA(lx_sqldb).
        io_out->write( lx_sqldb->get_text( ) ).
        RETURN.
    ENDTRY.
    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD functions_time_zone.

    io_out->write( |{ cl_abap_char_utilities=>newline } functions_time_zone| ).

    " Functions for Time Use
    SELECT SINGLE FROM /dmo/flight
      FIELDS carrier_id,
             connection_id,
             flight_date,
             abap_user_timezone( on_error = @sql_abap_user_timezone=>set_to_null )     AS user_timezone,
             abap_system_timezone( on_error = @sql_abap_system_timezone=>set_to_null ) AS system_timezone
      WHERE carrier_id = 'LH' AND connection_id = '400'
      INTO @DATA(ls_result).

    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD conversions_dates_timestamps.

    io_out->write( |{ cl_abap_char_utilities=>newline } conversions_dates_timestamps| ).

    DATA lv_tzone TYPE timezone.
    DATA lv_time  TYPE t.

    " Conversions – Dates and Timestamps
    TRY.
        lv_tzone = cl_abap_context_info=>get_user_time_zone( ).
        lv_time = cl_abap_context_info=>get_system_time( ).
      CATCH cx_abap_context_info_error.
        RETURN.
    ENDTRY.
    SELECT SINGLE FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           flight_date,
           tstmp_current_utctimestamp( )                            AS current_utc,
           tstmp_to_tims( tstmp = tstmp_current_utctimestamp( ),
                          tzone = @lv_tzone )                       AS to_tims,
           tstmp_to_dst( tstmp = tstmp_current_utctimestamp( ),
                         tzone = @lv_tzone )                        AS to_dst,
           dats_tims_to_tstmp( date  = flight_date,
                               time  = @lv_time,
                               tzone = @lv_tzone )                  AS to_tstmp
     WHERE carrier_id = 'LH' AND connection_id = '400'
      INTO @DATA(ls_result).

    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD conversions_amounts_quantities.

    io_out->write( |{ cl_abap_char_utilities=>newline } conversions_amounts_quantities| ).

    DATA lv_cucky TYPE /dmo/currency_code.

    lv_cucky = 'EUR'.

    " Conversions – Amounts and Quantities
    TRY.
        SELECT SINGLE FROM /dmo/flight
          FIELDS carrier_id,
                 connection_id,
                 flight_date,
                 price,
                 currency_conversion( amount             = price,
                                      source_currency    = currency_code,
                                      target_currency    = @lv_cucky,
                                      exchange_rate_date = @( cl_abap_context_info=>get_system_date( ) ),
                                      round              = 'X' ) AS converted_amount,
                 'USD' AS converted_currency
          WHERE carrier_id = 'LH' AND connection_id = '0400'
          INTO @DATA(ls_result).
      CATCH cx_sy_open_sql_db INTO DATA(lx_open_sql_db).

    ENDTRY.

    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD extensions_date_properties.

    io_out->write( |{ cl_abap_char_utilities=>newline } extensions_date_properties| ).

    " Extractions - Properties Dates
    SELECT SINGLE FROM /dmo/flight
      FIELDS carrier_id,
             connection_id,
             flight_date,
             extract_year( flight_date )  AS year,
             extract_month( flight_date ) AS month,
             extract_day( flight_date )   AS day
      WHERE carrier_id = 'LH' AND connection_id = '400'
      INTO @DATA(ls_result).

    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

  METHOD universal_unique_identifier.

    io_out->write( |{ cl_abap_char_utilities=>newline } universal_unique_identifier| ).

    " UUID – Universal Unique Identifier
    DELETE FROM zahr_spfli.

    INSERT zahr_spfli FROM ( SELECT FROM /dmo/flight
                             FIELDS "uuid( ) AS id,
                                    carrier_id,
                                    currency_code ).

    SELECT FROM zahr_spfli
    FIELDS *
      INTO TABLE @DATA(ls_result).
    " Display results
    IF ls_result IS NOT INITIAL.
      io_out->write( ls_result ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
