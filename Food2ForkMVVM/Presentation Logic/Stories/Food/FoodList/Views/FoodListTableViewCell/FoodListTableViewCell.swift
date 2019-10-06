//
//  FoodTableViewCell.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 9/30/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

final class FoodListTableViewCell: UITableViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    
    var viewModel: ViewModel? {
        didSet {
            setupViewModel()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        recipeImageView.layer.cornerRadius = 18
        mainView.layer.cornerRadius = 7
    }
}

//MARK: Setup ViewModel

private extension FoodListTableViewCell {
    
    func setupViewModel() {
        guard let viewModel = viewModel else { return }
        
        recipeTitleLabel.text = viewModel.title
        recipeImageView.image = viewModel.image
        
        viewModel.shouldShowImage = { [weak self] image in
            self?.recipeImageView.image = image
        }
        UIView.animate(withDuration: 0.7) {
            self.recipeTitleLabel.removeBluerLoader()
            self.recipeImageView.removeBluerLoader()
        }
    }
    
    func setupView() {
        recipeTitleLabel.showBlurLoader()
        recipeImageView.showBlurLoader()
    }
}
