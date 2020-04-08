//
//  MainTabBarViewController.swift
//  NBP Exchange Rate
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mól. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var controllers: [UINavigationController] = []
        let titleList = ["Table A", "Table B", "Table C"]
        let viewModel = ViewModel()
        
        for index in 0...2 {
            let navigationController = UINavigationController()
            let viewController = ExchangeRateViewController.storyboardInstantiate("ExchangeRateViewControllerStoryboard")
            let icon = UITabBarItem(title: titleList[index], image: UIImage(systemName: "table"), selectedImage: UIImage(systemName: "table.fill"))
            
            viewController.viewModel = viewModel
            viewController.tabBarItem = icon
            navigationController.viewControllers = [viewController]
            controllers.append(navigationController)
        }
        self.viewControllers = controllers
        self.selectedIndex = 0
    }
}
