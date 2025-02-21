CLASS zcl_ahr_ac1_lab_07_tables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_07_TABLES IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    " 1.    Añadir registros
    DATA lt_employees TYPE STANDARD TABLE OF zahr_emp_logali.
    DATA ls_employess TYPE zahr_emp_logali.

    lt_employees = VALUE #( client = sy-mandt
                            ( id     = |{ '1' ALPHA = IN }|
                              email  = to_lower( 'LAURA.PEREZ.JIMENEZ@server.com' )
                              apel   = 'PEREZ'
                              ape2   = 'JIMENEZ'
                              name   = 'LAURA'
                              fechan = '19901020'
                              fechaa = '20101113' ) ).

    ls_employess-client = sy-mandt.
    ls_employess-id     = |{ '3' ALPHA = IN }|.
    ls_employess-email  = to_lower( 'SANDRA.LOPEZ.PEREZ@server.com' ).
    ls_employess-apel   = 'LOPEZ'.
    ls_employess-ape2   = 'PEREZ'.
    ls_employess-name   = 'SANDRA'.
    ls_employess-fechan = '19901020'.
    ls_employess-fechaa = '20111113'.

    APPEND ls_employess TO lt_employees.

    out->write( data = lt_employees
                name = 'Añadir registros a LT_EMPLOYEES' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    " 2.    Insertar registros
    INSERT VALUE #( client = sy-mandt
                    id     = |{ '2' ALPHA = IN }|
                    email  = to_lower( 'LORENA.JIMENEZ.FERNANDEZ@server.com' )
                    apel   = 'JIMENEZ'
                    ape2   = 'FERNANDEZ'
                    name   = 'LORENA'
                    fechan = '19911020'
                    fechaa = '20101113' ) INTO lt_employees INDEX 2.

    out->write( data = lt_employees
                name = 'Insertar registros a LT_EMPLOYEES' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    " 3.    Añadir registros con APPEND:
    DATA lt_employees_2 TYPE STANDARD TABLE OF zahr_emp_logali.

    ls_employess = VALUE #( client = sy-mandt
                            id     = |{ '4' ALPHA = IN }|
                            email  = to_lower( 'LORENA.VALENCIA.JIMENEZ@server.com' )
                            apel   = 'VALENCIA'
                            ape2   = 'JIMENEZ'
                            name   = 'LORENA'
                            fechan = '19901020'
                            fechaa = '20131113' ).

    APPEND ls_employess TO lt_employees_2.

    out->write( data = lt_employees_2
                name = ' Añadir registros con APPEND a LT_EMPLOYEES_2' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    APPEND VALUE #( client = sy-mandt
                    id     = |{ '5' ALPHA = IN }|
                    email  = to_lower( 'VERONICA.LEON.LOPEZ@server.com' )
                    apel   = 'LEON'
                    ape2   = 'LOPEZ'
                    name   = 'VERONICA'
                    fechan = '19931020'
                    fechaa = '20101113' ) TO lt_employees_2.

    out->write( data = lt_employees_2
                name = 'LT_EMPLOYEES_2' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    APPEND LINES OF lt_employees FROM 2 TO 3 TO lt_employees_2.

    out->write( data = lt_employees_2
                name = 'LT_EMPLOYEES_2' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    " 4.    CORRESPONDING

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
             con~distance_unit,
             con~distance
      INTO TABLE @DATA(lt_flight).

    TYPES ty_spfli LIKE LINE OF lt_flight.
    TYPES tt_spfli TYPE STANDARD TABLE OF ty_spfli.

    DATA lt_spfli   TYPE STANDARD TABLE OF ty_spfli.
    DATA ls_spfli   TYPE ty_spfli.
    DATA ls_spfli_2 TYPE ty_spfli.

    lt_spfli = VALUE #( FOR ls_flight IN lt_flight
                        WHERE ( carrid = 'LH' )
                        ( CORRESPONDING #( ls_flight ) ) ).

    out->write( data = lt_spfli
                name = 'lt_spfli' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    ls_spfli = lt_spfli[ 1 ].
    ls_spfli_2 = CORRESPONDING #( ls_spfli ).

    out->write( data = ls_spfli_2
                name = 'ls_spfli_2' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    " 5.    READ TABLE con índice
    DATA(lv_city) = lt_spfli[ 1 ]-city_from.
    out->write( data = lv_city
                name = 'lv_city' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    " 6.    READ TABLE con clave
    DATA(lv_city_from) = lt_spfli[ airport_to = 'FRA' ]-city_from.
    out->write( data = lv_city_from
                name = 'lv_city_from' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    " 7.    Chequeo de registros
    lt_spfli = VALUE #( FOR ls_flight IN lt_flight
                        WHERE ( connid > '0400' )
                        ( CORRESPONDING #( ls_flight ) ) ).

    out->write( data = lt_spfli
                name = 'lt_spfli' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    IF line_exists( lt_spfli[ connid = '0407' ] ).
      out->write( data = |The flight exists in the database| ).
      out->write( cl_abap_char_utilities=>cr_lf ).
    ELSE.
      out->write( data = |The flight doesn't exists in the database| ).
      out->write( cl_abap_char_utilities=>cr_lf ).
    ENDIF.

    " 8.    Índice de un registro
    DATA(lv_line_index) = line_index( lt_spfli[ connid = '0407' ] ).
    out->write( data = lv_line_index
                name = 'lv_line_index' ).
    out->write( cl_abap_char_utilities=>cr_lf ).

    " 9.    Sentencia LOOP
    LOOP AT lt_spfli ASSIGNING FIELD-SYMBOL(<ls_spfli>) WHERE distance_unit = 'KM'.
      out->write( data = <ls_spfli>
                  name = '<ls_spfli>' ).
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
