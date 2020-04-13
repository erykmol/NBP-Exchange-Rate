//
//  CurrencyExchangeCollectionViewCell.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

class CurrencyExchangeCollectionViewCell: UICollectionViewCell {
    
    var publicationDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        
        return label
    }()
    
    var currencyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        
        return label
    }()
    
    var currencyCodeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        
        return label
    }()
    
    var averageExchangeRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .left
        label.sizeToFit()
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(currencyNameLabel)
        addSubview(publicationDateLabel)
        addSubview(currencyCodeLabel)
        addSubview(averageExchangeRateLabel)
        
        NSLayoutConstraint.activate([
            currencyNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            currencyNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            currencyNameLabel.heightAnchor.constraint(equalToConstant: 24),
            currencyNameLabel.widthAnchor.constraint(equalToConstant: frame.width / 2 - 32)
        ])
        
        NSLayoutConstraint.activate([
            publicationDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            publicationDateLabel.topAnchor.constraint(equalTo: currencyNameLabel.bottomAnchor, constant: 16),
            publicationDateLabel.heightAnchor.constraint(equalToConstant: 24),
            publicationDateLabel.widthAnchor.constraint(equalToConstant: frame.width / 2 - 32)
        ])
        
        NSLayoutConstraint.activate([
            currencyCodeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            currencyCodeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            currencyCodeLabel.heightAnchor.constraint(equalToConstant: 24),
            currencyCodeLabel.widthAnchor.constraint(equalToConstant: frame.width / 2 - 32)
        ])
        
        NSLayoutConstraint.activate([
            averageExchangeRateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            averageExchangeRateLabel.topAnchor.constraint(equalTo: currencyCodeLabel.bottomAnchor, constant: 16),
            averageExchangeRateLabel.heightAnchor.constraint(equalToConstant: 24),
            averageExchangeRateLabel.widthAnchor.constraint(equalToConstant: frame.width / 2 - 32)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
