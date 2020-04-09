//
//  CurrenciesTable.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import Foundation

// MARK: - CurrenciesTable
struct CurrenciesTable: Codable {
    let table, no, effectiveDate: String
    let rates: [Rate]
}

// MARK: - Rate
struct Rate: Codable {
    let currency, code: String
    let bid, ask: Double
}
