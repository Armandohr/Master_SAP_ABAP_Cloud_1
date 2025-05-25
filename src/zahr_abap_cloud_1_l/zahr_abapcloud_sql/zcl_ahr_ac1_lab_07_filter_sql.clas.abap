CLASS zcl_ahr_ac1_lab_07_filter_sql DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS Binary_relational_operators IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Between_instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Like_instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS character_escape IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS IN_instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS IN_range_table IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS NULL_Instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS AND_OR_NOT_operator IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_07_FILTER_SQL IMPLEMENTATION.


  METHOD and_or_not_operator.

    io_out->write( |and_or_not_operator| ).

    SELECT FROM zahr_products
    FIELDS product_name,
           category_id,
           price
     WHERE ( category_id = 2
        OR category_id = 10 )
       AND price >= 100
     ORDER BY product_id
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.


  METHOD between_instruction.

    io_out->write( |between_instruction| ).

    SELECT FROM zahr_products
    FIELDS product_id,
           product_name,
           price
     WHERE price BETWEEN 100 AND 1000
     ORDER BY product_id
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.


  METHOD binary_relational_operators.

    io_out->write( |binary_relational_operators| ).

    SELECT FROM zahr_products
    FIELDS product_id,
           product_name,
           price
     WHERE price GE 100
     ORDER BY product_id
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.


  METHOD character_escape.

    io_out->write( |Character Escape| ).

    CONSTANTS cv_escape TYPE c LENGTH 1 VALUE '#'.

    DATA lv_search_criteria TYPE string VALUE '%#_%'.

    SELECT FROM zahr_products
    FIELDS product_id,
           product_name,
           price
     WHERE product_name LIKE @lv_search_criteria ESCAPE @cv_escape
     ORDER BY product_id
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    binary_relational_operators( io_out = out ).
    between_instruction( io_out = out ).
    Like_instruction( io_out = out ).
    character_escape( io_out = out ).
    IN_instruction( io_out = out ).
    IN_range_table( io_out = out ).
    NULL_Instruction( io_out = out ).
    AND_OR_NOT_operator( io_out = out ).

  ENDMETHOD.


  METHOD IN_instruction.

    io_out->write( |IN instruction| ).

    SELECT FROM zahr_products
    FIELDS product_id,
           product_name,
           category_id
     WHERE category_id IN ( 1, 3, 5, 7 )
     ORDER BY category_id, product_id
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.


  METHOD in_range_table.

    io_out->write( |IN range table| ).

    DATA lr_category_id TYPE RANGE OF zahr_products-category_id.

    lr_category_id = VALUE #( ( sign = 'I' option = 'EQ' low = '1' )
                              ( sign = 'I' option = 'BT' low = '3' high = '5' ) ).

    SELECT FROM zahr_products
    FIELDS category_id,
           product_id,
           product_name
     WHERE category_id IN @lr_category_id
     ORDER BY category_id, product_id
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.


  METHOD like_instruction.

    io_out->write( |like_instruction| ).

    DATA lv_search_criteria TYPE string VALUE 'Mo%'. " '%S%'.

    SELECT FROM zahr_products
    FIELDS product_id,
           product_name,
           price
     WHERE product_name LIKE @lv_search_criteria
     ORDER BY product_id
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.


  METHOD null_instruction.

    io_out->write( |NULL instruction| ).

    SELECT FROM zahr_products
    FIELDS product_id,
           product_name
     WHERE product_name IS NOT NULL
     ORDER BY product_id
      INTO TABLE @DATA(lt_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_products name = |lt_products| ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
