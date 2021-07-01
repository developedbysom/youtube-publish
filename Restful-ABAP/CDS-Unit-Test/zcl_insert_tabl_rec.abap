CLASS zcl_insert_tabl_rec DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    METHODS insert_header_item.
    DATA:
      act_results                 TYPE STANDARD TABLE OF z_i_purchdocovrallprice WITH EMPTY KEY,
      lt_z_i_purchasedoc          TYPE STANDARD TABLE OF z_i_purchasedoc WITH EMPTY KEY,
      lt_z_i_purchasedocumentitem TYPE STANDARD TABLE OF Z_I_PurchaseDocumentItem WITH EMPTY KEY.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_insert_tabl_rec IMPLEMENTATION.
  METHOD insert_header_item.

    INSERT zpurchdoc FROM TABLE @( VALUE #(
            (
            purchasedocument = '1000000000'
            description = 'Test description'
            status ='N'
            priority = 'H'

            ) )
          ).
*INSERT zpurchdoc FROM TABLE @lt_z_i_purchasedoc.

    INSERT zpurchdocitm FROM TABLE @( VALUE #(
             (
             purchasedocument = '1000000000'
             purchasedocumentitem = '10'
             description = 'Item 1'
             quantity = 1
             price = 100
             currency = 'USD'

            )
            (
             purchasedocument = '1000000000'
             purchasedocumentitem = '20'
             description = 'Item 2'
             quantity = 1
             price = 200
             currency = 'USD'


            )
            )

         ).



  ENDMETHOD.

  METHOD if_oo_adt_classrun~main.
    me->insert_header_item(  ).
  ENDMETHOD.

ENDCLASS.
