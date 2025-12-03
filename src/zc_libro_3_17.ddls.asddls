@AbapCatalog.sqlViewName: 'ZC_LIBRO_317_CDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reporte Libro 3.17'
@Metadata.ignorePropagatedAnnotations: true
define view ZC_LIBRO_3_17 as select from I_GLAccountLineItem
{
      key GLAccount,
      key CompanyCode,
      key FiscalYear,
      key FiscalPeriod,
      //DebitAmountInCoCodeCrcy,
      //CreditAmountInCoCodeCrcy,
      //AmountInCompanyCodeCurrency,
      
      substring( GLAccount, 3, 1 ) as codInicio,
      
      cast( cast( GLAccount as abap.numc(10) ) as abap.char(10) ) as GLAccountClean,
      
      // Saldo inicial Debe
      sum( case when FiscalPeriod = '000' and AmountInCompanyCodeCurrency > 0 then AmountInCompanyCodeCurrency else 0 end ) as SaldoIniDebe,
    
      // Saldo inicial Haber
      sum( case 
        when FiscalPeriod = '000' and AmountInCompanyCodeCurrency < 0 
        then abs( AmountInCompanyCodeCurrency ) 
        else 0 
     end ) as SaldoIniHaber,
    
      // Movimiento Debe
      sum( case when FiscalPeriod <> '000' then DebitAmountInCoCodeCrcy else 0 end ) as MovDebe,
    
      // Movimiento Haber
      sum( case when FiscalPeriod <> '000' then CreditAmountInCoCodeCrcy else 0 end ) as MovHaber,
      
      
      sum( case when FiscalPeriod = '000' and AmountInCompanyCodeCurrency > 0 then AmountInCompanyCodeCurrency else 0 end ) 
      + sum( case when FiscalPeriod <> '000' then DebitAmountInCoCodeCrcy else 0 end ) as SumaMayorDebe,
      
      sum( case when FiscalPeriod = '000' and AmountInCompanyCodeCurrency < 0 then abs( AmountInCompanyCodeCurrency ) else 0 end ) 
      + sum( case when FiscalPeriod <> '000' then CreditAmountInCoCodeCrcy else 0 end ) as SumaMayorHaber
       
}
where Ledger = '0L'
group by GLAccount ,CompanyCode, FiscalYear,FiscalPeriod
