CLASS zcl_ahr_ac1_lab_01_ins_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS insert_record IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS insert_multiple_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS insert_records_exception IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS zcl_ahr_ac1_lab_01_ins_sql IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    insert_record( out ).
*    insert_multiple_records( out ).
    insert_records_exception( out ).

  ENDMETHOD.

  METHOD insert_record.

    io_out->write( |insert_record| ).

    DATA ls_products TYPE zahr_products.

    DELETE FROM zahr_products.

    ls_products = VALUE #( client       = sy-mandt
                           product_id   = '1'
                           product_name = 'Computadora'
                           category_id  = '1234'
                           quantity     = '1'
                           price        = '1500' ).

    INSERT zahr_products FROM @ls_products.

    io_out->write( sy-dbcnt ).
    io_out->write( ls_products ).

  ENDMETHOD.

  METHOD insert_multiple_records.

    io_out->write( |insert_multiple_records| ).

    DATA lt_products TYPE STANDARD TABLE OF zahr_products.

    DELETE FROM zahr_products.

    lt_products = VALUE #( ( client       = sy-mandt
                             product_id   = '1'
                             product_name = 'Computadora'
                             category_id  = '1234'
                             quantity     = '1'
                             price        = '1500' )
                           ( client       = sy-mandt
                             product_id   = '2'
                             product_name = 'Monitor'
                             category_id  = '1235'
                             quantity     = '2'
                             price        = '4000' )
                           ( client       = sy-mandt
                             product_id   = '3'
                             product_name = 'Teclador'
                             category_id  = '1236'
                             quantity     = '1'
                             price        = '300' )
                           ( client       = sy-mandt
                             product_id   = '4'
                             product_name = 'Mouse'
                             category_id  = '1237'
                             quantity     = '1'
                             price        = '50' )
                           ( client       = sy-mandt
                             product_id   = '5'
                             product_name = 'Escritorio'
                             category_id  = '1238'
                             quantity     = '1'
                             price        = '400' ) ).

    INSERT zahr_products FROM TABLE @lt_products.

    io_out->write( sy-dbcnt ).
    io_out->write( lt_products ).

  ENDMETHOD.

  METHOD insert_records_exception.

    io_out->write( |Insert records with exception handling.| ).

    DATA lt_products TYPE STANDARD TABLE OF zahr_products.

    lt_products = VALUE #( ( client       = sy-mandt
                             product_id   = '1'
                             product_name = 'Computadora'
                             category_id  = '1234'
                             quantity     = '1'
                             price        = '1500' ) ).

    TRY.
        INSERT zahr_products FROM TABLE @lt_products.
        io_out->write( |Se inserto registro en la base de datos| ).
        io_out->write( sy-dbcnt ).
        io_out->write( lt_products ).
      CATCH cx_sy_open_sql_db.
        io_out->write( |No se pudo insertar registros| ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
