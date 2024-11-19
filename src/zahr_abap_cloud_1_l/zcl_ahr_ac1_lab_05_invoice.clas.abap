CLASS zcl_ahr_ac1_lab_05_invoice DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.

    DATA:
      mv_exercise     TYPE n LENGTH 4,
      mv_invoice_no   TYPE n LENGTH 8,
      mv_invoice_code TYPE string.

    METHODS:
      INSERT_REVERSE_functions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      TO_LOWER_TO_UPPER_functions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      STRLEN_NUMOFCHAR_functions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      shift IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      split IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      Condensation IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      Concatenations_Table_rows IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      concatenate  IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS zcl_ahr_ac1_lab_05_invoice IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*  1.- Concatenación
    me->concatenate( out ).

*2.  Concatenaciones líneas de Tablas
    me->concatenations_table_rows( out ).

*3.  Condensación
    me->condensation( out ).

*4.  SPLIT
    me->split( out ).

*5.  SHIFT
    me->shift( out ).

*6.  Funciones STRLEN y NUMOFCHAR
    me->strlen_numofchar_functions( out ).

*7.  Funciones TO_LOWER y TO_UPPER
    me->to_lower_to_upper_functions( out ).

*8.  Función INSERT y REVERSE
    me->insert_reverse_functions( out ).



  ENDMETHOD.

  METHOD concatenate.

    mv_exercise = 2024.
    mv_invoice_no = '12345678'.

    mv_invoice_code = |Invoice / Fiscal Year: { mv_invoice_no } / { mv_exercise }|.

    io_out->write( mv_invoice_code ).


  ENDMETHOD.

  METHOD concatenations_table_rows.

    SELECT FROM /dmo/airport
    FIELDS airport_id,
           name
    INTO TABLE @DATA(lt_airport).

    DATA(lv_string_tab) = concat_lines_of( table = lt_airport sep = ` ` ).

    io_out->write( lv_string_tab ).

  ENDMETHOD.

  METHOD condensation.

    DATA:
      mv_case1 TYPE string VALUE '      Sales invoice with        status in process      ',
      mv_case2 TYPE string VALUE '***ABAP*Cloud***'.

*    CONDENSE mv_case1 NO-GAPS.

    io_out->write( mv_case1 ).

    mv_case1 = condense( val = mv_case1 from = ` ` ).
*    mv_case1 = condense( val = mv_case1 to = `` ).
    io_out->write( mv_case1 ).

    io_out->write( mv_case2 ).
    mv_case2 = condense( val = mv_case2 del = '*' ).
    io_out->write( mv_case2 ).

  ENDMETHOD.

  METHOD split.

    DATA:
      mv_data        TYPE string VALUE '0001111111;LOGALIGROUP;2024',
      mv_id_customer TYPE string,
      mv_customer    TYPE string,
      mv_year        TYPE string.

    SPLIT mv_data AT ';' INTO mv_id_customer
                              mv_customer
                              mv_year.

    io_out->write( | Customer ID: { mv_id_customer } Customer Name: { mv_customer } Year: { mv_year } | ).

*    mv_id_customer = segment( val = mv_data index = 1 sep = ';' ).
*    mv_customer = segment( val = mv_data index = 2 sep = ';' ).
*    mv_year = segment( val = mv_data index = 3 sep = ';' ).
*
*    io_out->write( | Customer ID: { mv_id_customer } Customer Name: { mv_customer } Year: { mv_year } | ).

  ENDMETHOD.

  METHOD shift.

    DATA:
        mv_invoice_num TYPE string VALUE '2015ABCD'.

    io_out->write( mv_invoice_num ).

*    SHIFT mv_invoice_num BY 2 PLACES LEFT.
*    io_out->write( mv_invoice_num ).
*
*    SHIFT mv_invoice_num BY 2 PLACES .
*    io_out->write( mv_invoice_num ).

    mv_invoice_num = shift_left( val = mv_invoice_num places = 2 ).
    io_out->write( mv_invoice_num ).

    mv_invoice_num = shift_right( val = mv_invoice_num places = 2 ).
    io_out->write( mv_invoice_num ).

  ENDMETHOD.

  METHOD strlen_numofchar_functions.

    DATA:
      mv_response TYPE string VALUE ' Generating Invoice ',
      mv_count    TYPE i.

    io_out->write( mv_response ).

    mv_count = strlen( mv_response ).
    io_out->write( mv_count ).

    mv_count = numofchar( mv_response ).
    io_out->write( mv_count ).

  ENDMETHOD.

  METHOD to_lower_to_upper_functions.

    DATA:
        mv_translate_invoice TYPE string VALUE 'Report the issuance of this invoice'.

    TRANSLATE mv_translate_invoice TO UPPER CASE.
    io_out->write( mv_translate_invoice ).

    TRANSLATE mv_translate_invoice TO LOWER CASE.
    io_out->write( mv_translate_invoice ).
*
*    io_out->write( mv_translate_invoice  ).
*    io_out->write( to_upper( mv_translate_invoice ) ).
*    io_out->write( to_lower( mv_translate_invoice ) ).


  ENDMETHOD.

  METHOD insert_reverse_functions.

    DATA:
        mv_translate_invoice TYPE string VALUE 'Report the issuance of this invoice'.

    io_out->write( mv_translate_invoice ).

*    mv_translate_invoice = insert( val = mv_translate_invoice sub = ' to cleint' ).
    mv_translate_invoice = insert( val = mv_translate_invoice sub = ' to cleint' off = numofchar( mv_translate_invoice ) ).
    io_out->write( mv_translate_invoice ).

    mv_translate_invoice = reverse( mv_translate_invoice ).
    io_out->write( mv_translate_invoice ).

  ENDMETHOD.

ENDCLASS.

