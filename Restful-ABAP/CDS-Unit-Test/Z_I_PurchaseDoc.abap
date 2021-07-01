@AbapCatalog.sqlViewName: 'ZIPURCHDOC1'
@EndUserText.label: 'Purchase Document'
@AccessControl.authorizationCheck: #CHECK
@ObjectModel.representativeKey: 'PurchaseDocument'
@ObjectModel.semanticKey: ['PurchaseDocument']

define view Z_I_PurchaseDoc
  as select from zpurchdoc
  association [0..*] to Z_I_PurchaseDocItem          as _PurchaseDocumentItem on $projection.PurchaseDocument = _PurchaseDocumentItem.PurchaseDocument
  association [0..1] to Z_I_PurchaseDocumentPriority as _Priority             on $projection.Priority = _Priority.priority
  association [0..1] to Z_I_PurchaseDocumentStatus   as _Status               on $projection.Status = _Status.status


{

      @ObjectModel.text.element: ['Description']
  key purchasedocument         as PurchaseDocument,
      @Semantics.text: true
      description              as Description,
      @ObjectModel.foreignKey.association: '_Status'
      status                   as Status,
      @ObjectModel.foreignKey.association: '_Priority'
      priority                 as Priority,

      @Semantics.imageUrl: true
      purchasedocumentimageurl as PurchaseDocumentImageURL,
      crea_date_time,
      crea_uname,
      lchg_date_time,
      lchg_uname,
      // Associations
      _PurchaseDocumentItem,
      _Priority,
      _Status
}
