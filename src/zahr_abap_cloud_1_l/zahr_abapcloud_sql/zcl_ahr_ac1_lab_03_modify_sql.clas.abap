CLASS zcl_ahr_ac1_lab_03_modify_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS Modify_record IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS Modify_multiple_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_03_modify_sql IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    modify_record( io_out = out ).

    modify_multiple_records( io_out = out ).

  ENDMETHOD.

  METHOD modify_record.

    io_out->write( |--> Modify record <--| ).

    SELECT SINGLE FROM zahr_products
    FIELDS *
     WHERE product_id = 1
     INTO @DATA(ls_product).

    io_out->write( data = ls_product name = 'ls_product' ).

    ls_product-quantity = 60.
    ls_product-price = '850.99'.

    MODIFY zahr_products FROM @ls_product.

    IF sy-subrc = 0.
      io_out->write( |The record was modified correctly| ).
      io_out->write( data = ls_product name = 'ls_product' ).
    ELSE.
      io_out->write( |The record was NOT modified| ).
    ENDIF.

  ENDMETHOD.

  METHOD modify_multiple_records.

    io_out->write( |--> Modify multiple records <--| ).

    SELECT FROM zahr_products
    FIELDS *
     WHERE product_id = 1
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.

      LOOP AT lt_products ASSIGNING FIELD-SYMBOL(<ls_product>).
        <ls_product>-quantity = 90.
      ENDLOOP.

      DATA(ls_product_new) = <ls_product>.
      ls_product_new-product_id = 10.
      ls_product_new-product_name = 'MSI'.
      APPEND ls_product_new TO lt_products.

      TRY.
          MODIFY zahr_products FROM TABLE @lt_products.
          IF sy-subrc = 0.
            io_out->write( |Modified records: { sy-dbcnt }| ).
          ELSE.
            io_out->write( |Records were not modified| ).
          ENDIF.
        CATCH cx_sy_open_sql_error INTO DATA(lo_exception).
          io_out->write( lo_exception->get_text(  ) ).
      ENDTRY.

    ENDIF.

  ENDMETHOD.

ENDCLASS.
