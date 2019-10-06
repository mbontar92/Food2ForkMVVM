//
//  FoodListTableViewCell+ViewModel.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/3/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

extension FoodListTableViewCell {
    
    class ViewModel {
        
        private let recipe: Recipe
        
        var title: String? {
            return recipe.title
        }
        
        var image: UIImage?
        
        var shouldShowImage: ((UIImage) -> Void)?
        
        init(recipe: Recipe) {
            self.recipe = recipe
            
            downloadRecipeImage()
        }
        
        // MARK: Private
        
        private func downloadRecipeImage() {
            ImageDownloader.download(url: recipe.image_url) { [weak self] downloadedImage in
                DispatchQueue.main.async {
                    if let image = downloadedImage {
                        self?.shouldShowImage?(image)
                        self?.image = image
                    }
                }
            }
        }
    }
}


