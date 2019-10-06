//
//  Model.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

struct RecipeSearchResponse: Codable {
    var recipes: [Recipe]?
}

struct RecipeDetailsRepsonse: Codable {
    var recipe: Recipe?
}

struct Recipe: Codable {
    var title: String?
    var recipe_id: String?
    var publisher: String?
    var publisher_url: String?
    var f2f_url: String?
    var source_url: String?
    var social_rank: Float?
    var image_url : String?
    var ingredients: [String]?
}



