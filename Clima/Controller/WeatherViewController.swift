//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet weak var type1ImgVw: UIImageView!
    @IBOutlet weak var type2ImgVw: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var nameTxtFld: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTxtFld.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        nameTxtFld.endEditing(true)
    }
    
    @IBAction func locationPressed(_ sender: Any) {
    }
}

//MARK: - WeatherManagerDelegate
// #145-147 Protocols and Delegates; #156 DispatchQueue; #157-158 Extensions
extension WeatherViewController: WeatherManagerDelegate {
    func didGetWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = "\(weather.id)"
            self.cityLabel.text = weather.name.capitalized
            self.type1ImgVw.image = UIImage(systemName: weather.type1Img)
            self.type2ImgVw.image = UIImage(systemName: weather.type2Img)
        }
    }
    
    // #155 Error Handling
    func didFailWithError(error: Error) {
        print(error)
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = "?"
            self.cityLabel.text = "Who's that pokémon?"
            self.type1ImgVw.image = UIImage(systemName: "xmark")
            self.type2ImgVw.image = UIImage(systemName: "xmark")
        }
    }
}

//MARK: - UITextFieldDelegate
// #144 UITextFields; #157-158 Extensions
extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTxtFld.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Who's that Pokémon?"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let pokemon = nameTxtFld.text {
            weatherManager.fetchWeather(name: pokemon)
        }
        
        nameTxtFld.text = ""
    }
}
