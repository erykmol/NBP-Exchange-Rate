//
//  CurrencyCollectionViewCell.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 11/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

class CurrencyCollectionViewCell: UICollectionViewCell {
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        label.textAlignment = .center
        
        return label
    }()
    
    var bidLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        label.textAlignment = .center
        
        return label
    }()
    
    var midLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        label.textAlignment = .center
        
        return label
    }()
    
    var askLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(dateLabel)
        addSubview(bidLabel)
        addSubview(midLabel)
        addSubview(askLabel)
        
        let labelWidth = frame.width / 4
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            dateLabel.heightAnchor.constraint(equalToConstant: frame.height)
        ])
        
        NSLayoutConstraint.activate([
            bidLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            bidLabel.topAnchor.constraint(equalTo: topAnchor),
            bidLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            bidLabel.heightAnchor.constraint(equalToConstant: frame.height)
        ])
        
        NSLayoutConstraint.activate([
            midLabel.leadingAnchor.constraint(equalTo: bidLabel.trailingAnchor),
            midLabel.topAnchor.constraint(equalTo: topAnchor),
            midLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            midLabel.heightAnchor.constraint(equalToConstant: frame.height)
        ])
        
        NSLayoutConstraint.activate([
            askLabel.leadingAnchor.constraint(equalTo: midLabel.trailingAnchor),
            askLabel.topAnchor.constraint(equalTo: topAnchor),
            askLabel.widthAnchor.constraint(equalToConstant: labelWidth),
            askLabel.heightAnchor.constraint(equalToConstant: frame.height)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
