CLASS zcl_ahr_ac1_lab_04_message DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA:
      lv_order_status TYPE string VALUE 'Purchase Completed! Successfully',
      lv_char_number  TYPE i.

    METHODS:
      Functions_Regular_Expressions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      Content_functions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      Processing_functions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      Description_Functions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out,
      Text_Symbol IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_04_message IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**********************************************************************
*1. Símbolos de texto
*    me->text_symbol( out ).
**
**********************************************************************
*2. Funciones de descripción
*    me->description_functions( out ).
*
**********************************************************************
*3. Funciones de procesamiento
*    me->processing_functions( out ).
*
**********************************************************************
*4. Funciones de contenido
*    me->content_functions( out ).
*
**********************************************************************
*5. Funciones con expresiones regulares
    me->functions_regular_expressions( out ).

  ENDMETHOD.

  METHOD text_symbol.

    io_out->write( TEXT-001 ).

  ENDMETHOD.

  METHOD description_functions.

    me->lv_char_number = strlen( lv_order_status ).
    io_out->write( me->lv_char_number ).

    me->lv_char_number = numofchar( lv_order_status ).
    io_out->write( me->lv_char_number ).
*    lv_char_number = find( val = lv_order_status sub = 'A' case = abap_false occ = 2 off = 0 len = lv_char_number ).
    io_out->write( me->lv_order_status ).

    lv_char_number = count( val = lv_order_status sub = 'A' case = abap_false ).
    io_out->write( me->lv_char_number ).

*    lv_char_number = count_any_of( val = lv_order_status sub = 'A' ).
*    out->write( me->lv_char_number ).
*
*    lv_char_number = count_any_not_of( val = lv_order_status sub = 'A' ).
*    out->write( me->lv_char_number ).

    lv_char_number = find( val = lv_order_status sub = 'Exit' ).
    io_out->write( me->lv_char_number ).
*
*    lv_char_number = find_any_of( val = lv_order_status sub = 'Exit' ).
*    out->write( me->lv_char_number ).

*    lv_char_number = find_any_not_of( val = lv_order_status sub = 'Exit' ).
*    out->write( me->lv_char_number ).

  ENDMETHOD.

  METHOD processing_functions.

*--> MAYUSCULAS - minusculas
    io_out->write( lv_order_status ).
    io_out->write( |TO UPPER:   { to_upper( lv_order_status ) } | ).
    io_out->write( |TO LOWER:   { to_lower( lv_order_status ) } | ).
    io_out->write( |TO MIXED:   { to_mixed( lv_order_status ) } | ).

*    out->write( |FROM MIXED: { from_mixed( lv_order_status ) } | ).

*--> Order
    io_out->write( lv_order_status ).
*    out->write( |REVERSE:                 { reverse( lv_order_status ) } | ).
*    out->write( |SHIFT_LEFT  (places):    { shift_left(  val = lv_order_status  places   = 5 ) } | ).
*    out->write( |SHIFT_RIGHT (places):    { shift_right( val = lv_order_status  places   = 5 ) } | ).
    io_out->write( |SHIFT_LEFT  (circle):    { shift_left(  val = lv_order_status  circular = 9 ) } | ).
*    out->write( |SHIFT_RIGHT (circle):    { shift_RIGHT( val = lv_order_status  circular = 5 ) } | ).

*--> Substring
    io_out->write( lv_order_status ).
    io_out->write( |SUBSTRING:               { substring(        val = lv_order_status  off = 9 len = 9 ) } | ).

    io_out->write( |SUBSTRING_FROM_TO:       { substring_to( val = substring_from(   val = lv_order_status  sub = 'Completed' )
                                                          sub = 'Completed' ) } | ).

*    out->write( |SUBSTRING_FROM:          { substring_from(   val = lv_order_status  sub = 'Completed' ) } | ).
*    out->write( |SUBSTRING_AFTER:         { substring_after(  val = lv_order_status  sub = 'Completed' ) } | ).
*    out->write( |SUBSTRING_TO:            { substring_to(     val = lv_order_status  sub = 'Completed' ) } | ).
*    out->write( |SUBSTRING_BEFORE:        { substring_before( val = lv_order_status  sub = 'Completed' ) } | ).

    io_out->write( |REVERSE:                 { reverse( lv_order_status ) } | ).

*--> Others
    io_out->write( lv_order_status ).
    io_out->write( |CONDENSE:                { condense( val = lv_order_status ) } | ).
    io_out->write( |REPEAT:                  { repeat(   val = lv_order_status occ = 2 ) } | ).
    io_out->write( |SEGMENT1:                { segment(  val = lv_order_status sep = '!' index = 1 ) } | ).
    io_out->write( |SEGMENT2:                { segment(  val = lv_order_status sep = '!' index = 2 ) } | ).

  ENDMETHOD.

  METHOD content_functions.

    DATA:
      lv_pattern TYPE string VALUE '\d{3}-\d{3}-\d{4}',
      lv_phone   TYPE string VALUE '555-658-1111'.

    IF contains( val = lv_phone pcre = lv_pattern ).
      io_out->write( |La cadena: { lv_phone } SI corresponde al formato { lv_pattern } valido| ).
    ELSE.
      io_out->write( |La cadena: { lv_phone } NO corresponde al formato { lv_pattern } valido| ).
    ENDIF.

    DATA(lv_number) = match( val = lv_phone pcre = lv_pattern ).
    io_out->write( lv_number ).

  ENDMETHOD.

  METHOD functions_regular_expressions.

    DATA:
      lv_pattern TYPE string VALUE '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b',
      lv_email   TYPE string VALUE 'angel.fernandez@yahoo.com'.

    IF contains( val = lv_email pcre = lv_pattern ).
      io_out->write( |La cadena: { lv_email } SI corresponde a un Email valido| ).
    ELSE.
      io_out->write( |La cadena: { lv_email } NO corresponde a un Email valido| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
