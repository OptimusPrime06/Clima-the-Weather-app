//
//  WeatherData.swift
//  Clima
//
//  Created by Gulliver Raed on 25/09/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData : Codable {
    
    let name : String
    let main : Main
    let weather : [Weather]
}

struct Main : Codable {
    let temp : Double
    let humidity : Int
}

struct Weather : Codable {
    let id : Int
}

