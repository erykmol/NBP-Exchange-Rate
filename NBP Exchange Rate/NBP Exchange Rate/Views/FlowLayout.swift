//
//  FlowLayout.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }

        let collectionViewWidth = collectionView.frame.width
        
        self.itemSize = CGSize(
            width: collectionViewWidth,
            height: collectionViewWidth / 4)
    }
}
