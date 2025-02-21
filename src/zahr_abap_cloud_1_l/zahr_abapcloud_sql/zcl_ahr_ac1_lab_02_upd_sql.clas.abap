CLASS zcl_ahr_ac1_lab_02_upd_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS Update_record IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Update_multiple_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Update_columns IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Update_columns_expressions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_02_upd_sql IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

*    update_record( io_out = out ).

*    Update_multiple_records( io_out = out ).

*    update_columns( io_out = out ).

    update_columns_expressions( io_out = out ).

  ENDMETHOD.

  METHOD update_record.

    io_out->write( |--> Update Record <--| ).

    SELECT SINGLE FROM zahr_products
    FIELDS *
     WHERE product_id = 1
      INTO @DATA(ls_product).
    IF sy-subrc = 0.
      io_out->write( data = ls_product name = |Current record| ).
      ls_product-quantity = 75.
      ls_product-price = '899.99'.
      UPDATE zahr_products FROM @ls_product.
      IF sy-subrc = 0.
        io_out->write( data = ls_product name = |Updated record| ).
      ELSE.
        io_out->write( |Registration was not updated| ).
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD update_multiple_records.

    io_out->write( |--> Update multiple Records <--| ).

    SELECT FROM zahr_products
    FIELDS *
     WHERE category_id = 2
      INTO TABLE @DATA(lt_product).
    IF sy-subrc = 0.
      io_out->write( data = lt_product name = |Current records| ).

      LOOP AT lt_product ASSIGNING FIELD-SYMBOL(<ls_product>).
        <ls_product>-quantity = 120.
      ENDLOOP.
      UPDATE zahr_products FROM TABLE @lt_product.
      IF sy-subrc = 0.
        io_out->write( |Updated record: { sy-dbcnt }| ).
      ELSE.
        io_out->write( |Registration was not updated| ).
      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD update_columns.

    io_out->write( |--> Update columns <--| ).

    UPDATE zahr_products
       SET price = 50
     WHERE category_id = 2.

    IF sy-subrc = 0.
      io_out->write( |Records updated: { sy-dbcnt }| ).
    ELSE.
      io_out->write( |Records NOT updated| ).
    ENDIF.

  ENDMETHOD.

  METHOD update_columns_expressions.

    io_out->write( |--> Update columns with expressions <--| ).

    UPDATE zahr_products
       SET price = price + 50
     WHERE product_id GE 1.

    IF sy-subrc = 0.
      io_out->write( |Records updated: { sy-dbcnt }| ).
      SELECT FROM zahr_products
      FIELDS *
       WHERE product_id GE 1
        INTO TABLE @DATA(lt_products).
      io_out->write( data = lt_products name = |lt_products| ).
    ELSE.
      io_out->write( |Records NOT updated| ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
