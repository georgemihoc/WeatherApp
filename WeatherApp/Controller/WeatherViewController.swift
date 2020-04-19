//
//  ViewController.swift
//  WeatherApp
//
//  Created by George on 18/04/2020.
//  Copyright © 2020 George Mihoc. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation() // request for user's location
        
        
        weatherManager.delegate = self //mark as delegate
        searchTextField.delegate = self
    }
    
}


//MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate{
    @IBAction func searchPressed(_ sender: Any) {
            searchTextField.endEditing(true) // tell the search field to hide keyboard
    //        print(searchTextField.text!)
        }
        @IBAction func currentLocationPressed(_ sender: UIButton) {
//            weatherManager.fetchWeather(latitude: lat ,longitude: lon)
            locationManager.requestLocation()
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true) // tell the search field to hide keyboard
            searchPressed(AnyClass.self)
            return true
        }
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if textField.text != ""{
                return true
            }
            textField.placeholder = "Type something here"
            return false
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
            //get info from textfield first
            guard let city = searchTextField.text else {
                return
            }
            weatherManager.fetchWeather(cityName: city)
            
            searchTextField.text = ""
        }
}
//MARK: - WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModel) {
        print(weather.temperatureString)
        DispatchQueue.main.async {
            self.cityLabel.text = weather.cityName
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }

    }
    func didFailWithError(error: Error) {
        print(error)
    }
}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        print("Got location data")
        if let location = locations.last{
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
            weatherManager.fetchWeather(latitude: lat ,longitude: lon)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
