//
//  APIManager.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import Foundation


class APIManager {
    
    static let sharedInstance = APIManager()
    
    var baseUrl = "https://www.food2fork.com/api/"
    var key = "1a73adfdd5c60df126eb811a6a4b450e"
    var query = ""
    var page = "1"
    var id = ""
    
    // API Manager to get all list of recipes and search by word
    func getRecipesListRequest(query: String? , page: String? = "1", completion: @escaping (_ response: RecipeArray?) -> Void) {
        
        let url = "\(baseUrl)search?key=\(key)&q=\(query ?? "")&page=\(page ?? "1" )"
        
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    do {
                        let recipe = try JSONDecoder().decode(RecipeArray.self, from: data!)
                        completion(recipe)
                        
                    } catch {
                        completion(nil)
                        print(error)
                    }
                } else {
                    print("getRequest: ", error ?? "error")
                    completion(nil)
                }
            }
            session.resume()
        }
    }
    
    // API Manager to get detail information of recipe with "id"
    func getRecipesDetailRequest(id: String, completion: @escaping (_ response: Recipe?) -> Void)  {
        
        let url = "\(baseUrl)get?key=\(key)&&rId=\(id)"
        
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    do {
                        let recipe = try JSONDecoder().decode(Recipe.self, from: data!)
                        completion(recipe)
                        
                    } catch {
                        completion(nil)
                        print(error)
                    }
                } else {
                    print("getRequest: ", error ?? "error")
                    completion(nil)
                }
            }
            session.resume()
        }
    }
}
