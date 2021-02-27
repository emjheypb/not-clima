//
//  WeatherManager.swift
//  Clima
//
//  Created by Mariah Baysic on 2/16/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit

// #145-147 Protocols and Delegates
protocol WeatherManagerDelegate {
    func didGetWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError (error: Error)
}

struct WeatherManager {
    let pokéapiURL = "https://pokeapi.co/api/v2/pokemon/"
    var delegate: WeatherManagerDelegate?
    
    // #148 API & URL Parameters
    func fetchWeather(name: String) {
        let urlString = "\(pokéapiURL)\(name)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // #149 URL Session
        //1. Create URL
        if let url = URL(string: urlString) {
            //2. Create URLSession
            let session = URLSession(configuration: .default)
            // #150 Closures
            //3. Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    // #151 JSON Decoding
                    if let weather = self.parseJSON(data: safeData) {
                        self.delegate?.didGetWeather(self, weather: weather)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.id
            let name = decodedData.name
            let types = decodedData.types
            
            if types.count == 1 {
                let weather = WeatherModel(id: id, name: name, type1: types[0].type.name)
                return weather
            } else {
                let weather = WeatherModel(id: id, name: name, type1: types[0].type.name, type2: types[1].type.name)
                return weather
            }
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
