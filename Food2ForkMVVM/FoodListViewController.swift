//
//  FoodListViewController.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

protocol SelectedRecipeDelegate: class {
    func recipeSelected(_ recipe: RecipeModel)
}

class FoodListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var recipeModelArray : [RecipeModel] = []
    var recipeModel : Recipe?
    
    weak var delegate: SelectedRecipeDelegate?
    
    let animationProgressView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        
        APIManager.sharedInstance.getRecipesListRequest(query: "", page: "1") { (response) in
            if let response = response {
                self.recipeModelArray = response.recipes!
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
        /*
         APIManager.sharedInstance.getRecipesDetailRequest(id: "2147") { (response) in
         if response != nil {
         self.recipeModel? = response!
         print(response?.recipe?.ingredients?.count)
            }
        }
        */
        
    }
    
    func setUpTableView() {
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodTableViewCell")
        tableView.backgroundView = UIImageView(image: UIImage(named: "pineapple"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
    }
    
    func setUpAnimationView() {
        let width = view.frame.width/3
        animationProgressView.frame = CGRect(x: 0, y: 0, width: width, height: width)
        animationProgressView.backgroundColor = .blue
        animationProgressView.layer.cornerRadius = 10
        animationProgressView.center = self.view.center
        self.view.addSubview(animationProgressView)
    }
}



extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return recipeModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let recipe = recipeModelArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        cell.setRecipeData(recipe: recipe)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         when selected lell you must path to detail controller recipe id
        let recipeId = recipeModelArray[indexPath.row]
        delegate?.recipeSelected(recipeId)
        if
            let detailViewController = delegate as? DetailViewController,
            let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension FoodListViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("begin editing")
    }
}
