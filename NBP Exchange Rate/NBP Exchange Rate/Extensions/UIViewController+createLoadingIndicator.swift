//
//  UIViewController+createLoadingIndicator.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 09/04/2020.
//  Copyright © 2020 Eryk Mol. All rights reserved.
//

import UIKit

extension UIViewController {
    func createLoadingIndicator() -> UIActivityIndicatorView {
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.color = .black
        
        return loadingIndicator
    }
}
