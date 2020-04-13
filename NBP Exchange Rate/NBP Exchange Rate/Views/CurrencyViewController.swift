//
//  CurrencyViewController.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 10/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CurrencyViewController: UIViewController {

    @IBOutlet weak var fromDateTextField: DatePickerTextField!
    @IBOutlet weak var toDateTextField: DatePickerTextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var loadingIndicator: UIActivityIndicatorView!
    var viewModel: ViewModel!
    var textFieldList: [UITextField] = []
    var tableName: String!
    var currencyCode: String!
    var query: String!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.setup(viewController: self)
        textFieldList = [fromDateTextField, toDateTextField]
        
        loadingIndicator = createLoadingIndicator()
        loadingIndicator.setup(view: collectionView)
        setupRefreshButton()
        setupSearchButton()
        setupDismissTapGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        query = tableName + "/" + currencyCode + "/" + fromDateTextField.unwrappedText + "/" + toDateTextField.unwrappedText
        bindActivityIndicator()
        bindGetCurrencyRatesData(query: query)
    }
}

extension CurrencyViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currencyRates.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyDateCell", for: indexPath) as! CurrencyCollectionViewCell
        
        if indexPath.row == 0 {
            let columnNameList = viewModel.columnNameList
            cell.dateLabel.text = columnNameList[0]
            cell.bidLabel.text = columnNameList[1]
            cell.midLabel.text = columnNameList[2]
            cell.askLabel.text = columnNameList[3]
        } else {
            let currentRate = viewModel.currencyRates[indexPath.row - 1]
            cell.dateLabel.text = currentRate.effectiveDate
            cell.bidLabel.text = currentRate.bid?.description ?? "Brak danych"
            cell.midLabel.text = currentRate.mid?.description ?? "Brak danych"
            cell.askLabel.text = currentRate.ask?.description ?? "Brak danych"
        }
        
        return cell
    }
}

extension CurrencyViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width,
                      height: 50.0)
    }
}

extension CurrencyViewController {
    func bindActivityIndicator() {
        viewModel
            .isLoading
            .drive(
                onNext: { [weak self] isLoading in
                    if isLoading {
                        self?.loadingIndicator.startAnimating()
                    } else {
                        self?.loadingIndicator.stopAnimating()
                    }
            })
            .disposed(by: disposeBag)
    }
    
    func bindGetCurrencyRatesData(query: String) {
        viewModel.getCurrencyRatesData(query: query, dataTask: URLSession.shared.dataTask(with:completionHandler:))
            .asDriver(onErrorJustReturn: [])
            .drive(
                onCompleted: { [weak self] in
                    if let collectionView = self?.collectionView {
                        collectionView.reloadData()
                    }
            })
            .disposed(by: disposeBag)
    }
}

extension CurrencyViewController {
    @objc func onTapDismiss() {
        view.endEditing(true)
    }
    
    @objc func search() {
        query = tableName + "/" + currencyCode + "/" + fromDateTextField.unwrappedText + "/" + toDateTextField.unwrappedText
        bindActivityIndicator()
        bindGetCurrencyRatesData(query: query)
    }
    
    @objc func refreshTable() {
        bindActivityIndicator()
        bindGetCurrencyRatesData(query: query)
    }
}

extension CurrencyViewController {
    func setupDismissTapGestureRecognizer() {
        let dismissTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTapDismiss))
        view.addGestureRecognizer(dismissTapGestureRecognizer)
    }
    
    func setupSearchButton() {
        searchButton.addTarget(self, action: #selector(search), for: .touchUpInside)
        searchButton.tintColor = .white
        searchButton.backgroundColor = .systemGreen
        searchButton.layer.cornerRadius = 10
    }
    
    func setupRefreshButton() {
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(refreshTable))
        refreshButton.tintColor = .darkGray
        self.navigationItem.rightBarButtonItem  = refreshButton
    }
}
