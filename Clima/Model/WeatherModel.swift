//
//  WeatherModel.swift
//  Clima
//
//  Created by Mariah Baysic on 2/17/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let id: Int
    let name: String
    let type1: String
    let type2: String?
    
    init(id: Int, name: String, type1: String) {
        self.id = id
        self.name = name
        self.type1 = type1
        self.type2 = nil
    }
    
    init(id: Int, name: String, type1: String, type2: String) {
        self.id = id
        self.name = name
        self.type1 = type1
        self.type2 = type2
    }
    
    // #152 Computed Properties
    var type1Img: String {
        switch type1 {
        case "fighting":
            return "hand.wave"
        case "flying":
            return "swift"
        case "poison":
            return "burn"
        case "ground":
            return "option"
        case "rock":
            return "seal"
        case "bug":
            return "ladybug"
        case "ghost":
            return "lasso"
        case "steel":
            return "gear"
        case "fire":
            return "flame"
        case "water":
            return "drop"
        case "grass":
            return "leaf"
        case "electric":
            return "bolt"
        case "psychic":
            return "eye"
        case "ice":
            return "snow"
        case "dragon":
            return "tropicalstorm"
        case "dark":
            return "moon"
        case "fairy":
            return "sparkles"
        case "normal":
            return "mustache"
        default:
            return "xmark"
        }
    }
    
    var type2Img: String {
        switch type2 {
        case "fighting":
            return "hand.wave"
        case "flying":
            return "swift"
        case "poison":
            return "burn"
        case "ground":
            return "option"
        case "rock":
            return "seal"
        case "bug":
            return "ladybug"
        case "ghost":
            return "lasso"
        case "steel":
            return "gear"
        case "fire":
            return "flame"
        case "water":
            return "drop"
        case "grass":
            return "leaf"
        case "electric":
            return "bolt"
        case "psychic":
            return "eye"
        case "ice":
            return "snow"
        case "dragon":
            return "tropicalstorm"
        case "dark":
            return "moon"
        case "fairy":
            return "sparkles"
        case "normal":
            return "mustache"
        default:
            return "xmark"
        }
    }
}
