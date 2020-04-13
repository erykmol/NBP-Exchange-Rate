//
//  ViewModelTests.swift
//  ViewModelTests
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import XCTest
import RxCocoa
import RxSwift

@testable import NBP_Exchange_Rate

class ViewModelTests: XCTestCase {
    
    var viewModel: ViewModel!
    
    override func setUpWithError() throws {
        viewModel = ViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testGetTableDataFromTableA() throws {
        let disposeBag = DisposeBag()
        
        viewModel.getTableData(query: "A", dataTask: fakeTableADataTask(_:_:))
            .asDriver(onErrorJustReturn: [])
            .drive(
                onCompleted: { [weak self] in
                    if let viewModel = self?.viewModel {
                        let currentCurrenciesTable = viewModel.currentCurrenciesTable
                        let rate = viewModel.currentCurrenciesTableRates[0]
                        
                        XCTAssertEqual(currentCurrenciesTable?.table, "A")
                        XCTAssertEqual(currentCurrenciesTable?.no, "001/A/NBP/1000")
                        XCTAssertEqual(currentCurrenciesTable?.effectiveDate, "1000-10-10")
                        XCTAssertEqual(currentCurrenciesTable?.rates.count, 1)
                        XCTAssertEqual(rate.currency, "dolar kanadyjski")
                        XCTAssertEqual(rate.code, "CAD")
                        XCTAssertNil(rate.bid)
                        XCTAssertEqual(rate.mid, 0.0)
                        XCTAssertNil(rate.ask)
                    }
            })
            .disposed(by: disposeBag)
    }
    
    func testGetTableDataFromTableB() throws {
        let disposeBag = DisposeBag()
        
        viewModel.getTableData(query: "B", dataTask: fakeTableBDataTask(_:_:))
            .asDriver(onErrorJustReturn: [])
            .drive(
                onCompleted: { [weak self] in
                    if let viewModel = self?.viewModel {
                        let currentCurrenciesTable = viewModel.currentCurrenciesTable
                        let rate = viewModel.currentCurrenciesTableRates[0]
                        
                        XCTAssertEqual(currentCurrenciesTable?.table, "B")
                        XCTAssertEqual(currentCurrenciesTable?.no, "001/B/NBP/1000")
                        XCTAssertEqual(currentCurrenciesTable?.effectiveDate, "1000-10-10")
                        XCTAssertEqual(currentCurrenciesTable?.rates.count, 1)
                        XCTAssertEqual(rate.currency, "manat azerbejdżański")
                        XCTAssertEqual(rate.code, "AZN")
                        XCTAssertNil(rate.bid)
                        XCTAssertEqual(rate.mid, 0.0)
                        XCTAssertNil(rate.ask)
                    }
            })
            .disposed(by: disposeBag)
    }
    
    func testGetTableDataFromTableC() throws {
        let disposeBag = DisposeBag()
        
        viewModel.getTableData(query: "C", dataTask: fakeTableCDataTask(_:_:))
            .asDriver(onErrorJustReturn: [])
            .drive(
                onCompleted: { [weak self] in
                    if let viewModel = self?.viewModel {
                        let currentCurrenciesTable = viewModel.currentCurrenciesTable
                        let rate = viewModel.currentCurrenciesTableRates[0]
                        
                        XCTAssertEqual(currentCurrenciesTable?.table, "C")
                        XCTAssertEqual(currentCurrenciesTable?.no, "001/C/NBP/1000")
                        XCTAssertEqual(currentCurrenciesTable?.effectiveDate, "1000-10-10")
                        XCTAssertEqual(currentCurrenciesTable?.rates.count, 1)
                        XCTAssertEqual(rate.currency, "dolar amerykański")
                        XCTAssertEqual(rate.code, "USD")
                        XCTAssertEqual(rate.bid, 0.0)
                        XCTAssertNil(rate.mid)
                        XCTAssertEqual(rate.ask, 0.0)
                    }
            })
            .disposed(by: disposeBag)
    }
    
    func testGetCurrencyRatesDataFromTableA() {
        let disposeBag = DisposeBag()
        let query = "A/CAD/2020-01-10/2020-01-10"
        
        viewModel.getCurrencyRatesData(query: query, dataTask: fakeTableACurrencyDataTask(_:_:))
            .asDriver(onErrorJustReturn: [])
            .drive(
                onCompleted: { [weak self] in
                    if let viewModel = self?.viewModel {
                        let currencyRatesTable = viewModel.currencyRatesTable
                        let currencyRate = viewModel.currencyRates[0]
                        
                        XCTAssertEqual(currencyRatesTable?.table, "A")
                        XCTAssertEqual(currencyRatesTable?.currency, "dolar kanadyjski")
                        XCTAssertEqual(currencyRatesTable?.code, "CAD")
                        XCTAssertEqual(currencyRatesTable?.rates.count, 1)
                        XCTAssertEqual(currencyRate.no, "001/A/NBP/1000")
                        XCTAssertEqual(currencyRate.effectiveDate, "1000-10-10")
                        XCTAssertNil(currencyRate.bid)
                        XCTAssertEqual(currencyRate.mid, 0.0)
                        XCTAssertNil(currencyRate.ask)
                    }
            })
            .disposed(by: disposeBag)
    }
    
    func testGetCurrencyRatesDataFromTableB() {
        let disposeBag = DisposeBag()
        let query = "B/AZN/2020-01-10/2020-01-10"
        
        viewModel.getCurrencyRatesData(query: query, dataTask: fakeTableBCurrencyDataTask(_:_:))
            .asDriver(onErrorJustReturn: [])
            .drive(
                onCompleted: { [weak self] in
                    if let viewModel = self?.viewModel {
                        let currencyRatesTable = viewModel.currencyRatesTable
                        let currencyRate = viewModel.currencyRates[0]
                        
                        XCTAssertEqual(currencyRatesTable?.table, "B")
                        XCTAssertEqual(currencyRatesTable?.currency, "manat azerbejdżański")
                        XCTAssertEqual(currencyRatesTable?.code, "AZN")
                        XCTAssertEqual(currencyRatesTable?.rates.count, 1)
                        XCTAssertEqual(currencyRate.no, "001/B/NBP/1000")
                        XCTAssertEqual(currencyRate.effectiveDate, "1000-10-10")
                        XCTAssertNil(currencyRate.bid)
                        XCTAssertEqual(currencyRate.mid, 0.0)
                        XCTAssertNil(currencyRate.ask)
                    }
            })
            .disposed(by: disposeBag)
    }
    
    func testGetCurrencyRatesDataFromTableC() {
        let disposeBag = DisposeBag()
        let query = "C/USD/2020-01-10/2020-01-10"
        
        viewModel.getCurrencyRatesData(query: query, dataTask: fakeTableCCurrencyDataTask(_:_:))
            .asDriver(onErrorJustReturn: [])
            .drive(
                onCompleted: { [weak self] in
                    if let viewModel = self?.viewModel {
                        let currencyRatesTable = viewModel.currencyRatesTable
                        let currencyRate = viewModel.currencyRates[0]
                        
                        XCTAssertEqual(currencyRatesTable?.table, "C")
                        XCTAssertEqual(currencyRatesTable?.currency, "dolar amerykański")
                        XCTAssertEqual(currencyRatesTable?.code, "USD")
                        XCTAssertEqual(currencyRatesTable?.rates.count, 1)
                        XCTAssertEqual(currencyRate.no, "001/C/NBP/1000")
                        XCTAssertEqual(currencyRate.effectiveDate, "1000-10-10")
                        XCTAssertEqual(currencyRate.bid, 0.0)
                        XCTAssertNil(currencyRate.mid)
                        XCTAssertEqual(currencyRate.ask, 0.0)
                    }
            })
            .disposed(by: disposeBag)
    }
    
    func testGetCurrencyRatesDataOnInvalidDay() {
        let disposeBag = DisposeBag()
        let query = "C/USD/2020-04-12/2020-04-12"
        
        viewModel.getCurrencyRatesData(query: query, dataTask: fakeInvalidCurrencyDataTask(_:_:))
            .asDriver(onErrorJustReturn: [])
            .drive(
                onCompleted: { [weak self] in
                    if let viewModel = self?.viewModel {
                        let currencyRatesTable = viewModel.currencyRatesTable
                        let currencyRate = viewModel.currencyRates[0]
                        
                        XCTAssertNil(currencyRatesTable)
                        XCTAssertEqual(currencyRate.no, "")
                        XCTAssertEqual(currencyRate.effectiveDate, "Brak danych")
                        XCTAssertNil(currencyRate.bid)
                        XCTAssertNil(currencyRate.mid)
                        XCTAssertNil(currencyRate.ask)
                    }
            })
            .disposed(by: disposeBag)
    }
}

extension ViewModelTests {
    func fakeTableADataTask(_ url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        XCTAssertEqual(url, URL(string: "https://api.nbp.pl/api/exchangerates/tables/A/?format=json")!)
        let mockData = [CurrenciesTable(table: "A", no: "001/A/NBP/1000", effectiveDate: "1000-10-10", rates: [Rate(currency: "dolar kanadyjski", code: "CAD", bid: nil, mid: 0.0, ask: nil)])]
        completionHandler(try! JSONEncoder().encode(mockData), nil, nil)
        
        return URLSession.shared.dataTask(with: url)
    }
    
    func fakeTableBDataTask(_ url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        XCTAssertEqual(url, URL(string: "https://api.nbp.pl/api/exchangerates/tables/B/?format=json")!)
        let mockData = [CurrenciesTable(table: "B", no: "001/B/NBP/1000", effectiveDate: "1000-10-10", rates: [Rate(currency: "manat azerbejdżański", code: "AZN", bid: nil, mid: 0.0, ask: nil)])]
        completionHandler(try! JSONEncoder().encode(mockData), nil, nil)
        
        return URLSession.shared.dataTask(with: url)
    }
    
    func fakeTableCDataTask(_ url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        XCTAssertEqual(url, URL(string: "https://api.nbp.pl/api/exchangerates/tables/C/?format=json")!)
        let mockData = [CurrenciesTable(table: "C", no: "001/C/NBP/1000", effectiveDate: "1000-10-10", rates: [Rate(currency: "dolar amerykański", code: "USD", bid: 0.0, mid: nil, ask: 0.0)])]
        completionHandler(try! JSONEncoder().encode(mockData), nil, nil)
        
        return URLSession.shared.dataTask(with: url)
    }
}

extension ViewModelTests {
    func fakeTableACurrencyDataTask(_ url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        XCTAssertEqual(url, URL(string: "https://api.nbp.pl/api/exchangerates/rates/A/CAD/2020-01-10/2020-01-10/?format=json")!)
        let mockData = CurrencyMeanRateTable(table: "A", currency: "dolar kanadyjski", code: "CAD", rates: [CurrencyRate(no: "001/A/NBP/1000", effectiveDate: "1000-10-10", bid: nil, mid: 0.0, ask: nil)])
        completionHandler(try! JSONEncoder().encode(mockData), nil, nil)
        
        return URLSession.shared.dataTask(with: url)
    }
    
    func fakeTableBCurrencyDataTask(_ url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        XCTAssertEqual(url, URL(string: "https://api.nbp.pl/api/exchangerates/rates/B/AZN/2020-01-10/2020-01-10/?format=json")!)
        let mockData = CurrencyMeanRateTable(table: "B", currency: "manat azerbejdżański", code: "AZN", rates: [CurrencyRate(no: "001/B/NBP/1000", effectiveDate: "1000-10-10", bid: nil, mid: 0.0, ask: nil)])
        completionHandler(try! JSONEncoder().encode(mockData), nil, nil)
        
        return URLSession.shared.dataTask(with: url)
    }
    
    func fakeTableCCurrencyDataTask(_ url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        XCTAssertEqual(url, URL(string: "https://api.nbp.pl/api/exchangerates/rates/C/USD/2020-01-10/2020-01-10/?format=json")!)
        let mockData = CurrencyMeanRateTable(table: "C", currency: "dolar amerykański", code: "USD", rates: [CurrencyRate(no: "001/C/NBP/1000", effectiveDate: "1000-10-10", bid: 0.0, mid: nil, ask: 0.0)])
        completionHandler(try! JSONEncoder().encode(mockData), nil, nil)
        
        return URLSession.shared.dataTask(with: url)
    }
    
    func fakeInvalidCurrencyDataTask(_ url: URL, _ completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        XCTAssertEqual(url, URL(string: "https://api.nbp.pl/api/exchangerates/rates/C/USD/2020-04-12/2020-04-12/?format=json")!)
        let mockData = ["No data from this day"]
        completionHandler(try! JSONEncoder().encode(mockData), nil, nil)
        
        return URLSession.shared.dataTask(with: url)
    }
}
