//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by George on 19/04/2020.
//  Copyright © 2020 George Mihoc. All rights reserved.
//

import Foundation

class WeatherModel{
    let conditionId : Int
    let cityName : String
    let temperature : Double
    
    var conditionName : String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
    
    var temperatureString : String {
        return String(format : "%.1f",temperature)
    }
    
    init(conditionId : Int, cityName : String , temperature : Double ) {
        self.conditionId = conditionId
        self.cityName = cityName
        self.temperature = temperature
    }
    
}
