//
//  FoodTableViewCell.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 9/30/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        recipeImage.layer.cornerRadius = 18
        mainView.layer.cornerRadius = 7
        recipeTitle.showBlurLoader()
        recipeImage.showBlurLoader()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setRecipeData(recipe: RecipeModel)
    {
        self.recipeTitle.text = recipe.title
        recipeImage.downloadImage(imageStringUrl: recipe.image_url)
        recipeTitle.removeBluerLoader()
        recipeImage.removeBluerLoader()
    }
    
}
