//
//  ViewModel.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    let activityIndicator = ActivityIndicator()
    let decoder = JSONDecoder()
    let tableNameList = ["A", "B", "C"]
    let columnNameList = ["Data", "Kupno", "Średni kurs", "Sprzedaż"]
    var currentCurrenciesTable: CurrenciesTable!
    var currencyRatesTable: CurrencyMeanRateTable!
    var currentCurrenciesTableRates: [Rate] = []
    var currencyRates: [CurrencyRate] = []
    
    var isLoading: Driver<Bool> {
        return activityIndicator.asDriver()
    }
}

extension ViewModel {
    func getTableData(query: String, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<Any> {
        
        guard let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/\(query)/?format=json") else {
            return Observable.just([])
        }
        
        return Observable.create { observer in
            let task = dataTask(url) { (data, response, error) in

                guard let data = data else {
                    return
                }
                
                do {
                    self.currentCurrenciesTable = try self.decoder.decode([CurrenciesTable].self, from: data)[0]
                    self.currentCurrenciesTableRates = self.currentCurrenciesTable.rates
                    observer.onCompleted()
                } catch let error {
                    observer.onError(error)
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
        .trackActivity(activityIndicator)
    }
    
    func getCurrencyRatesData(query: String, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<Any> {
        
        guard let url = URL(string: "https://api.nbp.pl/api/exchangerates/rates/\(query)/?format=json") else {
            return Observable.just([])
        }
        
        return Observable.create { observer in
            let task = dataTask(url) { (data, response, error) in

                guard let data = data else {
                    return
                }
                
                do {
                    self.currencyRatesTable = try self.decoder.decode(CurrencyMeanRateTable.self, from: data)
                    self.currencyRates = self.currencyRatesTable.rates
                    observer.onCompleted()
                } catch let error {
                    self.currencyRates = [CurrencyRate(no: "", effectiveDate: "Brak danych", bid: nil, mid: nil, ask: nil)]
                    observer.onError(error)
                }
            }
            task.resume()

            return Disposables.create {
                task.cancel()
            }
        }
        .trackActivity(activityIndicator)
    }
}
