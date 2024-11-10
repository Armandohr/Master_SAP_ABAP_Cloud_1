CLASS zcl_ahr_ac1_lab_03_datatypes DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
        ty_char10 TYPE c LENGTH 10.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_ahr_ac1_lab_03_datatypes IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**1. Conversiones de Tipo
*
    DATA:
      mv_char  TYPE c LENGTH 10 VALUE '12345',
      mv_num   TYPE i,
      mv_float TYPE f.

    mv_num = mv_char.

    out->write( |Convert from character type { mv_char } to integer type { mv_num }.| ).

    out->write( mv_char ).
    out->write( mv_num ).

    mv_float = mv_num.

    out->write( |Convert from character type { mv_char } to float type { mv_float }.| ).
    out->write( mv_num ).
    out->write( mv_float ).

*2. Truncamiento y Redondeo
    DATA:
      mv_trunc TYPE i,
      mv_round TYPE i.

    mv_float = '123.45'.
    mv_trunc = mv_float.

    out->write( |{ mv_float } --> { mv_trunc }| ).
    out->write( mv_float ).
    out->write( mv_trunc ).

    mv_float += '0.5'.
    mv_round = mv_float.

    out->write( |{ mv_float } --> { mv_round }| ).
    out->write( mv_float ).
    out->write( mv_round ).

*    3. Tipos en declaraciones en línea
    DATA(mv_inline) = 'ABAP'.
    out->write( |{ mv_inline }| ).

*    4. Conversiones del Tipo Forzado
    mv_num = CONV i( mv_char ) .
    out->write( |Convert from character type { mv_char } to integer type { mv_num }.| ).
    out->write( mv_char ).
    out->write( mv_num ).

**    5. Cálculo de Fecha y Hora
    DATA:
      mv_date_1 TYPE d VALUE '20241014',
      mv_date_2 TYPE d VALUE '20240930',
      mv_days   TYPE i,
      mv_time   TYPE t.

    mv_days = mv_date_1 - mv_date_2.
    out->write( mv_days ).
    out->write( mv_date_1 ).

*    6. Campos Timestamp
    DATA:
        mv_timestamp TYPE utclong.

    mv_timestamp = utclong_current( ).
    out->write( mv_timestamp ).

    TRY.
        CONVERT UTCLONG mv_timestamp
        TIME ZONE cl_abap_context_info=>get_user_time_zone(  )
        INTO DATE mv_date_2 TIME mv_time.

        out->write( mv_date_2 ).
        out->write( mv_time ).
      CATCH cx_abap_context_info_error.
        "handle exception
    ENDTRY.

    mv_timestamp = utclong_add( val = mv_timestamp days = -2 ).
    out->write( mv_timestamp ).

  ENDMETHOD.

ENDCLASS.
