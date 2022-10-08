@EndUserText.label: 'RAP demo Booking CDS projection'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@Metadata.allowExtensions: true
define view entity ZC_RAP_BOOKING_0362 as projection on ZI_RAP_BOOKING_0362 as Booking 

{
    key BookingUuid,
    TravelUuid,
    @Search.defaultSearchElement: true
    BookingId,
    BookingDate,
    @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Customer', element: 'CustomerID'} }]
    @ObjectModel.text.element: ['CustomerName']
    @Search.defaultSearchElement: true
    CustomerId,
    _Customer.LastName as CustomerName,
    @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Carrier', element: 'AirlineID'} }]
    @ObjectModel.text.element: ['CarrierName']
    CarrierId,
    _Carrier.Name as CarrierName,
     @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Flight', element: 'ConnectionID'},
      additionalBinding: [{ localElement: 'CarrierID', element: 'AirlineID' },
                          { localElement: 'FlightDate', element: 'FlightDate', usage: #RESULT },
                          { localElement: 'FlightPrice', element: 'FlightPrice', usage: #RESULT  },
                          { localElement: 'CurrencyCode', element: 'CurrencyCode', usage: #RESULT  }]
      }]
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    @Consumption.valueHelpDefinition: [{ entity: {name: 'I_Currency', element: 'Currency'}}]
    CurrencyCode,
    CreatedBy,
    LastChangedBy,
    LocalLastChangedAt,
    /* Associations */
    _Travel : redirected to parent ZC_RAP_TRAVEL_0362,
    _Customer,
    _Carrier,
    _Connection,
    _Flight
    
}
