CLASS zcl_ahr_test_abapcleaner DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    METHODS get_data EXPORTING ev_status TYPE string.

ENDCLASS.


CLASS zcl_ahr_test_abapcleaner IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    " TODO: variable is assigned but never used (ABAP cleaner)
    DATA lv_status TYPE string.

    get_data( IMPORTING ev_status = lv_status ).
  ENDMETHOD.

  METHOD get_data.
    SELECT FROM /dmo/flight
      FIELDS *
    " TODO: variable is assigned but never used (ABAP cleaner)
      INTO TABLE @FINAL(lt_flights).
    IF sy-subrc = 0.
      ev_status = |Records consulted: { sy-dbcnt }|.
    ELSE.
      ev_status = 'Error'.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
