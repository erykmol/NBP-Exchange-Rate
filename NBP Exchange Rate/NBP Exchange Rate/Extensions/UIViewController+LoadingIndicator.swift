//
//  UIViewController+LoadingIndicator.swift
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
    
    func setupLoadingIndicator(loadingIndicator: UIActivityIndicatorView) {
        
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 60),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
