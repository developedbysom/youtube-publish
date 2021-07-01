@AbapCatalog.sqlViewName: 'ZTFLVLUP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'amdp upper level'
define view ztf_amdp_lvl1
  as select from z_tf_overall_price
{
  
  PurchaseDocument,
  @Semantics.amount.currencyCode: 'currency'
  OverallPrice,
  @Semantics.currencyCode: true
  currency,
  approval_status
}
