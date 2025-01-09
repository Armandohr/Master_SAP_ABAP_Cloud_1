CLASS zcl_ahr_ac1_emp_logali DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ahr_ac1_emp_logali IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DELETE FROM zahr_emp_logali.

    INSERT zahr_emp_logali
       FROM TABLE @( VALUE #( client = sy-mandt
                              ( id     = '01'
                                email  = 'LAURA.PEREZ.JIMENEZ@server.com'
                                apel   = 'PEREZ'
                                ape2   = 'JIMENEZ'
                                name   = 'LAURA'
                                fechan = '19901020'
                                fechaa = '20101113' )
                              ( id     = '02'
                                email  = 'LORENA.JIMENEZ.FERNANDEZ@server.com'
                                apel   = 'JIMENEZ'
                                ape2   = 'FERNANDEZ'
                                name   = 'LORENA'
                                fechan = '19911020'
                                fechaa = '20101113' )
                              ( id     = '03'
                                email  = 'SANDRA.LOPEZ.PEREZ@server.com'
                                apel   = 'LOPEZ'
                                ape2   = 'PEREZ'
                                name   = 'SANDRA'
                                fechan = '19901020'
                                fechaa = '20111113' )
                              ( id     = '04'
                                email  = 'LORENA.VALENCIA.JIMENEZ@server.com'
                                apel   = 'VALENCIA'
                                ape2   = 'JIMENEZ'
                                name   = 'LORENA'
                                fechan = '19901020'
                                fechaa = '20131113' )
                              ( id     = '05'
                                email  = 'VALENCIA.LEON.LOPEZ@server.com'
                                apel   = 'LEON'
                                ape2   = 'LOPEZ'
                                name   = 'VERONICA'
                                fechan = '19931020'
                                fechaa = '20101113' )
                              ( id     = '06'
                                email  = 'GUADALUPE.JUAREZ.CANTU@server.com'
                                apel   = 'JUAREZ'
                                ape2   = 'CANTU'
                                name   = 'GUADALUPE'
                                fechan = '19901020'
                                fechaa = '20101113' )
                              ( id     = '07'
                                email  = 'TERESA.FERNANDEZ.SALAS@server.com'
                                apel   = 'FERNANDEZ'
                                ape2   = 'SALAS'
                                name   = 'TERESA'
                                fechan = '19901020'
                                fechaa = '20161113' )
                              ( id     = '08'
                                email  = 'FRANCISCA.CASTREJON.MEJIA@server.com'
                                apel   = 'CASTREJON'
                                ape2   = 'MEJIA'
                                name   = 'FRANCISCA'
                                fechan = '19941020'
                                fechaa = '20101113' )
                              ( id     = '09'
                                email  = 'ALEJANDRA.SANDOVAL.SANCHEZ@server.com'
                                apel   = 'SANDOVAL'
                                ape2   = 'SANCHEZ'
                                name   = 'ALEJANDRA'
                                fechan = '19901020'
                                fechaa = '20181113' )
                              ( id     = '10'
                                email  = 'SANDRA.ROSALES.JIMENEZ@server.com'
                                apel   = 'ROSALES'
                                ape2   = 'JIMENEZ'
                                name   = 'SANDRA'
                                fechan = '19961020'
                                fechaa = '20201113' )
                              ( id     = '11'
                                email  = 'JANETH.VALADEZ.JIMENEZ@server.com'
                                apel   = 'VALADEZ'
                                ape2   = 'JIMENEZ'
                                name   = 'JANETH'
                                fechan = '19971020'
                                fechaa = '20201113' ) ) ).
  ENDMETHOD.

ENDCLASS.
