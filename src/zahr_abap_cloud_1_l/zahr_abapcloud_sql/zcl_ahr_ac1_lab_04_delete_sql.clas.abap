CLASS zcl_ahr_ac1_lab_04_delete_sql DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

protected section.
  PRIVATE SECTION.
    METHODS delete_record           IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS delete_multiple_records IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Delete_records_filters  IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_04_DELETE_SQL IMPLEMENTATION.


  METHOD delete_multiple_records.
    io_out->write( |--> Delete multiple records <--| ).

    DATA lt_products TYPE STANDARD TABLE OF zahr_products.

    SELECT FROM zahr_products
      FIELDS product_id
      WHERE product_id IN ( 2, 3 )
      INTO CORRESPONDING FIELDS OF TABLE @lt_products.

    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    TRY.
        DELETE zahr_products FROM TABLE @lt_products.
        IF sy-subrc = 0.
          io_out->write( |Deleted records: { sy-dbcnt }| ).
          io_out->write( data = lt_products
                         name = 'lt_products' ).
        ELSE.
          io_out->write( |Records were not deleted| ).
        ENDIF.
      CATCH cx_sy_open_sql_error INTO DATA(lo_cx_exception_sql).
        io_out->write( lo_cx_exception_sql->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD delete_record.
    io_out->write( |--> Delete record <--| ).

    DATA(ls_product) = VALUE zahr_products( product_id = 1 ).

    DELETE zahr_products FROM @ls_product.

    IF sy-subrc = 0.
      io_out->write( |Record deleted from the database| ).
    ELSE.
      io_out->write( |Record not available for deletion| ).
    ENDIF.
  ENDMETHOD.


  METHOD delete_records_filters.
    io_out->write( |--> Delete records using filters <--| ).

    TRY.
        DELETE FROM zahr_products
              WHERE quantity > 100.
        IF sy-subrc = 0.
          io_out->write( |Deleted records: { sy-dbcnt }| ).
        ELSE.
          io_out->write( |Records were not deleted| ).
        ENDIF.
      CATCH cx_sy_open_sql_error INTO DATA(lo_cx_exception_sql).
        io_out->write( lo_cx_exception_sql->get_text( ) ).
    ENDTRY.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    delete_record( io_out = out ).

    delete_multiple_records( io_out = out ).

    delete_records_filters( io_out = out ).
  ENDMETHOD.
ENDCLASS.
