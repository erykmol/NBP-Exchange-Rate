//
//  UIActivityIndicatorView+setup.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 12/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    func setup(superView: UIView, siblingView: UIView) {
        superView.addSubview(self)
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: siblingView.centerXAnchor),
            self.centerYAnchor.constraint(equalTo: siblingView.centerYAnchor),
            self.heightAnchor.constraint(equalToConstant: 60),
            self.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}
