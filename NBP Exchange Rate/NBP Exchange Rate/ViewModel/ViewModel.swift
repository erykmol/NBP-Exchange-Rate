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
    var currentTable: CurrenciesTable!
    var currentTableRates: [Rate] = []
    
    var isLoading: Driver<Bool> {
        return activityIndicator.asDriver()
    }
}

extension ViewModel {
    func getTableData(query: String, dataTask: @escaping (URL, @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask) -> Observable<[Rate]> {
        
        guard let url = URL(string: "https://api.nbp.pl/api/exchangerates/tables/\(query)/") else {
            return Observable.just([])
        }
        
        return Observable.create { observer in
            let task = dataTask(url) { (data, response, error) in

                guard let data = data else {
                    return
                }
                
                do {
                    self.currentTable = try self.decoder.decode([CurrenciesTable].self, from: data)[0]
                    self.currentTableRates = self.currentTable.rates
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
}
