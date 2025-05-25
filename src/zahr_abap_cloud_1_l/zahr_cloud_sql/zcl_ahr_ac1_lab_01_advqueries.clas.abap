CLASS zcl_ahr_ac1_lab_01_advqueries DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS InLine_declaration      IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Specifying_columns      IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Host_Variables          IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Case                    IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Global_Temporary_Tables IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS SubQuery_WITH           IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS SubQuery_Ins_Mod        IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Database_Hits           IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Union                   IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Intersect               IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Except                  IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_01_advqueries IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    inline_declaration( io_out = out ).
    specifying_columns( io_out = out ).
    Host_Variables( io_out = out ).
    Case( io_out = out ).
    Global_Temporary_Tables( io_out = out ).
    SubQuery_WITH( io_out = out ).
    SubQuery_Ins_Mod( io_out = out ).
    Database_Hits( io_out = out ).
    Union( io_out = out ).
    Intersect( io_out = out ).
    Except( io_out = out ).

  ENDMETHOD.

  METHOD inline_declaration.

    io_out->write( |{ cl_abap_char_utilities=>newline } inline_declaration| ).

    SELECT FROM /dmo/flight
    FIELDS *
     WHERE price GT 500
      INTO TABLE @DATA(lt_flights).

    IF sy-subrc = 0.
      io_out->write( data = lt_flights name = |lt_flights| ).
    ENDIF.

  ENDMETHOD.

  METHOD specifying_columns.

    io_out->write( |{ cl_abap_char_utilities=>newline } specifying_columns| ).

    SELECT FROM /DMO/Flight
    FIELDS carrier_id,
           connection_id
     WHERE price GT 500
      INTO TABLE @DATA(lt_flights).

    IF sy-subrc = 0.
      io_out->write( data = lt_flights name = |lt_flights| ).
    ENDIF.

  ENDMETHOD.

  METHOD host_variables.

    io_out->write( |{ cl_abap_char_utilities=>newline } host_variables| ).

    DATA:
      lv_price   TYPE /dmo/flight_price VALUE 500,
      lv_carrier TYPE /dmo/carrier_id   VALUE 'LH'.

    SELECT FROM /dmo/flight
    FIELDS *
     WHERE carrier_id EQ @lv_carrier
       AND price      GT @lv_price
      INTO TABLE @DATA(lt_flights).

    IF sy-subrc = 0.
      io_out->write( data = lt_flights name = |lt_flights| ).
    ENDIF.

  ENDMETHOD.

  METHOD case.

    io_out->write( |{ cl_abap_char_utilities=>newline } case| ).

    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price,
           CASE WHEN price <  500 THEN 'Low cost'
                WHEN price >= 500 AND price <= 1000 THEN 'Medium Cost'
                WHEN price > 1000 THEN 'High Cost'
                ELSE 'Outside the category'
           END AS price_category
     WHERE currency_code = 'USD'
      INTO TABLE @DATA(lt_flights).

    IF sy-subrc = 0.
      io_out->write( data = lt_flights name = |lt_flights| ).
    ENDIF.

  ENDMETHOD.

  METHOD global_temporary_tables.

    io_out->write( |{ cl_abap_char_utilities=>newline } global_temporary_tables| ).

    DATA lt_temp_flight TYPE STANDARD TABLE OF zahr_temp_flight.

    lt_temp_flight = VALUE #( ( carrier_id     = 'SQ'
                                connection_id  = '0001'
                                flight_date    = '20250320'
                                price          = '1000'
                                currency_code  = 'USD'
                                plane_type_id  = '767-200'
                                seats_max      = '70'
                                seats_occupied = '60' ) ).

    INSERT zahr_temp_flight FROM TABLE @lt_temp_flight.

    SELECT FROM zahr_temp_flight
    FIELDS *
      INTO TABLE @DATA(lt_temp_result).
    IF sy-subrc = 0.
      io_out->write( data = lt_temp_result name = |lt_temp_result| ).
    ENDIF.

    " Join temporary table with another table
    SELECT FROM zahr_temp_flight AS sp
     INNER JOIN /dmo/flight AS sf
        ON sp~carrier_id = sf~carrier_id
       AND sp~connection_id = sf~connection_id
    FIELDS sp~carrier_id,
           sp~connection_id,
           sf~price
      INTO TABLE @DATA(lt_joined_result).

    " Display results
    IF lt_joined_result IS NOT INITIAL.
      io_out->write( lt_joined_result ).
    ENDIF.

  ENDMETHOD.

  METHOD subquery_with.

    io_out->write( |{ cl_abap_char_utilities=>newline } subquery_with| ).

    " Define subquery using WITH clause
    WITH +tmp_flights AS ( SELECT FROM /dmo/flight
                           FIELDS carrier_id,
                                  connection_id,
                                  price
                            WHERE price GT 500 )

    SELECT FROM +tmp_flights AS sp
     INNER JOIN /dmo/flight AS sf
        ON sp~carrier_id = sf~carrier_id
       AND sp~connection_id = sf~connection_id
    FIELDS sf~carrier_id, sf~connection_id, sf~price
      INTO TABLE @DATA(lt_data_result).

    " Display results
    IF lt_data_result IS NOT INITIAL.
      io_out->write( lt_data_result ).
    ENDIF.

  ENDMETHOD.

  METHOD subquery_ins_mod.

    io_out->write( |{ cl_abap_char_utilities=>newline } subquery_ins_mod| ).

    " Insert data using subquery
    INSERT zahr_spfli FROM ( SELECT FROM /dmo/carrier
                             FIELDS carrier_id,
                                    name,
                                    currency_code
                              WHERE currency_code EQ 'EUR' ).

    " Select data to verify insertion
    SELECT FROM zahr_spfli
    FIELDS *
      INTO TABLE @DATA(lt_inserted_data).

    " Display results
    IF lt_inserted_data IS NOT INITIAL.
      io_out->write( lt_inserted_data ).
    ENDIF.

  ENDMETHOD.

  METHOD database_hits.

    io_out->write( |{ cl_abap_char_utilities=>newline } database_hits| ).

    " Select flights with database hint
    SELECT FROM /dmo/flight
    FIELDS carrier_id, connection_id, price
   %_HINTS ORACLE 'INDEX(/dmo/flight~carrier_id)'
*   %_HINTS HDB 'INDEX(/dmo/flight~carrier_id)'
      INTO TABLE @DATA(lt_optimized_flights).

    " Display results
    IF lt_optimized_flights IS NOT INITIAL.
      io_out->write( lt_optimized_flights ).
    ENDIF.

  ENDMETHOD.

  METHOD union.

    io_out->write( |{ cl_abap_char_utilities=>newline } union| ).

    " Combine results using UNION
    SELECT FROM /dmo/flight
    FIELDS carrier_id, connection_id, price
     WHERE price LT 4000
     UNION
    SELECT FROM /dmo/flight
    FIELDS carrier_id, connection_id, price
     WHERE price GT 6000
      INTO TABLE @DATA(lt_union_flights).
    " Display results
    IF lt_union_flights IS NOT INITIAL.
      io_out->write( lt_union_flights ).

    ENDIF.

  ENDMETHOD.

  METHOD intersect.

    io_out->write( |{ cl_abap_char_utilities=>newline } intersect| ).

    " Get common rows using INTERSECT
    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
     WHERE price GT 4000
 INTERSECT
    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
     WHERE price LT 6000
      INTO TABLE @DATA(lt_intersect_flights).

    " Display results
    IF lt_intersect_flights IS NOT INITIAL.
      io_out->write( lt_intersect_flights ).
    ENDIF.

  ENDMETHOD.

  METHOD except.

    io_out->write( |{ cl_abap_char_utilities=>newline } except| ).

    " Get rows using EXCEPT
    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
     WHERE price GT 4000
    EXCEPT
    SELECT FROM /dmo/flight
    FIELDS carrier_id,
           connection_id,
           price
    WHERE price GT 6000
    INTO TABLE @DATA(lt_except_flights).
    " Display results
    IF lt_except_flights IS NOT INITIAL.
      io_out->write( lt_except_flights ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
