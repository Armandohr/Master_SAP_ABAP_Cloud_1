CLASS zcl_ahr_ac1_emp_logali DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ahr_ac1_emp_logali IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA lt_ahr_emp_logali TYPE STANDARD TABLE OF zahr_emp_logali.
*
    DELETE FROM zahr_emp_logali.

    lt_ahr_emp_logali = VALUE #( client = sy-mandt
                              ( id     = |{ '1' ALPHA = IN }|
                                email  = to_lower( 'LAURA.PEREZ.JIMENEZ@server.com' )
                                apel   = 'PEREZ'
                                ape2   = 'JIMENEZ'
                                name   = 'LAURA'
                                fechan = '19901020'
                                fechaa = '20101113' )
                              ( id     = |{ '2' ALPHA = IN }|
                                email  = to_lower( 'LORENA.JIMENEZ.FERNANDEZ@server.com' )
                                apel   = 'JIMENEZ'
                                ape2   = 'FERNANDEZ'
                                name   = 'LORENA'
                                fechan = '19911020'
                                fechaa = '20101113' )
                              ( id     = |{ '3' ALPHA = IN }|
                                email  = to_lower( 'SANDRA.LOPEZ.PEREZ@server.com' )
                                apel   = 'LOPEZ'
                                ape2   = 'PEREZ'
                                name   = 'SANDRA'
                                fechan = '19901020'
                                fechaa = '20111113' )
                              ( id     = |{ '4' ALPHA = IN }|
                                email  = to_lower( 'LORENA.VALENCIA.JIMENEZ@server.com' )
                                apel   = 'VALENCIA'
                                ape2   = 'JIMENEZ'
                                name   = 'LORENA'
                                fechan = '19901020'
                                fechaa = '20131113' )
                              ( id     = |{ '5' ALPHA = IN }|
                                email  = to_lower( 'VALENCIA.LEON.LOPEZ@server.com' )
                                apel   = 'LEON'
                                ape2   = 'LOPEZ'
                                name   = 'VERONICA'
                                fechan = '19931020'
                                fechaa = '20101113' )
                              ( id     = |{ '6' ALPHA = IN }|
                                email  = to_lower( 'GUADALUPE.JUAREZ.CANTU@server.com' )
                                apel   = 'JUAREZ'
                                ape2   = 'CANTU'
                                name   = 'GUADALUPE'
                                fechan = '19901020'
                                fechaa = '20101113' )
                              ( id     = |{ '7' ALPHA = IN }|
                                email  = to_lower( 'TERESA.FERNANDEZ.SALAS@server.com' )
                                apel   = 'FERNANDEZ'
                                ape2   = 'SALAS'
                                name   = 'TERESA'
                                fechan = '19901020'
                                fechaa = '20161113' )
                              ( id     = |{ '8' ALPHA = IN }|
                                email  = to_lower( 'FRANCISCA.CASTREJON.MEJIA@server.com' )
                                apel   = 'CASTREJON'
                                ape2   = 'MEJIA'
                                name   = 'FRANCISCA'
                                fechan = '19941020'
                                fechaa = '20101113' )
                              ( id     = |{ '9' ALPHA = IN }|
                                email  = to_lower( 'ALEJANDRA.SANDOVAL.SANCHEZ@server.com' )
                                apel   = 'SANDOVAL'
                                ape2   = 'SANCHEZ'
                                name   = 'ALEJANDRA'
                                fechan = '19901020'
                                fechaa = '20181113' )
                              ( id     = |{ '10' ALPHA = IN }|
                                email  = to_lower( 'SANDRA.ROSALES.JIMENEZ@server.com' )
                                apel   = 'ROSALES'
                                ape2   = 'JIMENEZ'
                                name   = 'SANDRA'
                                fechan = '19961020'
                                fechaa = '20201113' )
                              ( id     = |{ '11' ALPHA = IN }|
                                email  = to_lower( 'JANETH.VALADEZ.JIMENEZ@server.com' )
                                apel   = 'VALADEZ'
                                ape2   = 'JIMENEZ'
                                name   = 'JANETH'
                                fechan = '19971020'
                                fechaa = '20201113' ) ).

    INSERT zahr_emp_logali FROM TABLE @lt_ahr_emp_logali.
    IF sy-subrc = 0.
      out->write( data = lt_ahr_emp_logali name = 'ZAHR_EMP_LOGALI table load' ).
    ELSE.
      out->write( 'No data was loaded into table ZAHR_EMP_LOGALI' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
