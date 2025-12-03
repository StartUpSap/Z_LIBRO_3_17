@AbapCatalog.sqlViewName: 'Z_LIBRO_3_17_V2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reporte Libro 3.17 Final'
@Metadata.ignorePropagatedAnnotations: true
define view ZC_LIBRO_3_17_V2 as select from I_GLAccountLineItem
{
    key GLAccount,
      key CompanyCode,
      key FiscalYear,
      key FiscalPeriod,
      DebitAmountInCoCodeCrcy,
      CreditAmountInCoCodeCrcy,
      AmountInCompanyCodeCurrency
}
