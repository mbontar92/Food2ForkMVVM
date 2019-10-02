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
    
    var recipe: RecipeModel? {
        didSet {
            refreshUI()
        }
    }
    private func refreshUI() {
        
        loadViewIfNeeded()
        
        // here need to send request with id and then fill in to VC
        print(recipe?.recipe_id ?? "no id")
        
//        if let ingredients = recipe?.ingredients {
//
//            for r in ingredients {
//                ingredientsLabel.text = " \(r) /n"
//            }
//        }
//        if let url = URL(string: recipe?.recipe_url ?? "") {
//            webView.load(URLRequest(url: url))
//        }
//        print("UI refreshed")
    }
    
}

extension DetailViewController: SelectedRecipeDelegate {
    func recipeSelected(_ recipe: RecipeModel) {
        self.recipe = recipe
    }
    
    
 
    
  

}
