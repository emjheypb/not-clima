//
//  WeatherData.swift
//  Clima
//
//  Created by Mariah Baysic on 2/17/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

// #153 Typealias ("Codable")
struct WeatherData: Codable {
    let name: String
    let id: Int
    let types: [Types]
}

struct Types: Codable {
    let type: Type
}

struct Type: Codable {
    let name: String
}
