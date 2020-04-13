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
    var viewControllerIndex: Int!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllerIndex = tabBarController?.selectedIndex
        loadingIndicator = createLoadingIndicator()
        
        collectionView.setup(viewController: self)
        setupNavigationBar()
        setupRefreshButton()
        loadingIndicator.setup(superView: view, siblingView: collectionView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bindActivityIndicator()
        bindGetTableData(query: viewModel.tableNameList[viewControllerIndex])
    }
}

extension ExchangeRateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.currentCurrenciesTableRates.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrencyExchangeCell", for: indexPath) as! CurrencyExchangeCollectionViewCell
        let index = indexPath.row
        let currencyRate = viewModel.currentCurrenciesTableRates[index]
        
        cell.currencyNameLabel.text = currencyRate.currency
        cell.averageExchangeRateLabel.text = currencyRate.mid?.description ?? "Brak danych"
        cell.publicationDateLabel.text = viewModel.currentCurrenciesTable.effectiveDate
        cell.currencyCodeLabel.text = currencyRate.code
        
        return cell
    }
}

extension ExchangeRateViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let destinationViewController = CurrencyViewController.storyboardInstantiate("CurrencyViewControllerStoryboard")
        let selectedCurrency = viewModel.currentCurrenciesTableRates[indexPath.row]
        destinationViewController.viewModel = viewModel
        destinationViewController.title = selectedCurrency.currency
        destinationViewController.tableName = viewModel.currentCurrenciesTable.table
        destinationViewController.currencyCode = selectedCurrency.code
        
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
}

extension ExchangeRateViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        
        return CGSize(
            width: collectionViewWidth,
            height: collectionViewWidth / 4)
    }
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

extension ExchangeRateViewController {
    @objc func refreshTable() {
        bindActivityIndicator()
        bindGetTableData(query: viewModel.tableNameList[viewControllerIndex])
    }
}

extension ExchangeRateViewController {
    func setupRefreshButton() {
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(refreshTable))
        refreshButton.tintColor = .darkGray
        self.navigationItem.rightBarButtonItem  = refreshButton
    }
}
