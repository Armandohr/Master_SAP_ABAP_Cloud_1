CLASS zcl_ahr_department_code DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS ZCL_AHR_DEPARTMENT_CODE IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    AUTHORITY-CHECK OBJECT 'ZAODEPAAHR'
                    ID 'ZAFD_AHR'
                    FIELD '02'.
    IF sy-subrc = 0.
      SELECT FROM /dmo/airport
      FIELDS *
        INTO TABLE @FINAL(lt_table).
      out->write( lt_table ).
    ELSE.
      out->write( 'The user does not have the necessary permissions' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
