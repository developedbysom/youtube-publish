@AbapCatalog.sqlViewName: 'ZIPURCHDOCITM'
@EndUserText.label: 'Purchase Document Item'
@AccessControl.authorizationCheck: #NOT_REQUIRED


@ObjectModel.representativeKey: 'PurchaseDocumentItem'
@ObjectModel.semanticKey: ['PurchaseDocumentItem','PurchaseDocument']
define view Z_I_PurchaseDocItem
  as select from zpurchdocitm
  association [1..1] to Z_I_PurchaseDocItem as _PurchaseDocument      on $projection.PurchaseDocument = _PurchaseDocument.PurchaseDocument
  association [0..1] to I_UnitOfMeasure     as _QuantityUnitOfMeasure on $projection.QuantityUnit = _QuantityUnitOfMeasure.UnitOfMeasure
  association [0..1] to I_Currency          as _Currency              on $projection.Currency = _Currency.Currency
{
      @ObjectModel.foreignKey.association: '_PurchaseDocument'
  key purchasedocument             as PurchaseDocument,
      @ObjectModel.text.element: ['Description']
  key purchasedocumentitem         as PurchaseDocumentItem,

      @Semantics.text: true
      description                  as Description,
      vendor                       as Vendor,
      vendortype                   as VendorType,
      @Semantics.amount.currencyCode: 'Currency'

      price                        as Price,
      @Semantics.currencyCode: true
      @ObjectModel.foreignKey.association: '_Currency'
      currency                     as Currency,
      @Semantics.quantity.unitOfMeasure: 'QuantityUnit'

      quantity                     as Quantity,
      @Semantics.unitOfMeasure: true
      @ObjectModel.foreignKey.association: '_QuantityUnitOfMeasure'
      quantityunit                 as QuantityUnit,
      @Semantics.amount.currencyCode: 'Currency'
      quantity * price             as OverallItemPrice,

      @Semantics.imageUrl: true
      purchasedocumentitemimageurl as PurchaseDocumentItemImageURL,
      crea_date_time,
      crea_uname,
      lchg_date_time,
      lchg_uname,
      // Associations
      _PurchaseDocument,
      _QuantityUnitOfMeasure,
      _Currency
}
