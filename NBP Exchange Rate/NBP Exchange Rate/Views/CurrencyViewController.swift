//
//  CurrencyViewController.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 10/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {

    @IBOutlet weak var fromDateTextField: DatePickerTextField!
    @IBOutlet weak var toDateTextField: DatePickerTextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var textFieldList: [UITextField] = []
    var tableName: String!
    var courrencyCode: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldList = [fromDateTextField, toDateTextField]
        
        searchButton.tintColor = .white
        searchButton.backgroundColor = .systemGreen
        searchButton.layer.cornerRadius = 10
        
        let dismissTapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapDismiss))
        view.addGestureRecognizer(dismissTapGesture)
    }
    
    @objc func onTapDismiss() {
        view.endEditing(true)
    }
}
