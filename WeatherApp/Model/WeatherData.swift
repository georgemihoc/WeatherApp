//
//  WeatherData.swift
//  WeatherApp
//
//  Created by George on 19/04/2020.
//  Copyright © 2020 George Mihoc. All rights reserved.
//

import Foundation


class WeatherData : Codable{
    let name : String
    let main : Main
    let weather : [Weather]
    
    init(name : String,main : Main,weather : Weather) {
        self.name = name
        self.main = main
        self.weather = [weather]
    }
}
class Main : Codable{
    let temp : Double
}
class Weather : Codable{
    let id : Int
}
