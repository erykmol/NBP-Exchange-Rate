//
//  CurrencyMeanRateTable.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import Foundation

// MARK: - CurrencyMeanRateTable
struct CurrencyMeanRateTable: Codable {
    let table, currency, code: String
    let rates: [CurrencyRate]
}

// MARK: - CurrencyRate
struct CurrencyRate: Codable {
    let no, effectiveDate: String
    let bid, mid, ask: Double?
}
