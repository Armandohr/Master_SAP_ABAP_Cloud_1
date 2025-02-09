CLASS zcl_ahr_insert_univ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_ahr_insert_univ IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_zahr_university TYPE STANDARD TABLE OF zahr_university.

    lt_zahr_university =  VALUE #( ( client = sy-mandt soc = '1000' exercise = '2020' )
                                   ( client = sy-mandt soc = '2000' exercise = '2020' )
                                   ( client = sy-mandt soc = '3000' exercise = '2020' ) ).

    MODIFY zahr_university FROM TABLE @lt_zahr_university.

    out->write( data = lt_zahr_university name = 'lt_zahr_university' ).

  ENDMETHOD.

ENDCLASS.
