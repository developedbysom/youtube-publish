@EndUserText.label: 'TF-Overall Price'
define table function z_tf_overall_price

returns {
    client:abap.clnt;
    PurchaseDocument:zpurchasedocumentdtel;
    OverallPrice:abap.curr( 28, 4 );
    currency: waers_curc ;
    approval_status:abap.char( 8 );
  
}
implemented by method ZCL_AMDP_PURCHOVERALLPRICE=>CAL_PRICE_UPD_STATUS;
