CLASS zcl_ahr_ac1_lab_10_multiquery DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

* Interface, types and method declarations
    INTERFACES if_amdp_marker_hdb .

    TYPES: BEGIN OF ty_structure,
             id(2)           TYPE n,
             datasource1(15) TYPE c,
             datasource2(15) TYPE c,
           END OF ty_structure,
           ty_table TYPE TABLE OF ty_structure.

    CLASS-METHODS full_join AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
      EXPORTING VALUE(et_results) TYPE ty_table.

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS AS_Alias IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Subquery IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Subquery_ALL IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Subquery_ANY_SOME IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Subquery_EXISTS IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Subquery_IN IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS inner_join IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS left_outer_join IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS right_outer_join IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS left_right_excluding_join IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS cross_join IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS full_outer_join IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS insert_datasources_join IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_10_multiquery IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    insert_datasources_join( io_out = out ).

    as_alias( io_out = out ).
    subquery( io_out = out ).
    Subquery_ALL( io_out = out ).
    Subquery_ANY_SOME( io_out = out ).
    Subquery_EXISTS( io_out = out ).
    Subquery_IN( io_out = out ).
    inner_join( io_out = out ).
    left_outer_join( io_out = out ).
    right_outer_join( io_out = out ).
    left_right_excluding_join( io_out = out ).
    cross_join( io_out = out ).
    full_outer_join( io_out = out ).

  ENDMETHOD.

  METHOD as_alias.
    io_out->write( |{ cl_abap_char_utilities=>newline } as_alias| ).

    SELECT FROM /dmo/carrier
      FIELDS carrier_id AS carrier_code,
             name       AS carrier_name
      INTO TABLE @DATA(lt_carriers).
    IF sy-subrc = 0.
      LOOP AT lt_carriers INTO DATA(ls_carriers).
        io_out->write( |{ ls_carriers-carrier_code } -> { ls_carriers-carrier_name }| ).
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD subquery.

    io_out->write( |{ cl_abap_char_utilities=>newline } subquery| ).

    SELECT FROM /dmo/flight
    FIELDS plane_type_id
     WHERE price GT ( SELECT FROM /dmo/flight FIELDS MIN( price ) )
    INTO TABLE @DATA(lt_flights).
    IF sy-subrc EQ 0.
      io_out->write( lt_flights ).
    ENDIF.

  ENDMETHOD.

  METHOD subquery_all.

    io_out->write( |{ cl_abap_char_utilities=>newline } subquery_all| ).

    SELECT FROM /dmo/flight
    FIELDS connection_id
     WHERE seats_occupied GT ALL ( SELECT FROM /dmo/flight
                                   FIELDS seats_occupied
                                    WHERE currency_code EQ 'EUR' )
      INTO TABLE @DATA(lt_airports).
    IF sy-subrc EQ 0.
      io_out->write( |{ sy-dbcnt } records were consulted| ).
    ENDIF.

  ENDMETHOD.

  METHOD subquery_any_some.

    io_out->write( |{ cl_abap_char_utilities=>newline } subquery_any_some| ).

    SELECT FROM /dmo/flight
    FIELDS connection_id
     WHERE seats_max GT ANY ( SELECT FROM /dmo/flight
                              FIELDS seats_max
                               WHERE carrier_id EQ 'AA' )
      INTO TABLE @DATA(lt_flights).
    IF sy-subrc EQ 0.
      io_out->write( lt_flights ).
    ENDIF.

  ENDMETHOD.

  METHOD subquery_exists.

    io_out->write( |{ cl_abap_char_utilities=>newline } subquery_exists| ).

    SELECT FROM /dmo/carrier AS a
    FIELDS carrier_id
     WHERE EXISTS ( SELECT FROM /dmo/flight AS f
                    FIELDS carrier_id
                     WHERE f~carrier_id EQ a~carrier_id )
      INTO TABLE @DATA(lt_carrier).
    IF sy-subrc EQ 0.
      io_out->write( lt_carrier ).
    ENDIF.

  ENDMETHOD.

  METHOD subquery_in.

    io_out->write( |{ cl_abap_char_utilities=>newline } subquery_in| ).

    SELECT FROM /dmo/flight
    FIELDS connection_id,
           carrier_id
     WHERE carrier_id IN ('AA', 'DL')
      INTO TABLE @DATA(lt_connection).
    IF sy-subrc EQ 0.
      io_out->write( lt_connection ).
    ENDIF.

  ENDMETHOD.

  METHOD inner_join.

    io_out->write( |{ cl_abap_char_utilities=>newline } inner_join| ).

    SELECT FROM /dmo/flight AS f
     INNER JOIN /dmo/carrier AS c
        ON f~carrier_id EQ c~carrier_id
    FIELDS f~connection_id,
           f~flight_date,
           c~name AS airport_name
      INTO TABLE @DATA(lt_flight_details).
    IF sy-subrc EQ 0.
      IO_out->write( lt_flight_details ).
    ENDIF.

  ENDMETHOD.

  METHOD left_outer_join.

    io_out->write( |{ cl_abap_char_utilities=>newline } left_outer_join| ).

    SELECT FROM /dmo/flight  AS f
      LEFT JOIN /dmo/carrier AS c
        ON f~carrier_id = c~carrier_id
    FIELDS f~connection_id,
           f~flight_date,
           c~name            AS airport_name
      INTO TABLE @DATA(lt_flight_details).
    IF sy-subrc = 0.
      io_out->write( lt_flight_details ).
    ENDIF.

  ENDMETHOD.

  METHOD right_outer_join.

    io_out->write( |{ cl_abap_char_utilities=>newline } right_outer_join| ).

    SELECT
      FROM /dmo/flight AS f
             RIGHT JOIN
               /dmo/carrier AS a ON f~carrier_id = a~carrier_id
      FIELDS f~connection_id,
             f~flight_date,
             a~name          AS airport_name
      INTO TABLE @DATA(lt_flight_details).
    IF sy-subrc = 0.
      io_out->write( lt_flight_details ).
    ENDIF.

  ENDMETHOD.

  METHOD left_right_excluding_join.

    io_out->write( |{ cl_abap_char_utilities=>newline } left_right_excluding_join| ).

    SELECT FROM /dmo/flight
    FIELDS connection_id,
           flight_date
     WHERE carrier_id NOT IN ( SELECT FROM /dmo/carrier
                               FIELDS carrier_id )
      INTO TABLE @DATA(lt_flight_details).
    IF sy-subrc = 0.
      io_out->write( lt_flight_details ).
    ENDIF.

  ENDMETHOD.

  METHOD cross_join.

    io_out->write( |{ cl_abap_char_utilities=>newline } cross_join| ).

    SELECT FROM /dmo/flight AS f
     CROSS JOIN /dmo/carrier AS c
      FIELDS f~connection_id,
             f~flight_date,
             c~name          AS airport_name
      INTO TABLE @DATA(lt_flight_details).
    IF sy-subrc = 0.
      io_out->write( |{ sy-dbcnt } records were consulted| ).
      io_out->write( data = lt_flight_details  name = |lt_flight_details| ).
    ENDIF.

  ENDMETHOD.

  METHOD full_outer_join.

    io_out->write( |{ cl_abap_char_utilities=>newline } full_outer_join| ).

    DATA lt_full_results TYPE ty_table.
    zcl_ahr_ac1_lab_10_multiquery=>full_join( IMPORTING et_results =
    lt_full_results ).
    IF sy-subrc EQ 0.
      io_out->write( lt_full_results ).
    ENDIF.

  ENDMETHOD.

  METHOD full_join BY DATABASE PROCEDURE FOR HDB
                   LANGUAGE SQLSCRIPT
                   OPTIONS READ-ONLY
                   USING z_i_datasource1
                         z_i_datasource2.

    et_results = select db1.id, db1.datasource1, db2.datasource2
                   FROM z_i_datasource1 as db1
                   FULL OUTER JOIN z_i_datasource2 as db2
                     on db1.id = db2.id
                  WHERE db1.id is not null
                  ORDER BY db1.id;


  ENDMETHOD.

  METHOD insert_datasources_join.

    DELETE FROM: zdatasource_1,
                 zdatasource_2,
                 zdatasource_3.

    INSERT zdatasource_1 FROM TABLE @( VALUE #( ( id = 01 name1 = |One|   datasource1 = |datasource1| )
                                                ( id = 02 name1 = |Two|   datasource1 = |datasource1| )
                                                ( id = 03 name1 = |Three| datasource1 = |datasource1| )
                                                ( id = 04 name1 = |Four|  datasource1 = |datasource1| )
                                                ( id = 05 name1 = |Five|  datasource1 = |datasource1| ) ) ).

    INSERT zdatasource_2 FROM TABLE @( VALUE #( ( id = 02 name2 = |Two|   datasource2 = |datasource2| )
                                                ( id = 03 name2 = |Three| datasource2 = |datasource2| )
                                                ( id = 06 name2 = |Six|   datasource2 = |datasource2| )
                                                ( id = 07 name2 = |Seven| datasource2 = |datasource2| )
                                                ( id = 08 name2 = |Eight| datasource2 = |datasource2| ) ) ).

    INSERT zdatasource_3 FROM TABLE @( VALUE #( ( id = 03 name3 = |Three|  datasource3 = |datasource3| )
                                                ( id = 08 name3 = |Eight|  datasource3 = |datasource3| )
                                                ( id = 09 name3 = |Nine|   datasource3 = |datasource3| )
                                                ( id = 10 name3 = |Ten|    datasource3 = |datasource3| )
                                                ( id = 11 name3 = |Eleven| datasource3 = |datasource3| ) ) ).

  ENDMETHOD.

ENDCLASS.
