//
//  FoodDetailsViewController.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit
import WebKit

class FoodDetailsViewController: UIViewController {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var viewModel: ViewModel?
    
    var recipeModel: RecipeModel? {
        didSet {
            APIManager.sharedInstance.getRecipesDetailRequest(id: recipeModel?.recipe_id ?? "") { (recipe) in
                self.recipe = recipe
            }
        }
    }
    
    var recipe : Recipe? {
        didSet {
            refreshUI()
        }
    }
    
    private func refreshUI() {
        
        loadViewIfNeeded()
        
        recipeImage.downloadImage(imageStringUrl: recipe?.recipe?.image_url)
        if let ingredientsArray = recipe?.recipe?.ingredients {
            var ingridients = ""
            for r in ingredientsArray {
                ingridients += "\(r) \n"
            }
            DispatchQueue.main.async {
                self.ingredientsLabel.text = ingridients
            }
            guard let recipeUrl = recipe?.recipe?.source_url  else  { return }
            guard let link = URL(string: recipeUrl ) else { return }
            let request = URLRequest(url: link)
            DispatchQueue.main.async {
                self.webView.load(request)
            }
        }
    }
    
}
extension FoodDetailsViewController: SelectedRecipeDelegate {
    func recipeSelected(_ recipe: RecipeModel) {
        self.recipeModel = recipe
    }
}


 
    
  

extension FoodDetailsViewController {
    class ViewModel {
        
        let recipeId: String
        
        init(recipeId: String) {
            self.recipeId = recipeId
        }
    }
}
