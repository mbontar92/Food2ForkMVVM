//
//  FoodDetailsViewController.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit
import WebKit

final class FoodDetailsViewController: UIViewController {
    
    @IBOutlet private var recipeImageView: UIImageView!
    @IBOutlet private var ingredientsLabel: UILabel!
    @IBOutlet private var webView: WKWebView!
    @IBOutlet weak var emptyView: UIView! {
        didSet {
            self.emptyView.isHidden = self.viewModel?.showEmptyViewBool ?? false
        }
    }

    
    var viewModel: ViewModel? {
        didSet {
            setUpViewModel()
//            if self.viewModel?.showEmptyViewBool ?? true { showEmptyView()
//            } else { hideEmptyView() }
//            self.viewModel?.showEmptyViewBool = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshUI()
    }

    func setUpViewModel() {
        viewModel?.shouldReloadContent = { [weak self] in
            self?.refreshUI()
        }
        
        viewModel?.shouldDisplayImage = { [weak self] image in
            self?.recipeImageView.image = image
        }
        
        viewModel?.startLoadingData()
    }
        
    private func refreshUI() {
        guard let recipe = viewModel?.recipe?.recipe else {
            return
        }
        
        hideEmptyView()
                

        if let ingredientsArray = recipe.ingredients {
            var ingridients = ""
            for r in ingredientsArray {
                ingridients += "\(r) \n"
            }

//            let ingredients = ingredientsArray.reduce("") { $0 + "\($1) \n" }
            
            self.ingredientsLabel.text = ingridients
            guard let recipeUrl = recipe.source_url, let link = URL(string: recipeUrl) else { return }
            
            let request = URLRequest(url: link)
            self.webView.load(request)
        }
    }
    
    private func showEmptyView() {
        emptyView.isHidden = false
        
    }
    
    private func hideEmptyView() {
        emptyView.isHidden = true
    }
}

