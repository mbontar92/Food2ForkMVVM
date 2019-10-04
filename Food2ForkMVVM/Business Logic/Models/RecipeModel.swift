//
//  Model.swift
//  Food2ForkMVVM
//
//  Created by Lorem on 10/1/19.
//  Copyright © 2019 Bontar Mykhailo. All rights reserved.
//

import UIKit

struct RecipeArray: Codable {
    var recipes: [RecipeModel]?
}

struct Recipe: Codable {
     var recipe: RecipeModel?
}

struct RecipeModel: Codable {
    var publisher: String?
    var f2f_url: String?
    var title: String?
    var source_url: String?
    var recipe_url: String?
    var recipe_id: String?
    var image_url: String?
    var social_rank: Float?
    var publisher_url: String?
    var ingredients: [String]?
}



