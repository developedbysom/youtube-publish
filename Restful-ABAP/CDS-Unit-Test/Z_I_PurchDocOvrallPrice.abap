@AbapCatalog.sqlViewName: 'ZPUROVRPRICE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'PO Price'
define view Z_I_PurchDocOvrallPrice as select from  Z_I_PurchaseDoc {

    key PurchaseDocument,
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
 PurchaseDocument,
 _PurchaseDocumentItem.Currency   
