//
//  APIManager.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case freeLimit
}

private struct RequestProperties {
       
       var baseUrl = "https://www.food2fork.com/api/"
       var key = "1a73adfdd5c60df126eb811a6a4b450e"
       var query = ""
       var page = "1"
       var id = ""
   }

class APIManager {
    
    static let sharedInstance = APIManager()
    
    private var urlProperties = RequestProperties()
    
    // API Manager to get all list of recipes and search by word
       func getRecipesListRequest(query: String? , page: String? = "1", completion: @escaping (Swift.Result<RecipeSearchResponse, Error>) -> Void) {
           
        let url = "\(urlProperties.baseUrl)search?key=\(urlProperties.key)&q=\(query ?? "")&page=\(page ?? "1" )"
           
           if let url = URL(string: url) {
               let request = URLRequest(url: url)
               let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                   if let responseData = data {
                       do {
                           let recipesResponse = try JSONDecoder().decode(RecipeSearchResponse.self, from: responseData)
                           completion(.success(recipesResponse))
                       } catch {
                           completion(.failure(error))
                       }
                   } else {
                       completion(.failure(NetworkError.freeLimit))
                   }
               }
               session.resume()
           }
       }
    
    
    // API Manager to get detail information of recipe with "id"
    func getRecipesDetailRequest(id: String, completion: @escaping (Swift.Result<RecipeDetailsRepsonse, Error>) -> Void)  {
        
        let url = "\(urlProperties.baseUrl)get?key=\(urlProperties.key)&&rId=\(id)"
        
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
                
                if let responseData = data {
                    do {
                        let recipeResponse = try JSONDecoder().decode(RecipeDetailsRepsonse.self, from: responseData)
                        completion(.success(recipeResponse))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.freeLimit))
                }
            }
            session.resume()
        }
    }
}
