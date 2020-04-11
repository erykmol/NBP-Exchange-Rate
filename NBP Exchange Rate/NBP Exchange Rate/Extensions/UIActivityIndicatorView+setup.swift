//
//  UIActivityIndicatorView+setup.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 12/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func setup(view: UIView) {
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            self.heightAnchor.constraint(equalToConstant: 60),
            self.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
