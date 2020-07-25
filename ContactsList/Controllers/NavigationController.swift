//
//  NavigationController.swift
//  ContactsList
//
//  Created by hasher on 25/07/20.
//  Copyright © 2020 Avinash. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
}

extension NavigationController: UINavigationControllerDelegate{
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
}
