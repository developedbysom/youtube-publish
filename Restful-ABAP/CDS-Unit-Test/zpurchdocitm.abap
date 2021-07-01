@EndUserText.label : 'Purchase Document Item'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zpurchdocitm {
  key client                   : abap.clnt not null;
  @AbapCatalog.foreignKey.keyType : #KEY
  @AbapCatalog.foreignKey.screenCheck : true
  key purchasedocument         : zpurchasedocumentdtel not null
    with foreign key [1..*,1] zpurchdoc
      where client = zpurchdocitem.client
        and purchasedocument = zpurchdocitm.purchasedocument;
  @EndUserText.label : 'Purchase Document Item'
  key purchasedocumentitem     : abap.char(2) not null;
  @EndUserText.label : 'Description'
  description                  : abap.sstring(128);
  @EndUserText.label : 'Price'
  @Semantics.amount.currencyCode : 'zpurchdocitem.currency'
  price                        : abap.curr(13,2);
  @EndUserText.label : 'Currency'
  currency                     : abap.cuky;
  @EndUserText.label : 'Quantity'
  @Semantics.quantity.unitOfMeasure : 'zpurchdocitem.quantityunit'
  quantity                     : abap.quan(13,2);
  @EndUserText.label : 'Unit'
  quantityunit                 : abap.unit(3);
  @EndUserText.label : 'Vendor'
  vendor                       : abap.sstring(32);
  @EndUserText.label : 'Vendor Type'
  vendortype                   : abap.sstring(32);
  @EndUserText.label : 'Purchase Document Item Image URL'
  purchasedocumentitemimageurl : abap.sstring(255);
  crea_date_time               : timestampl;
  crea_uname                   : uname;
  lchg_date_time               : timestampl;
  lchg_uname                   : uname;

}
