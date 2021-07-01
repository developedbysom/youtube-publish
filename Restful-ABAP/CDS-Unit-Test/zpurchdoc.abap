@EndUserText.label : 'Purchase Document'
@AbapCatalog.enhancement.category : #NOT_EXTENSIBLE
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zpurchdoc {
  key client               : abap.clnt not null;
  key purchasedocument     : zpurchasedocumentdtel not null;
  @EndUserText.label : 'Description'
  description              : abap.sstring(128);
  @EndUserText.label : 'Status'
  status                   : abap.char(1);
  @EndUserText.label : 'Priority'
  priority                 : abap.char(1);
  @EndUserText.label : 'Purchasing Organization'
  purchasingorganization   : abap.char(4);
  @EndUserText.label : 'Purchase Document Image URL'
  purchasedocumentimageurl : abap.sstring(255);
  crea_date_time           : timestampl;
  crea_uname               : syuname;
  lchg_date_time           : timestampl;
  lchg_uname               : syuname;

}
