@AbapCatalog.sqlViewName: 'ZOVERALLPRICE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'PO Price'
define view z_i_overall_price as select from  Z_I_PurchaseDoc as header
inner join Z_I_PurchaseDocItem as _PurchaseDocumentItem

on header.PurchaseDocument = _PurchaseDocumentItem.PurchaseDocument


 {

    key header.PurchaseDocument,
    @Semantics.amount.currencyCode: 'Currency'
   // @DefaultAggregation: #NONE
    @ObjectModel.foreignKey.association: '_Currency'
     sum(_PurchaseDocumentItem.OverallItemPrice) as OverallPrice,     
     

    @Semantics.currencyCode: true
    _PurchaseDocumentItem.Currency,

    // Associations
    _PurchaseDocumentItem._Currency

}
group by
  header.PurchaseDocument,
 _PurchaseDocumentItem.Currency 
