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



CLASS ZCL_AHR_AC1_LAB_01_INS_SQL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    insert_record( out ).
    insert_multiple_records( out ).
    insert_records_exception( out ).

  ENDMETHOD.


  METHOD insert_multiple_records.

    io_out->write( |insert_multiple_records| ).

    DATA lt_products_aux TYPE STANDARD TABLE OF zahr_products.
    DATA lt_products TYPE STANDARD TABLE OF zahr_products.
    DELETE FROM zahr_products.

    TRY.
        DATA(lo_random) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                      min  = 1
                                                      max  = 8 ).

        DO 10 TIMES.

          DATA(lv_random_num) = lo_random->get_next( ).

          lt_productS_aux = VALUE #( ( client       = sy-mandt
                                   product_id   = |{ 1 + ( 5 * sy-index ) }|
                                   product_name = 'Computadora'
                                   category_id  = lv_random_num
                                   quantity     = '1'
                                   price        = '1500' )
                                 ( client       = sy-mandt
                                   product_id   = |{ 2 + ( 5 * sy-index ) }|
                                   product_name = 'Monitor'
                                   category_id  = lv_random_num
                                   quantity     = '2'
                                   price        = '4000' )
                                 ( client       = sy-mandt
                                   product_id   = |{ 3 + ( 5 * sy-index ) }|
                                   product_name = 'Teclador'
                                   category_id  = lv_random_num
                                   quantity     = '1'
                                   price        = '300' )
                                 ( client       = sy-mandt
                                   product_id   = |{ 4 + ( 5 * sy-index ) }|
                                   product_name = 'MouSe'
                                   category_id  = lv_random_num
                                   quantity     = '1'
                                   price        = '50' )
                                 ( client       = sy-mandt
                                   product_id   = |{ 5 + ( 5 * sy-index ) }|
                                   product_name = 'Escritorio_Plegable'
                                   category_id  = lv_random_num
                                   quantity     = '1'
                                   price        = '400' ) ).

          APPEND LINES OF lt_products_aux TO lt_products.

        ENDDO.
      CATCH cx_abap_random INTO DATA(lx_abap_random).
        io_out->write( lx_abap_random->get_text(  ) ).
    ENDTRY.

    INSERT zahr_products FROM TABLE @lt_products.

    io_out->write( sy-dbcnt ).
    io_out->write( lt_products ).

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


  METHOD insert_records_exception.

    io_out->write( |Insert records with exception handling.| ).

    DATA lt_products TYPE STANDARD TABLE OF zahr_products.

    lt_products = VALUE #( ( client       = sy-mandt
                             product_id   = '1'
                             product_name = 'Computadora'
                             category_id  = '1'
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
