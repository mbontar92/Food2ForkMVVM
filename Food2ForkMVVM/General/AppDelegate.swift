//
//  AppDelegate.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 9/30/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        guard
            let splitViewController = window?.rootViewController as? UISplitViewController,
            let leftNavController = splitViewController.viewControllers.first
                as? UINavigationController,
            let foodListViewController = leftNavController.viewControllers.first
                as? FoodListViewController,
            let detailFoodViewController =
            (splitViewController.viewControllers.last as? UINavigationController)?
                .topViewController as? FoodDetailsViewController
            else { fatalError() }

        foodListViewController.viewModel = FoodListViewController.ViewModel()
                
        // back buttons to IPAD
        detailFoodViewController.navigationItem.leftItemsSupplementBackButton = true
        detailFoodViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
        
        
        return true
        
    }
}
