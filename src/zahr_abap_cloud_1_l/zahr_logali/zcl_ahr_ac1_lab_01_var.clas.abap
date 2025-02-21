CLASS zcl_ahr_ac1_lab_01_var DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_01_VAR IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*--> 1. Elementary data type

    DATA:
      mv_purchase_date TYPE d,
      mv_purchase_time TYPE t.

    mv_purchase_date = cl_abap_context_info=>get_system_date(  ).
    out->write( mv_purchase_date ).

    mv_purchase_time = cl_abap_context_info=>get_system_time(  ).
    out->write( mv_purchase_time ).

    DATA:
      mv_price TYPE f VALUE '10.5',
      mv_tax   TYPE i VALUE 16.

    DATA:
      mv_increase  TYPE decfloat16 VALUE '20.5',
      mv_discounts TYPE decfloat34 VALUE '10.5'.

    DATA:
      mv_type     TYPE c LENGTH 10 VALUE 'PC',
      mv_shipping TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36'.

    DATA:
      mv_id_code TYPE n LENGTH 4 VALUE 1110,
      mv_qr_code TYPE x LENGTH 5 VALUE 'F5CF'.

*--> 2. Complex data type

    TYPES: BEGIN OF mty_customer,
             id       TYPE i,
             customer TYPE c LENGTH 15,
             age      TYPE i,
           END OF mty_customer.

    DATA:
        ms_customer TYPE mty_customer.

    ms_customer = VALUE #( id = '1' customer = 'Armando' age = 46 ).

    out->write( |ID: { ms_customer-id } Customer: { ms_customer-customer } Age: { ms_customer-age } | ).

*--> 3. Reference data type

    DATA:
*        ms_employees TYPE REF TO snwd_employees,
      ms_employee_hr TYPE /dmo/employee_hr,
*      ms_employee_hr TYPE REF TO /dmo/employee_hr,
      ms_airport     TYPE REF TO /dmo/airport.

    ms_employee_hr-employee = '001'.
*    ms_airport-airport_id = 'LAX'.
*    ms_airport2-airport_id = 'LAX'.
*    ms_airport = VALUE #( airport_id = 'LAX'
*                          name = 'Los Angeles International Airport'
*                          city = 'Los Angeles, California'
*                          country = 'US' ).

*--> 4. Data objects

    DATA:
      mv_product  TYPE string VALUE 'Laptop',
      mv_bar_code TYPE xstring VALUE '12121121211'.

*--> 5. Constants
    CONSTANTS:
      mc_price     TYPE f VALUE '10.5',
      mc_tax       TYPE i VALUE 16,
      mc_increase  TYPE decfloat16 VALUE '20.5',
      mc_discounts TYPE decfloat34 VALUE '10.5',
      mc_type      TYPE c LENGTH 10 VALUE 'PC',
      mc_shipping  TYPE p LENGTH 8 DECIMALS 2 VALUE '40.36',
      mc_id_code   TYPE n LENGTH 4 VALUE 1110,
      mc_qr_code   TYPE x LENGTH 5 VALUE 'F5CF',
      mc_product   TYPE string VALUE 'Laptop',
      mc_bar_code  TYPE xstring VALUE '12121121211'.

*    DATA:
*      mv_price2 TYPE f VALUE mc_price,
*      mv_tax2   TYPE i VALUE mc_tax.

    mv_price = mc_price.
    mv_tax = mc_tax.
    mv_increase = mc_increase.
    mv_discounts = mc_discounts.
    mv_type = mc_type.
    mv_shipping = mc_shipping.
    mv_id_code = mc_id_code.
    mv_qr_code = mc_qr_code.

*--> 6. In line Declarations
    DATA(lv_product) = mc_product.
    DATA(lv_bar_code) = mc_bar_code.

  ENDMETHOD.
ENDCLASS.
