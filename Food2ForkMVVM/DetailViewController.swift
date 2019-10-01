//
//  DetailViewController.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
    
    var recipe: Recipe? {
        didSet {
            refreshUI()
        }
    }
    private func refreshUI() {
//        loadViewIfNeeded()
//        monsterNameLabel.text = monster?.name
//        monsterDescriptionLabel.text = monster?.description
//        iconImageView.image = monster?.icon
//        weaponImageView.image = monster?.weapon.image
        print("UI refreshed")
    }

}

extension DetailViewController: SelectedRecipeDelegate {
    func recipeSelected(_ newRecipe: RecipeModel) {
        
        print(newRecipe.title)
    }
}
