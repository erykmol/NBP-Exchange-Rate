//
//  UIViewController+setupNavigationBar.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNavigationBar() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = .systemGreen
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray]
            appearance.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
        } else {
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.backgroundColor = .systemGreen
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray]
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        }
    }
}
