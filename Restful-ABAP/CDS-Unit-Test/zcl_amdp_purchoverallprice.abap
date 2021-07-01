CLASS zcl_amdp_purchoverallprice DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_amdp_marker_hdb.
    CLASS-METHODS: cal_price_upd_status FOR TABLE FUNCTION z_tf_overall_price.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_amdp_purchoverallprice IMPLEMENTATION.

  METHOD cal_price_upd_status BY DATABASE FUNCTION FOR HDB
      LANGUAGE SQLSCRIPT OPTIONS READ-ONLY
      USING z_i_purchasedoc z_i_purchasedocitem.

    lt_overall_price =
             select 100 as client,
                       header.purchasedocument ,
                       sum(item.OverallItemPrice) as OverallPrice,
                       item.Currency as currency,
                       'Approved' as approval_status
                       from z_i_purchasedoc as header
                       inner join z_i_purchasedocitem as item
                       on header.purchasedocument = item.purchasedocument
                       group by header.PurchaseDocument,
                                    item.currency;
      return
            select 100  as client,
                       purchasedocument ,
                       OverallPrice,
                       currency,
                       case
                         when OverallPrice > 300 then 'Pending' else 'Approved'
                       end as approval_status

                       from :lt_overall_price ;
  endmethod.
ENDCLASS.
