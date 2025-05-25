CLASS zcl_ahr_ac1_lab_10_insert_univ DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    TYPES: tt_records_university TYPE STANDARD TABLE OF zahr_university.

  PRIVATE SECTION.

    DATA: lt_zahr_university TYPE STANDARD TABLE OF zahr_university.

    METHODS: load_records EXPORTING im_t_records TYPE tt_records_university.

ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_10_INSERT_UNIV IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DELETE FROM zahr_university.

    load_records( IMPORTING im_t_records = lt_zahr_university ).

    MODIFY zahr_university FROM TABLE @lt_zahr_university.
    IF sy-subrc = 0.
      out->write( |Rows Affected: { sy-dbcnt }| ).
      out->write( data = lt_zahr_university name = 'lt_zahr_university' ).
    ENDIF.

  ENDMETHOD.


  METHOD load_records.

    im_t_records = VALUE #(   ( client       = sy-mandt
                                soc          = '1000'
                                exercise     = '2020'
                                student_id   = 'A001'
                                first_name   = 'Liam'
                                last_name    = 'Neeson'
                                course_code  = 'A1'
                                course_price = 1000
                                currency     = 'MXN'
                                courses      = 1
                                unit         = 'UN' )
                              ( client       = sy-mandt
                                soc          = '2000'
                                exercise     = '2021'
                                student_id   = 'A002'
                                first_name   = 'Bruce'
                                last_name    = 'Willis'
                                course_code  = 'B1'
                                course_price = 2000
                                currency     = 'MXN'
                                courses      = 1
                                unit         = 'UN' )
                              ( client       = sy-mandt
                                soc          = '3000'
                                exercise     = '2022'
                                student_id   = 'A003'
                                first_name   = 'Jim'
                                last_name    = 'Carrey'
                                course_code  = 'C1'
                                course_price = 3000
                                currency     = 'MXN'
                                courses      = 1
                                unit         = 'UN' )
                              ( client       = sy-mandt
                                soc          = '4000'
                                exercise     = '2023'
                                student_id   = 'A004'
                                first_name   = 'Will'
                                last_name    = 'Smith'
                                course_code  = 'D1'
                                course_price = 4000
                                currency     = 'MXN'
                                courses      = 1
                                unit         = 'UN' )
                              ( client       = sy-mandt
                                soc          = '5000'
                                exercise     = '2024'
                                student_id   = 'A005'
                                first_name   = 'Jason'
                                last_name    = 'Statham'
                                course_code  = 'E1'
                                course_price = 5000
                                currency     = 'MXN'
                                courses      = 1
                                unit         = 'UN' )

                              ( client       = sy-mandt
                                soc          = '1000'
                                exercise     = '2024'
                                student_id   = 'A005'
                                first_name   = 'Jason'
                                last_name    = 'Statham'
                                course_code  = 'E1'
                                course_price = 5000
                                currency     = 'MXN'
                                courses      = 1
                                unit         = 'UN' ) ).

  ENDMETHOD.
ENDCLASS.
