//
//  ExchangeRateViewController.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExchangeRateViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: ViewModel!
    var loadingIndicator: UIActivityIndicatorView!
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setup(viewController: self)
        setupNavigationBar()
        
        loadingIndicator = createLoadingIndicator()
        setupLoadingIndicator(loadingIndicator: loadingIndicator)
        bindActivityIndicator()
        bindGetTableData(query: "A")
    }


}

extension ExchangeRateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentTableRates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyExchangeCell", for: indexPath) as! CurrencyExchangeCollectionViewCell
        let index = indexPath.row
        let currencyRate = viewModel.currentTableRates[index]
        
        cell.currencyNameLabel.text = currencyRate.currency
        cell.averageExchangeRateLabel.text = currencyRate.mid != nil ? currencyRate.mid?.description : "Nie dostępne"
        cell.publicationDateLabel.text = viewModel.currentTable.effectiveDate
        cell.currencyCodeLabel.text = currencyRate.code
        
        return cell
    }
}

extension ExchangeRateViewController: UICollectionViewDelegate {
        
}

extension ExchangeRateViewController {
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
    
    func bindGetTableData(query: String) {
        viewModel.getTableData(query: query, dataTask: URLSession.shared.dataTask(with:completionHandler:))
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
