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
        
        private var recipesDataSource: [Recipe] = []
        
        private(set) var cellViewModelsDataSource: [FoodListTableViewCell.ViewModel] = []
        
        // MARK: Public
        
        private(set)var isInitialFetchRequest: Bool = true
        
        var shouldReloadContent: (()->Void)?
        
        var shouldShowEmptyState: (()->Void)?
        
        var shouldShowRecipeDetails: ((Recipe)->Void)?
        
        func startLoadingData() {
            getSearchResults(query: "")
        }
        
        func didSelectItem(index: Int) {
            if recipesDataSource.count > 0 {
                shouldShowRecipeDetails?(recipesDataSource[index])
            }
        }
        
        func didSearch(query: String) {
            getSearchResults(query: query)
        }
        
        // MARK: API calls
        
        private func getSearchResults(query: String) {
            APIManager.sharedInstance.getRecipesListRequest(query: query, page: "1") { [weak self] response in
                DispatchQueue.main.async {
                    self?.isInitialFetchRequest = false
                    var isEmptyResponse = true
                    if let result = response, let recipes = result.recipes, !recipes.isEmpty {
                        isEmptyResponse = false
                        self?.recipesDataSource = recipes
                        
                        self?.cellViewModelsDataSource.removeAll()
                        for recipe in recipes {
                            let viewModel = FoodListTableViewCell.ViewModel(recipe: recipe)
                            self?.cellViewModelsDataSource.append(viewModel)
                        }
                    } else {
                         self?.cellViewModelsDataSource.removeAll()
                    }
                    
                    self?.shouldReloadContent?()
                    
                    if isEmptyResponse {
                        self?.shouldShowEmptyState?()
                    }
                }
            }
        }
    }
}


