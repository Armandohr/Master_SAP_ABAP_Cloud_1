CLASS zcl_ahr_ac1_lab_06_select_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS select_single IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Select_Bypassing_Buffer IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Select_Into_Appending_Table IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Select_Into_Corresponding IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Select_Up_To_n_Rows IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Select_Endselect IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Select_Package_Size IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_06_SELECT_SQL IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    select_single( io_out = out ).
    Select_Bypassing_Buffer( io_out = out ).
    Select_Into_Appending_Table( io_out = out ).
    Select_Into_Corresponding( io_out = out ).
    Select_Up_To_n_Rows( io_out = out ).
    Select_Endselect( io_out = out ).
    Select_Package_Size( io_out = out ).

  ENDMETHOD.


  METHOD select_bypassing_buffer.

    io_out->write( |--> Select Bypassing Buffer <--| ).

    SELECT SINGLE FROM zahr_products
    FIELDS *
     WHERE product_id = 6
      INTO @DATA(ls_product)
 BYPASSING BUFFER.

    IF sy-subrc = 0.
      io_out->write( data = ls_product ).
    ENDIF.

  ENDMETHOD.


  METHOD select_endselect.

    io_out->write( |--> Select Endselect <--| ).

    DATA lt_products TYPE STANDARD TABLE OF zahr_products.

    SELECT FROM zahr_products
    FIELDS *
     WHERE price >= 100
       AND category_id = 5
      INTO @DATA(ls_product).

      APPEND ls_product TO lt_products.

    ENDSELECT.

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.


  METHOD select_into_appending_table.

    io_out->write( |--> Select Into/Appending Table <--| ).

    SELECT FROM zahr_products
    FIELDS *
     WHERE category_id = 2
      INTO TABLE @DATA(lt_products).
    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
      io_out->write( data = lines( lt_products ) name = |Number of records found:| ).
    ENDIF.

  ENDMETHOD.


  METHOD select_into_corresponding.

    io_out->write( |--> Select Into Corresponding Fields <--| ).

    TYPES: BEGIN OF ty_product,
             product_id   TYPE zahr_products-product_id,
             product_name TYPE zahr_products-product_name,
             category_id  TYPE zahr_products-category_id,
             price        TYPE zahr_products-price,
           END OF ty_product.

    DATA lt_products TYPE STANDARD TABLE OF ty_product.

    SELECT FROM zahr_products
    FIELDS *
     WHERE category_id = 2
      INTO CORRESPONDING FIELDS OF TABLE @lt_products.
    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
      io_out->write( data = lines( lt_products ) name = |Number of records found:| ).
    ENDIF.

  ENDMETHOD.


  METHOD select_package_size.

    io_out->write( |--> Select Package Size <--| ).

    DATA lt_products TYPE STANDARD TABLE OF zahr_products.

    SELECT FROM zahr_products
    FIELDS *
     WHERE price >= 100
       AND category_id = 5
      INTO TABLE @lt_products PACKAGE SIZE 2.

      io_out->write( data = lt_products name = |lt_products| ).
      io_out->write( cl_abap_char_utilities=>newline ).

    ENDSELECT.

  ENDMETHOD.


  METHOD select_single.

    io_out->write( |--> Select Single <--| ).

    SELECT SINGLE FROM zahr_products
    FIELDS *
     WHERE product_id = 6
      INTO @DATA(ls_product).

    IF sy-subrc = 0.
      io_out->write( data = ls_product-product_name name = |Product selected is:| ).
    ELSE.
      io_out->write( |No record selected| ).
    ENDIF.

  ENDMETHOD.


  METHOD select_up_to_n_rows.

    io_out->write( |--> Select Up To n Rows <--| ).

    SELECT FROM zahr_products
    FIELDS *
     WHERE category_id = 2
      INTO TABLE @DATA(lt_products)
        UP TO 3 ROWS.
    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
      io_out->write( data = lines( lt_products ) name = |Number of records found:| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
