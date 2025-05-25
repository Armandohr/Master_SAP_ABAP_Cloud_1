CLASS zcl_ahr_ac1_lab_05_commit_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS Commit_Work IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Rollback_Work IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_05_COMMIT_SQL IMPLEMENTATION.


  METHOD commit_work.

    io_out->write( |--> Commit Work <--| ).

    TRY.

        INSERT zahr_products FROM @( VALUE #( product_id   = 20
                                              product_name = 'ONE PLUS'
                                              category_id  = 10
                                              quantity     = 200
                                              price        = '25.99' ) ).

        IF sy-subrc = 0.
          io_out->write( |Inserted record.| ).
        ELSE.
          io_out->write( |Registration was not inserted| ).
        ENDIF.

        COMMIT WORK.

      CATCH cx_sy_open_sql_db INTO DATA(lx_open_sql_db).

        io_out->write( lx_open_sql_db->get_text(  ) ).

    ENDTRY.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    commit_work( io_out = out ).

    rollback_work( io_out = out ).

  ENDMETHOD.


  METHOD rollback_work.
    io_out->write( |--> Rollback Work <--| ).

    TRY.
        UPDATE zahr_products
           SET price = '20.99'
         WHERE product_id = 5.

        IF sy-subrc = 0.
          io_out->write( |Update is executed| ).
          SELECT SINGLE FROM zahr_products
            FIELDS *
            WHERE product_id = 5
            INTO @DATA(ls_products).

          io_out->write( data = ls_products ).

        ENDIF.

        io_out->write( |Rollback Work is executed.| ).
        ROLLBACK WORK.

        SELECT SINGLE FROM zahr_products
          FIELDS *
          WHERE product_id = 5
          INTO @ls_products.

        io_out->write( data = ls_products ).

      CATCH cx_sy_open_sql_db INTO DATA(lx_open_sql_db).

        io_out->write( lx_open_sql_db->get_text( ) ).

    ENDTRY.
  ENDMETHOD.
ENDCLASS.
