CLASS zcl_ahr_ac1_lab_05_invoice_ext DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

    DATA lv_regex     TYPE string VALUE '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0 9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'.
    DATA lv_idcustome TYPE string.

  PRIVATE SECTION.
    METHODS overlay            IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS substring_function IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS find_function      IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS replace_function   IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS pcre               IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS regular_expresions IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS repeat_function    IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS escape_function    IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_05_INVOICE_EXT IMPLEMENTATION.


  METHOD escape_function.
    DATA lv_format TYPE string VALUE 'Send payment data via Internet'.

    " URL
    DATA(lv_url) = escape( val    = lv_format
                           format = cl_abap_format=>e_uri_full ).
    io_out->write( lv_url ).

    " JSON
    DATA(lv_json) = escape( val    = lv_format
                            format = cl_abap_format=>e_json_string ).
    io_out->write( lv_json ).

    " String Templates
    DATA(lv_string_tpl) = escape( val    = lv_format
                                  format = cl_abap_format=>e_string_tpl ).
    io_out->write( lv_string_tpl ).
  ENDMETHOD.


  METHOD find_function.
    DATA lv_status TYPE string VALUE 'INVOICE GENERATED SUCCESSFULLY'.
    DATA lv_count  TYPE i.

    lv_count = find_any_of( val = lv_status
                            sub = 'GEN' ).
    lv_count = sy-fdpos + 1.
    io_out->write( lv_count ).

    FIND ALL OCCURRENCES OF 'A' IN lv_status MATCH COUNT lv_count.
    io_out->write( lv_count ).

    lv_count = count( val = lv_status
                      sub = 'A' ).
    io_out->write( lv_count ).
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    " 1. OVERLAY
    overlay( out ).

    " 2. SUBSTRING
    substring_function( out ).

    " 3. FIND
    find_function( out ).

    " 4. REPLACE
    replace_function( out ).

    " 5. PCRE
    pcre( out ).

    " 6. Regular expressions
    regular_expresions( out ).

    " 7. REPEAT
    repeat_function( out ).

    " 8. ESCAPE
    escape_function( out ).
  ENDMETHOD.


  METHOD overlay.
    DATA(lv_sale)        = 'Purchase Completed'.
    DATA(lv_sale_status) = 'Invoice             '.

    OVERLAY lv_sale_status WITH lv_sale.

    io_out->write( lv_sale_status ).
  ENDMETHOD.


  METHOD pcre.
    DATA(lv_email) = 'correo.prueba@servidor.com.mx'.
    lv_regex = '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0 9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$'.

*    FIND REGEX lv_regex IN lv_email.
    FIND PCRE lv_regex IN lv_email.
    IF sy-subrc = 0.
      io_out->write( 'Formato valido' ).
    ELSE.
      io_out->write( 'Formato NO valido' ).
    ENDIF.
  ENDMETHOD.


  METHOD regular_expresions.
    lv_idcustome = '0000012345'.
    lv_regex = '0*'.

    io_out->write( lv_idcustome ).
    lv_idcustome = replace( val  = lv_idcustome
                            pcre = lv_regex
                            with = ''
                            occ  = 0 ).
    io_out->write( lv_idcustome ).
  ENDMETHOD.


  METHOD repeat_function.
    lv_idcustome = '0000012345'.
    io_out->write( lv_idcustome ).

    lv_idcustome = repeat( val = lv_idcustome
                           occ = 3 ).
    io_out->write( lv_idcustome ).
  ENDMETHOD.


  METHOD replace_function.
    DATA(lv_request) = 'SAP-ABAP-32-PE'.
    io_out->write( lv_request ).

    REPLACE ALL OCCURRENCES OF '-' IN lv_request WITH '/'.
    io_out->write( lv_request ).

    lv_request = 'SAP-ABAP-32-PE'.
    lv_request = replace( val  = lv_request
                          sub  = '-'
                          with = '/'
                          occ  = 0 ).
    io_out->write( lv_request ).
  ENDMETHOD.


  METHOD substring_function.
    DATA lv_result TYPE string VALUE 'SAP-ABAP-32-PE'.

    io_out->write( lv_result ).

    lv_result = substring( val = lv_result
                           off = 9
                           len = 5 ).
    io_out->write( |Substring: { lv_result }|  ).

    lv_result = 'SAP-ABAP-32-PE'.
    lv_result = substring_before( val = lv_result
                                  sub = 'ABAP' ).
    io_out->write( |Substring Before ABAP: { lv_result }| ).

    lv_result = 'SAP-ABAP-32-PE'.
    lv_result = substring_after( val = lv_result
                                 sub = 'ABAP' ).
    io_out->write( |Substring After ABAP: { lv_result }| ).
  ENDMETHOD.
ENDCLASS.
