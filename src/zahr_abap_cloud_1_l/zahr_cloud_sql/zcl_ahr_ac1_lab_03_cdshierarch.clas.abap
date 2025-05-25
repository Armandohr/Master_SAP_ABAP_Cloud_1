CLASS zcl_ahr_ac1_lab_03_cdshierarch DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

  PROTECTED SECTION.

  PRIVATE SECTION.

    DATA lc_var TYPE i VALUE 1.

    METHODS Hierarchy_Data_Model IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Hierarchy_CDS IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Hierarchical_Selection IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS Path_Expression_Associations IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.
    METHODS CDS_with_parameters IMPORTING io_out TYPE REF TO if_oo_adt_classrun_out.

ENDCLASS.



CLASS ZCL_AHR_AC1_LAB_03_CDSHIERARCH IMPLEMENTATION.


  METHOD cds_with_parameters.

    io_out->write( |{ cl_abap_char_utilities=>newline } cds_with_parameters| ).

    " CDS with parameters
    SELECT FROM zahr_cds_aviation( pId = @lc_var )
    FIELDS *
      INTO TABLE @DATA(lt_results).

    " Display results
    IF lt_results IS NOT INITIAL.
      io_out->write( lt_results ).
    ENDIF.

  ENDMETHOD.


  METHOD hierarchical_selection.

    io_out->write( |{ cl_abap_char_utilities=>newline } hierarchical_selection| ).

    " Hierarchy – CDS
    TRY.
        SELECT FROM HIERARCHY( SOURCE zahr_cds_aviation( pId = @lc_var )
         CHILD TO PARENT ASSOCIATION _Aviation
         START WHERE id = 1
      SIBLINGS ORDER BY id ASCENDING
      MULTIPLE PARENTS ALLOWED
       ORPHANS ROOT
        CYCLES BREAKUP )
        FIELDS Id,
               ParentId,
               AviationName,
               hierarchy_is_cycle,
               hierarchy_is_orphan,
               hierarchy_level,
               hierarchy_parent_rank,
               hierarchy_rank,
               hierarchy_tree_size
          INTO TABLE @DATA(lt_results).

        " Display results
        IF lt_results IS NOT INITIAL.
          io_out->write( lt_results ).
        ENDIF.

      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        io_out->write( lx_sql_db->get_text( ) ).
    ENDTRY.

  ENDMETHOD.


  METHOD hierarchy_cds.

    io_out->write( |{ cl_abap_char_utilities=>newline } hierarchy_cds| ).

    " Hierarchy – CDS
    TRY.
        SELECT FROM HIERARCHY( SOURCE zahr_cds_aviation( pId = @lc_var )
         CHILD TO PARENT ASSOCIATION _Aviation
         START WHERE id = 1
      SIBLINGS ORDER BY id ASCENDING
         DEPTH 2
      MULTIPLE PARENTS ALLOWED
        CYCLES BREAKUP )
        FIELDS Id,
               ParentId,
               AviationName
          INTO TABLE @DATA(lt_results).

        " Display results
        IF lt_results IS NOT INITIAL.
          io_out->write( lt_results ).
        ENDIF.

      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        io_out->write( lx_sql_db->get_text( ) ).
    ENDTRY.

  ENDMETHOD.


  METHOD hierarchy_data_model.

    io_out->write( |{ cl_abap_char_utilities=>newline } hierarchy_data_model| ).

    DATA lt_results TYPE TABLE OF zahr_avi_parent.
    " Hierarchies and Path Expressions
    DELETE FROM zahr_avi_parent.

    INSERT zahr_avi_parent FROM TABLE @( VALUE #( ( id = 1 parent_id = 0 aviation_name = 'Aviation 1' )
                                                  ( id = 2 parent_id = 1 aviation_name = 'Aviation 2' )
                                                  ( id = 3 parent_id = 2 aviation_name = 'Aviation 3' )
                                                  ( id = 1 parent_id = 2 aviation_name = 'Aviation 1' ) ) ).

    SELECT FROM zahr_avi_parent FIELDS * INTO TABLE @lt_results.
    " Display results
    IF lt_results IS NOT INITIAL.
      io_out->write( lt_results ).
    ENDIF.

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

    hierarchy_data_model( io_out = out ).
    Hierarchy_CDS( io_out = out ).
    Hierarchical_Selection( io_out = out ).
    Path_Expression_Associations( io_out = out ).
    CDS_with_parameters( io_out = out ).

  ENDMETHOD.


  METHOD path_expression_associations.

    io_out->write( |{ cl_abap_char_utilities=>newline } path_expression_associations| ).

    " Path Expression - Associations
    SELECT FROM /dmo/i_flight
    FIELDS AirlineID,
           ConnectionID,
           FlightDate,
           \_Airline[ (1) ]-Name AS Name,
           \_Airline[ CurrencyCode = 'EUR' ]-Name AS AirlineNameEUR,
           \_Airline\_Currency-CurrencyISOCode,
           \_Airline\_Currency\_Text[ Language = 'E' AND Currency = 'EUR' ]-CurrencyShortName
           INTO TABLE @DATA(lt_results).
    " Display results
    IF lt_results IS NOT INITIAL.
      io_out->write( lt_results ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
