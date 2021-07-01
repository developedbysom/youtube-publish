"!@testing Z_I_OVERALL_PRICE
CLASS ltc_Z_I_OVERALL_PRICE
DEFINITION FINAL FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.
  PRIVATE SECTION.

    CLASS-DATA:
      environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      "! In CLASS_SETUP, corresponding doubles and clone(s) for the CDS view under test and its dependencies are created.
      class_setup RAISING cx_static_check,
      "! In CLASS_TEARDOWN, Generated database entities (doubles & clones) should be deleted at the end of test class execution.
      class_teardown.

    DATA:
      act_results            TYPE STANDARD TABLE OF z_i_overall_price WITH EMPTY KEY,
      lt_z_i_purchasedoc     TYPE STANDARD TABLE OF z_i_purchasedoc WITH EMPTY KEY,
      lt_z_i_purchasedocitem TYPE STANDARD TABLE OF z_i_purchasedocitem WITH EMPTY KEY.

    METHODS:
      "! SETUP method creates a common start state for each test method,
      "! clear_doubles clears the test data for all the doubles used in the test method before each test method execution.
      setup RAISING cx_static_check,
      prepare_testdata_set,
      "!  In this method test data is inserted into the generated double(s) and the test is executed and
      "!  the results should be asserted with the actuals.
      overall_price_cal FOR TESTING RAISING cx_static_check.

ENDCLASS.


CLASS ltc_Z_I_OVERALL_PRICE IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'Z_I_OVERALL_PRICE' ).
  ENDMETHOD.

  METHOD setup.
    environment->clear_doubles( ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD overall_price_cal.
    prepare_testdata_set( ).
    SELECT * FROM z_i_overall_price INTO TABLE @act_results.
*    cl_abap_unit_assert=>fail( msg = 'Place your assertions here' ).
    cl_abap_unit_assert=>assert_equals( exp = 700 act = act_results[ 1 ]-OverallPrice ).
  ENDMETHOD.

  METHOD prepare_testdata_set.

    "Prepare test data for 'z_i_purchasedoc'
    lt_z_i_purchasedoc = VALUE #(
      (
        purchasedocument = '100'
        description = 'Header'
        status = 'A'
        priority = 'A'
      ) ).
    environment->insert_test_data( i_data =  lt_z_i_purchasedoc ).

    "Prepare test data for 'z_i_purchasedocitem'
    lt_z_i_purchasedocitem = VALUE #(
      (
        purchasedocument = '100'
        purchasedocumentitem = '10'
        description = 'Item -1'
        price = '100'
        currency = 'USD'
        quantity = '2'
        OverallItemPrice = '200'
      )
         (
        purchasedocument = '100'
        purchasedocumentitem = '20'
        description = 'Item -2'
        price = '200'
        currency = 'USD'
        quantity = '3'
        OverallItemPrice = '600'
      )
      ).
    environment->insert_test_data( i_data =  lt_z_i_purchasedocitem ).

  ENDMETHOD.

ENDCLASS.
