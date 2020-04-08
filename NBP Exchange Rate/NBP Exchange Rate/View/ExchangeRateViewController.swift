//
//  ExchangeRateViewController.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

class ExchangeRateViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var viewModel: ViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setup(viewController: self)
        setupNavigationBar()
    }


}

extension ExchangeRateViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension ExchangeRateViewController: UICollectionViewDelegate {
        
}


