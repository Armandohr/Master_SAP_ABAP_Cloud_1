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

ENDCLASS.



CLASS zcl_ahr_ac1_lab_04_message IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

***********************************************************************
**1. Símbolos de texto
*    out->write( TEXT-001 ).
*
***********************************************************************
**2. Funciones de descripción
*    me->lv_char_number = strlen( lv_order_status ).
*    out->write( me->lv_char_number ).
*
*    me->lv_char_number = numofchar( lv_order_status ).
*    out->write( me->lv_char_number ).
**    lv_char_number = find( val = lv_order_status sub = 'A' case = abap_false occ = 2 off = 0 len = lv_char_number ).
*    out->write( me->lv_order_status ).
*
*    lv_char_number = count( val = lv_order_status sub = 'A' case = abap_false ).
*    out->write( me->lv_char_number ).
*
**    lv_char_number = count_any_of( val = lv_order_status sub = 'A' ).
**    out->write( me->lv_char_number ).
**
**    lv_char_number = count_any_not_of( val = lv_order_status sub = 'A' ).
**    out->write( me->lv_char_number ).
*
*    lv_char_number = find( val = lv_order_status sub = 'Exit' ).
*    out->write( me->lv_char_number ).
**
**    lv_char_number = find_any_of( val = lv_order_status sub = 'Exit' ).
**    out->write( me->lv_char_number ).
*
**    lv_char_number = find_any_not_of( val = lv_order_status sub = 'Exit' ).
**    out->write( me->lv_char_number ).

**********************************************************************
*3. Funciones de procesamiento

*--> MAYUSCULAS - minusculas
    out->write( lv_order_status ).
    out->write( |TO UPPER:   { to_upper( lv_order_status ) } | ).
    out->write( |TO LOWER:   { to_lower( lv_order_status ) } | ).
    out->write( |TO MIXED:   { to_mixed( lv_order_status ) } | ).

*    out->write( |FROM MIXED: { from_mixed( lv_order_status ) } | ).

*--> Order
    out->write( lv_order_status ).
*    out->write( |REVERSE:                 { reverse( lv_order_status ) } | ).
*    out->write( |SHIFT_LEFT  (places):    { shift_left(  val = lv_order_status  places   = 5 ) } | ).
*    out->write( |SHIFT_RIGHT (places):    { shift_right( val = lv_order_status  places   = 5 ) } | ).
    out->write( |SHIFT_LEFT  (circle):    { shift_left(  val = lv_order_status  circular = 9 ) } | ).
*    out->write( |SHIFT_RIGHT (circle):    { shift_RIGHT( val = lv_order_status  circular = 5 ) } | ).

*--> Substring
    out->write( lv_order_status ).
    out->write( |SUBSTRING:               { substring(        val = lv_order_status  off = 9 len = 9 ) } | ).

    out->write( |SUBSTRING_FROM_TO:       { substring_to( val = substring_from(   val = lv_order_status  sub = 'Completed' )
                                                          sub = 'Completed' ) } | ).

*    out->write( |SUBSTRING_FROM:          { substring_from(   val = lv_order_status  sub = 'Completed' ) } | ).
*    out->write( |SUBSTRING_AFTER:         { substring_after(  val = lv_order_status  sub = 'Completed' ) } | ).
*    out->write( |SUBSTRING_TO:            { substring_to(     val = lv_order_status  sub = 'Completed' ) } | ).
*    out->write( |SUBSTRING_BEFORE:        { substring_before( val = lv_order_status  sub = 'Completed' ) } | ).

    out->write( |REVERSE:                 { reverse( lv_order_status ) } | ).

*--> Others
*    out->write( lv_order_status ).
*    out->write( |CONDENSE:                { condense( val = lv_order_status ) } | ).
*    out->write( |REPEAT:                  { repeat(   val = lv_order_status occ = 2 ) } | ).
*    out->write( |SEGMENT1:                { segment(  val = lv_order_status sep = '!' index = 1 ) } | ).
*    out->write( |SEGMENT2:                { segment(  val = lv_order_status sep = '!' index = 2 ) } | ).

**********************************************************************
*4. Funciones de contenido
    DATA:
      lv_pattern TYPE string VALUE '\d{3}-\d{3}-\d{4}',
      lv_phone   TYPE string VALUE 'Agregar cualquier teléfono'.


**********************************************************************
*5. Funciones con expresiones regulares

    DATA:
      lv_email   TYPE string VALUE 'angel.fernandez@yahoo.com'.

    lv_pattern = '\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'.

  ENDMETHOD.

ENDCLASS.
