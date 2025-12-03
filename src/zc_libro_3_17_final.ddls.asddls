@AbapCatalog.sqlViewName: 'ZC_LIB317_FINAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Reporte Libro 3.17 Final'
@Metadata.ignorePropagatedAnnotations: true

define view ZC_LIBRO_3_17_FINAL as select from ZC_LIBRO_3_17
{
  key CompanyCode,
  key FiscalYear,
  @UI.lineItem: [{ position: 10 }]
  cast( concat( FiscalYear, '1231' ) as abap.char(8) ) as Periodo,              // 1

  @UI.lineItem: [{ position: 20 }]
  @EndUserText.label: 'Cuenta'
  cast( cast( GLAccount as abap.numc(10) ) as abap.char(10) ) as GLAccountClean,  // 2

  @UI.lineItem: [{ position: 30 }]
  @EndUserText.label: 'Saldo Inicial Debe'
  case when SaldoIniDebe > 0 then SaldoIniDebe else 0 end as SaldoIniDebe,     // 3

  @UI.lineItem: [{ position: 40 }]
  @EndUserText.label: 'Saldo Inicial Haber'
  case when SaldoIniHaber > 0 then SaldoIniHaber else 0 end as SaldoIniHaber,  // 4

  @UI.lineItem: [{ position: 50 }]
  @EndUserText.label: 'Movimiento Debe'
  case when MovDebe > 0 then MovDebe else 0 end as MovDebe,                    // 5

  @UI.lineItem: [{ position: 60 }]
  @EndUserText.label: 'Movimiento Haber'
  case when MovHaber > 0 then MovHaber else 0 end as MovHaber,                 // 6

  @UI.lineItem: [{ position: 70 }]
  @EndUserText.label: 'Suma Mayor Debe'
  case when SumaMayorDebe > 0 then SumaMayorDebe else 0 end as SumaMayorDebe,  // 7

  @UI.lineItem: [{ position: 80 }]
  @EndUserText.label: 'Suma Mayor Haber'
  case when SumaMayorHaber > 0 then SumaMayorHaber else 0 end as SumaMayorHaber, // 8

  @UI.lineItem: [{ position: 90 }]
  @EndUserText.label: 'Saldo Final Deudor'
  case when SumaMayorDebe > SumaMayorHaber 
       then SumaMayorDebe - SumaMayorHaber else 0 end as SaldoFinalDeudor,     // 9

  @UI.lineItem: [{ position: 100 }]
  @EndUserText.label: 'Saldo Final Acreedor'
  case when SumaMayorHaber > SumaMayorDebe 
       then SumaMayorHaber - SumaMayorDebe else 0 end as SaldoFinalAcreedor,   // 10

  @UI.lineItem: [{ position: 110 }]
  cast( '0.00' as abap.char(4) ) as TransferDebe,                               // 11

  @UI.lineItem: [{ position: 120 }]
  cast( '0.00' as abap.char(4) ) as TransferHaber,                              // 12

  @UI.lineItem: [{ position: 130 }]
  @EndUserText.label: 'Cta Balance Activo'
  case when ( codInicio = '1' or codInicio = '2' or codInicio = '3' 
             or codInicio = '4' or codInicio = '5' )
          and SumaMayorDebe > SumaMayorHaber
     then SumaMayorDebe - SumaMayorHaber
     else 0 end as CtaBalanceActivo,     // 13

  @UI.lineItem: [{ position: 140 }]
  @EndUserText.label: 'Cta Balance Pasivo'
  case when ( codInicio = '1' or codInicio = '2' or codInicio = '3' 
             or codInicio = '4' or codInicio = '5' )
          and SumaMayorHaber > SumaMayorDebe
     then SumaMayorHaber - SumaMayorDebe
     else 0 end as CtaBalancePasivo
,     // 14

  @UI.lineItem: [{ position: 150 }]
  @EndUserText.label: 'Pérdida'
  case when ( codInicio = '6' or codInicio = '8' or codInicio = '9' )
          and SumaMayorDebe > SumaMayorHaber
     then SumaMayorDebe - SumaMayorHaber
     else 0 end as Perdida,              // 15

  @UI.lineItem: [{ position: 160 }]
  @EndUserText.label: 'Ganancia'
  case when ( codInicio = '6' or codInicio = '7' or codInicio = '8' or codInicio = '9' )
          and SumaMayorHaber > SumaMayorDebe
     then SumaMayorHaber - SumaMayorDebe
     else 0 end as Ganancia,             // 16

  @UI.lineItem: [{ position: 170 }]
  cast( '0.00' as abap.char(4) ) as Adiciones,                                  // 17

  @UI.lineItem: [{ position: 180 }]
  cast( '0.00' as abap.char(4) ) as Deducciones,                                // 18

  @UI.lineItem: [{ position: 190 }]
  cast( '1' as abap.char(1) ) as EstadoOperacion,                               // 19

  @UI.lineItem: [{ position: 200 }]
  cast( '' as abap.char(1) ) as LibreUso                                        // 20
}
