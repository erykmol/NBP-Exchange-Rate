//
//  UIViewController+storyboardInstantiate.swift
//  iCookbook
//
//  Created by Eryk Mól on 08/04/2020.
//  Copyright © 2020 Eryk Mol. All rights reserved.
//

import UIKit

extension UIViewController
{
    class func storyboardInstantiate(_ name: String = "Main") -> Self {
        return storyboardInstantiateHelper(name)
    }

    private class func storyboardInstantiateHelper<T>(_ name: String) -> T {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! T
        return controller
    }
}
