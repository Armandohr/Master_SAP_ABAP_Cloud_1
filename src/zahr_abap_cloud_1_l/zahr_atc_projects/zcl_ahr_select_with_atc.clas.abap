CLASS zcl_ahr_select_with_atc DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    METHODS get_data RETURNING VALUE(rv_status) TYPE string.

ENDCLASS.


CLASS zcl_ahr_select_with_atc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( me->get_data( ) ).
  ENDMETHOD.

  METHOD get_data.
    SELECT FROM /dmo/flight
      FIELDS *
      " TODO: variable is assigned but never used (ABAP cleaner)
      INTO TABLE @DATA(lt_flights).
    IF sy-subrc = 0.
      rv_status = |Records consulted: { sy-dbcnt }| ##NO_TEXT.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
