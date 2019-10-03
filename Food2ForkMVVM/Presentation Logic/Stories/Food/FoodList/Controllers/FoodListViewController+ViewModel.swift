//
//  FoodListViewController+ViewModel.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/3/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

extension FoodListViewController {
    class ViewModel {
        
        private var recipesDataSource: [RecipeModel] = []
        
        private(set) var cellViewModelsDataSource: [FoodListTableViewCell.ViewModel] = []
        
        // MARK: Public
        
        var shouldShowBluredContent: Bool = true
        
        var shouldReloadContent: (()->Void)?
        
        var shouldShowEmptyState: (()->Void)?
        
        var shouldShowRecipeDetails: ((RecipeModel)->Void)?
        
        func didSelectItem(index: Int) {
            shouldShowRecipeDetails?(recipesDataSource[index])
        }
        
        func didSearch(query: String) {
            getSearchResults(query: query)
        }
        
        // MARK: API calls
        
        private func getSearchResults(query: String) {
            APIManager.sharedInstance.getRecipesListRequest(query: query, page: "1") { [weak self] response in
                var isEmptyResponse = true
                if let result = response, let recipes = result.recipes {
                    isEmptyResponse = false
                    self?.recipesDataSource = recipes
                    
                    self?.cellViewModelsDataSource.removeAll()
                    for recipe in recipes {
                        let viewModel = FoodListTableViewCell.ViewModel(recipe: recipe)
                        self?.cellViewModelsDataSource.append(viewModel)
                    }
                }
                
                self?.shouldShowBluredContent = isEmptyResponse
                
                DispatchQueue.main.async {
                    self?.shouldReloadContent?()
                    
                    if isEmptyResponse {
                        self?.shouldShowEmptyState?()
                    }
                }
            }
        }
    }
}


