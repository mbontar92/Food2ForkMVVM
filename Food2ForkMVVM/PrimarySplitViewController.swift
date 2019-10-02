//
//  PrimarySplitViewController.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

class PrimarySplitViewController: UISplitViewController, UISplitViewControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.preferredDisplayMode = .automatic
        
    }
    
    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController) -> Bool {
        // Return true to prevent UIKit from applying its default behavior
        return true
    }

}
