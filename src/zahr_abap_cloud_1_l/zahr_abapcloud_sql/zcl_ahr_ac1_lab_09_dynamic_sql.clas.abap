CLASS zcl_ahr_ac1_lab_09_dynamic_sql DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    TYPES: BEGIN OF ty_product,
             product_name TYPE zahr_products-product_name,
             price        TYPE zahr_products-price,
           END OF ty_product.

    DATA lv_datasource_name  TYPE string VALUE 'zahr_products'.
    DATA lv_selected_columns TYPE string VALUE 'product_name, price'.
    DATA lv_where_conditions TYPE string VALUE 'price ge 1500'.
    DATA lt_products         TYPE STANDARD TABLE OF ty_product.

    METHODS ABAP_SQL_dynamic_specification IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS ABAP_SQL_dynamic_programming   IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_09_dynamic_sql IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    abap_sql_dynamic_specification( io_out = out ).

    abap_sql_dynamic_programming( io_out = out ).
  ENDMETHOD.

  METHOD abap_sql_dynamic_specification.
    io_out->write( |abap_sql_dynamic_specification| ).

    TRY.
        SELECT
          FROM (lv_datasource_name)
          FIELDS (lv_selected_columns)
          WHERE (lv_where_conditions)
          INTO CORRESPONDING FIELDS OF TABLE @lt_products.
        IF sy-subrc = 0.
          io_out->write( lt_products ).
        ENDIF.
      CATCH cx_sy_dynamic_osql_syntax
            cx_sy_dynamic_osql_semantics
            cx_sy_dynamic_osql_error INTO DATA(lx_dynamic_osql).
        io_out->write( lx_dynamic_osql->get_text( ) ).
    ENDTRY.
  ENDMETHOD.

  METHOD abap_sql_dynamic_programming.
    io_out->write( |abap_sql_dynamic_programming| ).

    DATA lo_generic_data TYPE REF TO data.
    FIELD-SYMBOLS <lt_itab> TYPE STANDARD TABLE.
    TRY.

        DATA(lo_comp_table) = CAST cl_abap_structdescr(
            cl_abap_typedescr=>describe_by_name( lv_datasource_name )
                )->get_components( ).
        DATA(lo_struct_type) = cl_abap_structdescr=>create( lo_comp_table ).
        DATA(lo_table_type) = cl_abap_tabledescr=>create( lo_struct_type ).

        CREATE DATA lo_generic_data TYPE HANDLE lo_table_type.
        ASSIGN lo_generic_data->* TO <lt_itab>.

        SELECT
          FROM (lv_datasource_name)
          FIELDS (lv_selected_columns)
          WHERE (lv_where_conditions)
          INTO TABLE @<lt_itab>.
        IF sy-subrc = 0.
          io_out->write( lt_products ).
        ENDIF.
      CATCH cx_sy_dynamic_osql_syntax
            cx_sy_dynamic_osql_semantics
            cx_sy_dynamic_osql_error INTO DATA(lx_dynamic_osql).
        io_out->write( lx_dynamic_osql->get_text( ) ).
        RETURN.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
