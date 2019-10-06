//
//  FoodDetailsViewController+ViewModel.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/4/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

extension FoodDetailsViewController {
    
    class ViewModel {
        
        // MARK: Private
        
        private var recipeId: String
        
        private(set)var recipe: Recipe? {
            didSet {
                downloadRecipeImage()
            }
        }
        
        // MARK: Public
        
        var shouldReloadContent: (()->Void)?
        
        var shouldDisplayImage: ((UIImage)->Void)?
        
        var showEmptyViewBool: Bool = true
        
        func startLoadingData() {
            getDetailResults(id: recipeId)
        }
        
        // MARK: Init
        
        init(recipeId: String) {
            self.recipeId = recipeId
        }
        
        // MARK: API calls
        
        private func getDetailResults(id: String) {
            APIManager.sharedInstance.getRecipesDetailRequest(id: id) { [weak self] response in
                DispatchQueue.main.async {
                    
                    switch response {
                        
                    case .success(let result):
                        self?.recipe = result.recipe
                        self?.shouldReloadContent?()
                    case .failure(let error):
                        print("error")
                    }
                }
            }
        }
        
        private func downloadRecipeImage() {
            ImageDownloader.download(url: recipe?.image_url) { [weak self] result in
                if let image = result {
                    DispatchQueue.main.async {
                        self?.shouldDisplayImage?(image)
                    }
                }
            }
        }
    }
}
