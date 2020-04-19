//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by George on 18/04/2020.
//  Copyright © 2020 George Mihoc. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager, weather: WeatherModel)
    func didFailWithError(error : Error)
}

class WeatherManager{
    let APIKey = "a565bd4e01425bfba1e9c29afe55f03e"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=a565bd4e01425bfba1e9c29afe55f03e&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    func fetchWeather(cityName : String){
        let urlString = weatherURL + "&q=" + cityName
        //        print(urlString)
        performRequest(with: urlString)
    }
    func fetchWeather(latitude : CLLocationDegrees, longitude : CLLocationDegrees) {
        let urlString = weatherURL + "&lat=" + String(latitude) + "&lon=" + String(longitude)
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String) {
        //1.Create url
        if let url = URL(string: urlString){
            //2.Create URLSession
            let session = URLSession(configuration: .default)
            
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in //closure
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            //4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].id)
            let id = decodedData.weather[0].id
            let temperature =  decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temperature)
            return weather
        }
        catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
