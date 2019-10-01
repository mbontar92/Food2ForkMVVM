//
//  FoodListViewController.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

protocol SelectedRecipeDelegate: class {
    func recipeSelected(_ newRecipe: RecipeModel)
}

class FoodListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var recipeModelArray : [RecipeModel] = []
    var recipeModel : Recipe?
    
     weak var delegate: SelectedRecipeDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodTableViewCell")
        tableView.backgroundView = UIImageView(image: UIImage(named: "pineapple"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
        /*
         APIManager.sharedInstance.getRecipesListRequest(query: "", page: "1") { (response) in
         if let response = response {
         self.recipeModelArray = response.recipes!
         }
         }
         */
        
        /*
         APIManager.sharedInstance.getRecipesDetailRequest(id: "2147") { (response) in
         if response != nil {
         self.recipeModel? = response!
         print(response?.recipe?.ingredients?.count)
            }
        }
        */
        
    }
}

extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30 // .count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let recipeTitle = recipeModelArray[indexPath.row].title
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        
//        cell.recipeTitle.text = recipeTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = recipeModelArray[indexPath.row]
        delegate?.recipeSelected(selectedRecipe)
        if
            let detailViewController = delegate as? DetailViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}

extension FoodListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("begin editing")
    }
}
