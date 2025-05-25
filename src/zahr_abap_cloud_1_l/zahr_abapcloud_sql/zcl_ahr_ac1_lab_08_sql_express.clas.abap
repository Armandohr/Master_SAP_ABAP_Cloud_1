CLASS zcl_ahr_ac1_lab_08_sql_express DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    METHODS Min_Max                     IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Avg_Sum                     IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS DISTINCT_Instruction        IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS COUNT_Instruction           IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS GROUP_BY_HAVING_Instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS ORDER_BY_OFFSET_Instruction IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.


CLASS zcl_ahr_ac1_lab_08_sql_express IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    min_max( io_out = out ).
    Avg_Sum( io_out = out ).
    DISTINCT_Instruction( io_out = out ).
    COUNT_Instruction( io_out = out ).
    GROUP_BY_HAVING_Instruction( io_out = out ).
    ORDER_BY_OFFSET_Instruction( io_out = out ).
  ENDMETHOD.

  METHOD min_max.
    io_out->write( |Min/Max| ).

    SELECT FROM zahr_products
      FIELDS MIN( price ) AS MinPrice,
             MAX( price ) AS MaxPrice
      INTO @DATA(ls_price_products).

    IF sy-subrc = 0.
      io_out->write( data = ls_price_products
                     name = |ls_price_products| ).
    ENDIF.
  ENDMETHOD.

  METHOD avg_sum.
    io_out->write( |Avg/Sum| ).

    SELECT FROM zahr_products
      FIELDS AVG( price ) AS AvgPrice,
             SUM( price ) AS SumPrice
      INTO @DATA(ls_price_products).

    IF sy-subrc = 0.
*      io_out->write( data = ls_price_products name = |ls_price_products| ).
      io_out->write( |AVG Price { ls_price_products-avgprice } SUM Price { ls_price_products-sumprice }| ).
    ENDIF.
  ENDMETHOD.

  METHOD distinct_instruction.
    io_out->write( |distinct instruction| ).

    SELECT FROM zahr_products
      FIELDS MIN( DISTINCT price ) AS MinPrice,
             MAX( DISTINCT price ) AS MaxPrice
      INTO @DATA(ls_price_products).

    IF sy-subrc = 0.
      io_out->write( data = ls_price_products
                     name = |ls_price_products| ).
    ENDIF.
  ENDMETHOD.

  METHOD count_instruction.
    io_out->write( |count_instruction| ).

    SELECT FROM zahr_products
      FIELDS COUNT( product_id ) AS Counter
      INTO @DATA(ls_price_products).

    IF sy-subrc = 0.
      io_out->write( data = ls_price_products
                     name = |ls_price_products| ).
    ENDIF.
  ENDMETHOD.

  METHOD group_by_having_instruction.
    io_out->write( |group_by_having_instruction| ).

    SELECT FROM zahr_products
      FIELDS category_id,
             AVG( price ) AS Avg_Price
      WHERE price >= 100
      GROUP BY category_id
      HAVING category_id IN ( 2 )
      INTO TABLE @DATA(lt_price_products).

    IF sy-subrc = 0.
      io_out->write( data = lt_price_products
                     name = |lt_price_products| ).
    ENDIF.
  ENDMETHOD.

  METHOD order_by_offset_instruction.
    io_out->write( |order_by_offset_instruction| ).

    SELECT FROM zahr_products
      FIELDS product_name,
             price
      ORDER BY price DESCENDING
      INTO TABLE @DATA(lt_products)
      OFFSET 2.

    IF sy-subrc = 0.
      io_out->write( data = lt_products
                     name = |lt_products| ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
