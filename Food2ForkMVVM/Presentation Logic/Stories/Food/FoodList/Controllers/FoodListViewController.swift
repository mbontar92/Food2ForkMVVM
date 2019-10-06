//
//  FoodListViewController.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

//protocol SelectedRecipeDelegate: class {
//    func recipeSelected(_ recipe: RecipeModel)
//}

// classes marked with final can not be overridden.
final class FoodListViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var alertView: UIView!
    @IBOutlet private var allertViewBottomConstraint: NSLayoutConstraint!
    
    // MARK: Variables
    
    var viewModel: ViewModel?
    
//    weak var delegate: SelectedRecipeDelegate?
    
    private var typingTimer: Timer?
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupViewModel()
    }
    
    // MARK: IBActions
    
    @IBAction func alertActionButtonDidPressed(_ sender: Any) {
        hideEmptyStateAlert()
    }
}

// MARK: - Private

private extension FoodListViewController {
    func setupViews() {
        setupTableView()
        setupAlertView()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: String(describing: FoodListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: FoodListTableViewCell.self))
        tableView.backgroundView = UIImageView(image: UIImage(named: "pineapple"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120.0
    }
    
    private func setupAlertView() {
        allertViewBottomConstraint.constant = view.frame.height / 3
        alertView.layer.cornerRadius = 12
    }
    
    func showEmptyStateAlert() {
        allertViewBottomConstraint.constant = -view.frame.height / 3
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func hideEmptyStateAlert() {
        allertViewBottomConstraint.constant = view.frame.height / 3
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
    }
    
    func setupViewModel() {
        viewModel?.startLoadingData()
        
        viewModel?.shouldReloadContent = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel?.shouldShowRecipeDetails = { [weak self] recipe in
            self?.showRecipeDetails(recipe: recipe)
        }
        
        viewModel?.shouldShowEmptyState = { [weak self] in
            self?.showEmptyStateAlert()
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel?.isInitialFetchRequest ?? true { return 30 }
    
        return viewModel?.cellViewModelsDataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FoodListTableViewCell.self), for: indexPath) as? FoodListTableViewCell else { return UITableViewCell() }
        
        if !(viewModel?.isInitialFetchRequest ?? true) {
            let cellViewModel = viewModel?.cellViewModelsDataSource[indexPath.row]
            cell.viewModel = cellViewModel
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectItem(index: indexPath.row)
        
    }
}

// MARK: - UISearchBarDelegate

extension FoodListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        typingTimer?.invalidate()

        typingTimer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: true, block: { [weak self] _ in
            self?.viewModel?.didSearch(query: searchText)
            self?.typingTimer?.invalidate()
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Screen presentation

private extension FoodListViewController {
    func showRecipeDetails(recipe: Recipe) {
        if let navigationController = splitViewController?.viewControllers.last as? UINavigationController, let detailsController = navigationController.viewControllers.first as? FoodDetailsViewController {
            let detailsViewModel = FoodDetailsViewController.ViewModel(recipeId: recipe.recipe_id ?? "")
            detailsController.viewModel = detailsViewModel
            
            
             detailsController.viewModel?.showEmptyViewBool = false
            
        } else if let detailsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: FoodDetailsViewController.self)) as? FoodDetailsViewController {
            
            let detailsViewModel = FoodDetailsViewController.ViewModel(recipeId: recipe.recipe_id ?? "")
            detailsController.viewModel = detailsViewModel

            
            splitViewController?.showDetailViewController(UINavigationController(rootViewController: detailsController), sender: nil)
        }
    }
}
