//
//  UICollectionView+setup.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

extension UICollectionView {
    func setup(viewController: UIViewController) {
        self.delegate = viewController as? UICollectionViewDelegate
        self.dataSource = viewController as? UICollectionViewDataSource
        if viewController.isKind(of: ExchangeRateViewController.self) {
            self.register(CurrencyExchangeCollectionViewCell.self, forCellWithReuseIdentifier: "CurrencyExchangeCell")
        } else {
            self.register(CurrencyCollectionViewCell.self, forCellWithReuseIdentifier: "CurrencyDateCell")
        }
        
    }
}
