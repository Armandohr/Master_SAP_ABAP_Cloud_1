CLASS zcl_ahr_ac1_lab_08_fieldsymbol DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS declaration IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS online_declaration IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS add_record IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS insert_record IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS read_record IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS coercion_casting IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.


CLASS zcl_ahr_ac1_lab_08_fieldsymbol IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "1. Declarations
    declaration( io_out = out ).

    "2. Online declarations
    online_declaration( io_out = out ).

    "3. Add record
    add_record( io_out = out ).

    "4. Insert record
    insert_record( io_out = out ).

    "5. Read record
    read_record( io_out = out ).

    "6. Coercion - Casting
    coercion_casting( io_out = out ).

  ENDMETHOD.

  METHOD declaration.

    io_out->write( to_upper( |--> declaration <--| ) ).

    DATA: lv_employee TYPE string VALUE 'Francisco Villa'.
    FIELD-SYMBOLS: <lf_employee> TYPE string.

    io_out->write( data = lv_employee
                   name = 'lv_employee' ).

    ASSIGN lv_employee TO <lf_employee>.

    <lf_employee> = 'Emiliano Zapata'.

    io_out->write( data = lv_employee
                   name = 'lv_employee' ).

  ENDMETHOD.

  METHOD online_declaration.

    io_out->write( to_upper( |--> online_declaration <--| ) ).

    SELECT FROM zahr_emp_logali
    FIELDS *
      INTO TABLE @DATA(lt_employees).

    io_out->write( data = lt_employees
                   name = 'lt_employees' ).

    LOOP AT lt_employees ASSIGNING FIELD-SYMBOL(<ls_employees>).
      <ls_employees>-email = 'NUEVO_CORREO@SERVIDOR.COM'.
    ENDLOOP.

    io_out->write( data = lt_employees
                   name = 'lt_employees' ).

  ENDMETHOD.

  METHOD add_record.

    io_out->write( to_upper( |--> add_record <--| ) ).

    SELECT FROM zahr_emp_logali
    FIELDS *
      INTO TABLE @DATA(lt_employees).

    APPEND INITIAL LINE TO lt_employees ASSIGNING FIELD-SYMBOL(<ls_employees>).

    IF <ls_employees> IS ASSIGNED.
      <ls_employees> = VALUE #( "client = sy-mandt
                                id     = |{ '12' ALPHA = IN }|
                                email  = to_lower( 'CLAUDIA.ALDANA.ZAMORA@server.com' )
                                apel   = 'ALDANA'
                                ape2   = 'ZAMORA'
                                name   = 'CLAUDIA'
                                fechan = '19780106'
                                fechaa = cl_abap_context_info=>get_system_date( ) ).
      UNASSIGN <ls_employees>.
    ENDIF.
    io_out->write( data = lt_employees
                   name = 'lt_employees' ).

  ENDMETHOD.

  METHOD insert_record.

    io_out->write( to_upper( |--> insert_record <--| ) ).

    SELECT FROM zahr_emp_logali
    FIELDS *
      INTO TABLE @DATA(lt_employees).

    INSERT INITIAL LINE INTO lt_employees ASSIGNING FIELD-SYMBOL(<ls_employees>) INDEX 2.

    IF <ls_employees> IS ASSIGNED.
      <ls_employees> = VALUE #( "client = sy-mandt
                                id     = |{ '12' ALPHA = IN }|
                                email  = to_lower( 'CLAUDIA.ALDANA.ZAMORA@server.com' )
                                apel   = 'ALDANA'
                                ape2   = 'ZAMORA'
                                name   = 'CLAUDIA'
                                fechan = '19780106'
                                fechaa = cl_abap_context_info=>get_system_date( ) ).
      UNASSIGN <ls_employees>.
    ENDIF.
    io_out->write( data = lt_employees
                   name = 'lt_employees' ).

  ENDMETHOD.

  METHOD read_record.

    io_out->write( to_upper( |--> read_record <--| ) ).

    SELECT FROM zahr_emp_logali
    FIELDS *
      INTO TABLE @DATA(lt_employees).

    READ TABLE lt_employees ASSIGNING FIELD-SYMBOL(<ls_employees>) WITH KEY name = 'VERONICA'.
    IF <ls_employees> IS ASSIGNED.
      io_out->write( data = <ls_employees>
                     name = '<ls_employees>' ).
      <ls_employees>-name = 'DIANA'.
      <ls_employees>-email = 'NUEVO_CORREO_DE_DIANA@NUEVO_SERVIDOR.COM'.
    ENDIF.

    io_out->write( data = lt_employees
                   name = 'lt_employees' ).

  ENDMETHOD.

  METHOD coercion_casting.

    io_out->write( to_upper( |--> coercion_casting <--| ) ).

    DATA: lv_date TYPE d.
    FIELD-SYMBOLS: <lf_date> TYPE n.

    ASSIGN lv_date TO <lf_date> CASTING.

    IF <lf_date> IS ASSIGNED.
      <lf_date> = cl_abap_context_info=>get_system_date(  ).
    ENDIF.

    io_out->write( data = lv_date
                   name = 'lv_date' ).

  ENDMETHOD.

ENDCLASS.
