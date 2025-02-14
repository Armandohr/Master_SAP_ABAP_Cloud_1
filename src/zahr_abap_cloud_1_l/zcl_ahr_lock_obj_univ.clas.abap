CLASS zcl_ahr_lock_obj_univ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.

  PRIVATE SECTION.

    METHODS lock_object_univ IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS sql_query_univ IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.


ENDCLASS.



CLASS zcl_ahr_lock_obj_univ IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    lock_object_univ( io_out = out ).

    sql_query_univ( io_out = out ).

  ENDMETHOD.

  METHOD lock_object_univ.

    io_out->write( |User has started the business process| ).

    TRY.
        DATA(lo_lock_object) = cl_abap_lock_object_factory=>get_instance(
          EXPORTING
            iv_name = 'EZ_AHR_UNIV_LOCK' ).
      CATCH cx_abap_lock_failure.
        io_out->write( |Lock object instance not created| ).
        RETURN.
    ENDTRY.

    TRY.

        DATA:   lt_parameter    TYPE if_abap_lock_object=>tt_parameter.

        lt_parameter = VALUE #( ( name = 'SOC'  value = REF #( '6000' ) ) ).

        lo_lock_object->enqueue( it_parameter = lt_parameter ).

      CATCH cx_abap_foreign_lock.
        io_out->write( |Foreign lock exception| ).
      CATCH cx_abap_lock_failure.
        io_out->write( |Not possible to write on the database. Object is locked| ).
    ENDTRY.

    io_out->write( |Lock object is active| ).

    DATA ls_record TYPE zahr_university.

    ls_record = VALUE zahr_university( client       = sy-mandt
                                       soc          = '2000'
                                       exercise     = '2024'
                                       student_id   = 'A001'
                                       first_name   = 'Liam'
                                       last_name    = 'Neeson'
                                       course_code  = 'A1'
                                       course_price = 1000
                                       currency     = 'MXN'
                                       courses      = 2
                                       unit         = 'UN' ).

    WAIT UP TO 10 SECONDS.

    MODIFY zahr_university FROM @ls_record.
    IF  sy-subrc = 0.
      io_out->write( |Business objec was uploaded on the DDBB| ).
    ENDIF.

    TRY.
        lo_lock_object->dequeue( it_parameter = lt_parameter ).
      CATCH cx_abap_lock_failure.
        io_out->write( |LOCK OBJECT was NOT released| ).
    ENDTRY.

    io_out->write( |Lock object was released| ).

  ENDMETHOD.

  METHOD sql_query_univ.

    SELECT FROM zahr_university
    FIELDS COUNT( * ) as count_2
     WHERE exercise = '2024'
      INTO @DATA(lv_dynamic).

    io_out->write( lv_dynamic ).

  ENDMETHOD.

ENDCLASS.
