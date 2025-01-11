CLASS zcl_ahr_ac1_lab_09_structure DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    " 1.  Declaración estructuras:

    TYPES: BEGIN OF ty_flights,
             iduser     TYPE c LENGTH 40,
             aircode    TYPE /dmo/carrier_id,
             flightnum  TYPE /dmo/connection_id,
             key        TYPE land1,
             seat       TYPE /dmo/plane_seats_occupied,
             flightdate TYPE /dmo/flight_date,
           END OF ty_flights,

           BEGIN OF ty_airlines,
             carrid    TYPE /dmo/carrier_id,
             connid    TYPE /dmo/connection_id,
             countryfr TYPE land1,
             airfrom   TYPE /dmo/airport_id,
             countryto TYPE land1,
           END OF ty_airlines.

    " 2.    Estructuas anidadas (NESTED)
    TYPES: BEGIN OF ty_nested,
             flights  TYPE ty_flights,
             airlines TYPE ty_airlines,
           END OF ty_nested.

    " 3.    Estructuras complejas (DEEP)
    TYPES: BEGIN OF ty_deep,
             carrid  TYPE /dmo/carrier_id,
             connid  TYPE /dmo/connection_id,
             flights TYPE STANDARD TABLE OF ty_flights  WITH EMPTY KEY,
           END OF ty_deep.

    " 5.    Estructura INCLUDE
    TYPES BEGIN OF ty_include_flights.
    INCLUDE TYPE ty_flights AS fli.
    INCLUDE TYPE ty_airlines AS aero RENAMING WITH SUFFIX _aero.
    TYPES END OF ty_include_flights.


  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA:
      ls_nested          TYPE ty_nested,
      ls_deep            TYPE ty_deep,
      ls_include_flights TYPE ty_include_flights.

ENDCLASS.

CLASS zcl_ahr_ac1_lab_09_structure IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 4.  Añadir datos
    ls_nested = VALUE #( flights  = VALUE #( iduser     = '1'
                                             aircode    = 'QAS'
                                             flightnum  = '1234'
                                             key        = 'MX'
                                             seat       = 10
                                             flightdate = '20250110' )
                         airlines = VALUE #( carrid    = 'XX'
                                             connid    = '1234'
                                             countryfr = 'MX' ) ).

    out->write( data = ls_nested name = 'Nested structure' ).
    out->write( |\n| ).

    ls_deep = VALUE #(
        carrid  = 'XX'
        connid  = '1234'
        flights = VALUE #(
            ( iduser = '1' aircode   = 'QAS' flightnum = '1234' key = 'MX' seat = 10 flightdate = '20250110' )
            ( iduser = '2' aircode   = 'AAA' flightnum = '2345' key = 'UE' seat = 11  flightdate = '20250111' )
            ( iduser = '3' aircode   = 'BBB' flightnum = '3234' key = 'CA' seat = 13  flightdate = '20250112' )  ) ).

    out->write( data = ls_deep name = 'Deep structure' ).
    out->write( |\n| ).

    ls_include_flights = VALUE #( fli         = VALUE #( iduser     = '1'
                                                         aircode    = 'QAS'
                                                         flightnum  = '1234'
                                                         key        = 'MX'
                                                         seat       = 10
                                                         flightdate = '20250110' )
                                  aero-carrid = 'ZZ' ).
    out->write( data = ls_include_flights name = 'Include structure' ).
    out->write( |\n| ).
    " 6.    Eliminar datos
    CLEAR: ls_nested,
            ls_deep.

    out->write( data = ls_nested name = 'Nested structure cleaned.' ).
    out->write( |\n| ).
    out->write( data = ls_nested name = 'Deep structure cleaned.' ).

  ENDMETHOD.

ENDCLASS.
