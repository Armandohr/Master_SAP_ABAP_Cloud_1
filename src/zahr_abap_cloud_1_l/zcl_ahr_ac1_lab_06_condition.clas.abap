CLASS zcl_ahr_ac1_lab_06_condition DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    CONSTANTS co_conditional TYPE i VALUE 7.

    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    METHODS if_method IMPORTING io_out         TYPE REF TO if_oo_adt_classrun_out
                                iv_conditional TYPE i.

    METHODS case_method IMPORTING io_out    TYPE REF TO if_oo_adt_classrun_out
                                  iv_string TYPE string.

    METHODS do_method IMPORTING io_out      TYPE REF TO if_oo_adt_classrun_out
                                iv_max_iter TYPE i.

    METHODS check_method IMPORTING io_out      TYPE REF TO if_oo_adt_classrun_out
                                   iv_max_iter TYPE i.

    METHODS switch_method IMPORTING io_out    TYPE REF TO if_oo_adt_classrun_out
                                    iv_string TYPE string.

    METHODS cond_method IMPORTING io_out  TYPE REF TO if_oo_adt_classrun_out
                                  iv_time TYPE t.
    METHODS while_method IMPORTING io_out      TYPE REF TO if_oo_adt_classrun_out
                                   iv_max_iter TYPE i.
    METHODS loop_method IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS try_method IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS zcl_ahr_ac1_lab_06_condition IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " 1.  IF / ENDIF
    if_method( io_out         = out
               iv_conditional = 7 ).
    if_method( io_out         = out
               iv_conditional = 6 ).

    " 2.  CASE / ENDCASE
    case_method( io_out    = out
                 iv_string = 'LOGALI' ).
    case_method( io_out    = out
                 iv_string = 'SAP' ).
    case_method( io_out    = out
                 iv_string = 'MASTER' ).

    " 3.    DO / ENDDO
    do_method( io_out      = out
               iv_max_iter = 10 ).

    " 4.    CHECK
    check_method( io_out      = out
                  iv_max_iter = 10 ).
    " 5.    SWITCH
    switch_method( io_out    = out
                   iv_string = 'LOGALI' ).
    switch_method( io_out    = out
                   iv_string = 'SAP' ).
    switch_method( io_out    = out
                   iv_string = 'MOVISTAR' ).
    switch_method( io_out    = out
                   iv_string = 'MASTER' ).
    " 6.    COND
    cond_method( io_out  = out
                 iv_time = cl_abap_context_info=>get_system_time( ) ).

    " 7.    WHILE / ENDWHILE
    while_method( io_out      = out
                  iv_max_iter = 20 ).
    " 8.    LOOP / ENDLOOP
    loop_method( io_out = out ).
    " 9.    TRY / ENDTRY
    try_method( io_out = out ).

  ENDMETHOD.

  METHOD if_method.

    DATA lv_conditional TYPE i.

    lv_conditional = iv_conditional.

    IF lv_conditional = zcl_ahr_ac1_lab_06_condition=>co_conditional.
      io_out->write( |El valor { lv_conditional } de la variable es igual a { zcl_ahr_ac1_lab_06_condition=>co_conditional }| ).
    ELSE.
      io_out->write( |El valor { lv_conditional } de la variable es diferente a { zcl_ahr_ac1_lab_06_condition=>co_conditional }| ).
    ENDIF.

  ENDMETHOD.

  METHOD case_method.

    DATA lv_string TYPE string.

    lv_string = iv_string.

    CASE lv_string.
      WHEN 'LOGALI'.
        io_out->write( |{ lv_string } --> Academy| ).
      WHEN 'SAP'.
        io_out->write( |{ lv_string } --> Enterprise software| ).
      WHEN OTHERS.
        io_out->write( |{ lv_string } --> Unknown| ).
    ENDCASE.

  ENDMETHOD.

  METHOD do_method.

    DATA lv_counter TYPE i.
    DATA lv_max_iter TYPE i.

    lv_max_iter = iv_max_iter.

    DO lv_max_iter TIMES.
      lv_counter += 1.
      io_out->write( |El valor de la variable es { lv_counter }| ).
    ENDDO.

  ENDMETHOD.

  METHOD check_method.

    DATA lv_counter TYPE i.
    DATA lv_max_iter TYPE i.

    lv_max_iter = iv_max_iter.

    DO lv_max_iter TIMES.
      io_out->write( |El valor de la variable es { lv_counter }| ).
      lv_counter += 1.
      CHECK lv_counter > 7.
      EXIT.
    ENDDO.


  ENDMETHOD.

  METHOD switch_method.

    DATA lv_string TYPE string.

    lv_string = iv_string.

    DATA(lv_string_2) = SWITCH #( lv_string
                                       WHEN 'LOGALI'   THEN |SAP Academy|
                                       WHEN 'SAP'      THEN |Enterprise software|
                                       WHEN 'MOVISTAR' THEN |Telephony|
                                       ELSE |Unknown| ).

    io_out->write( |{ lv_string } --> { lv_string_2 }| ).

  ENDMETHOD.

  METHOD cond_method.

    DATA(lv_time) = iv_time.

    DATA(lv_str_time) = COND #( WHEN lv_time < '120000' THEN |{ lv_time TIME = ISO } AM |
                                WHEN lv_time > '120000' THEN |{ CONV t( lv_time - 12 * 3600 )  TIME = ISO } PM |
                                WHEN lv_time = '120000' THEN |{ lv_time TIME = ISO } High Noon |
                                ELSE |Unidentified time| ).

    io_out->write( lv_str_time ).

  ENDMETHOD.

  METHOD while_method.

    DATA lv_counter  TYPE i.
    DATA lv_max_iter TYPE i.

    lv_max_iter = iv_max_iter.

    WHILE lv_counter < lv_max_iter.
      lv_counter += 1.
      IF lv_counter > 10.
        CONTINUE.
      ENDIF.
      io_out->write( |El valor de la variable es { lv_counter }| ).
    ENDWHILE.

  ENDMETHOD.

  METHOD loop_method.

    DATA lt_employees TYPE STANDARD TABLE OF zahr_emp_logali.
    DATA ls_employees TYPE zahr_emp_logali.

    SELECT FROM zahr_emp_logali
      FIELDS *
      INTO TABLE @lt_employees.

    LOOP AT lt_employees INTO ls_employees WHERE ape2 = 'JIMENEZ'.
      io_out->write( |{ ls_employees-email }| ).
    ENDLOOP.

  ENDMETHOD.

  METHOD try_method.

    DATA lv_exception TYPE f VALUE 5.
    DATA lv_counter TYPE i VALUE 5.

    DO 5 TIMES.
      TRY.

          lv_counter -= 1.

          DATA(lv_result) = lv_exception / lv_counter.

          io_out->write( |{ lv_exception } / { lv_counter } = { lv_result }| ).

        CATCH cx_sy_zerodivide.
          io_out->write( |{ lv_exception } / { lv_counter } = No se puede dividir entre CERO| ).
      ENDTRY.

    ENDDO.


  ENDMETHOD.

ENDCLASS.
