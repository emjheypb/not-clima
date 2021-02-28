//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    @IBOutlet weak var type1ImgVw: UIImageView!
    @IBOutlet weak var type2ImgVw: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var nameTxtFld: UITextField!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTxtFld.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
    }

    @IBAction func searchPressed(_ sender: UIButton) {
        nameTxtFld.endEditing(true)
    }
    
    @IBAction func locationPressed(_ sender: Any) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
//        for continuous fetching of location: locationManager.startUpdatingLocation()
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

//MARK: - CLLocationManagerDelegate
// #159 Core Location - includes Info.plist changes
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            manager.stopUpdatingLocation()
            let long = location.coordinate.longitude
            let lat = location.coordinate.latitude
            
            let alert = UIAlertController(title: "Location", message: "Long: \(long)\nLat: \(lat)", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "Approve", style: .default, handler: { (_) in
                print("User click Approve button")
            }))
            
            alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: { (_) in
                print("User click Edit button")
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
                print("User click Delete button")
            }))
            
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
                print("User click Dismiss button")
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
