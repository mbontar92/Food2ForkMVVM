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
    @IBOutlet weak var allertViewBottomConstraint: NSLayoutConstraint!
    
    
    var recipeModelArray: [RecipeModel] = []
    var recipeModel : Recipe?
    weak var delegate: SelectedRecipeDelegate?
    @IBOutlet weak var alertView: UIView!
 
    
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
    @IBAction func alertActionButtonDidPressed(_ sender: Any) {
        
        allertViewBottomConstraint.constant = view.frame.height / 3
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func setUpTableView() {
        tableView.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodTableViewCell")
        tableView.backgroundView = UIImageView(image: UIImage(named: "pineapple"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
        allertViewBottomConstraint.constant = view.frame.height / 3
        alertView.layer.cornerRadius = 12
    }
}



extension FoodListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if recipeModelArray.count <= 0 { return 15 }
        else { return  recipeModelArray.count}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodTableViewCell", for: indexPath) as! FoodTableViewCell
        
        if recipeModelArray.count > 0 {
            let recipe = recipeModelArray[indexPath.row]
            cell.setRecipeData(recipe: recipe)
            return cell
        }
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
        
        allertViewBottomConstraint.constant = -view.frame.height / 3
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}
