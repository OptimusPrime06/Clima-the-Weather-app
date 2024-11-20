//
//  WeatherModel.swift
//  Clima
//
//  Created by Gulliver Raed on 10/6/24.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import UIKit

struct WeatherModel {

    let cityname: String
    let temprature: Double
    
    var tempratureString : String {
        return String(format: "%.1f", temprature)
    }
    
    let humidity : Int
    
    var humidityString : String {
        return "Humidity: \(String(humidity))%"
    }
   
    let conditionId: Int

    var conditonName : String {

        switch conditionId {
        case 200...232: return "cloud.bolt.rain"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain"
        case 600...622: return "snow"
        case 701: return "cloud.fog"
        case 711: return "smoke"
        case 721: return "sun.haze"
        case 731: return "sun.dust"
        case 741: return "cloud.fog"
        case 751...762: return "sun.dust"
        case 771: return "cloud.heavyrain"
        case 781: return "tornado"
        case 800: return "sun.max"
        case 801...804: return "cloud.fill"
        default:
            return "cloud"
        }
        }
    
    var weatherWallpaper : UIImage {
        
        switch conditonName {
        case "cloud.bolt.rain": return UIImage(imageLiteralResourceName: "thunderStorm")
        case "cloud.drizzle.fill": return UIImage(imageLiteralResourceName: "heavyRain")
        case "cloud.rain": return UIImage(imageLiteralResourceName: "rainy")
        case "snow": return UIImage(imageLiteralResourceName: "snowy")
        case "cloud.fog": return UIImage(imageLiteralResourceName: "sunFog")
        case "smoke": return UIImage(imageLiteralResourceName: "smokey")
        case "sun.haze": return UIImage(imageLiteralResourceName: "sunHaze")
        case "sun.dust": return UIImage(imageLiteralResourceName: "sunDust")
        case "cloud.heavyrain": return UIImage(imageLiteralResourceName: "heavyRain")
        case "tornado": return UIImage(imageLiteralResourceName: "tornado")
        case "sun.max": return UIImage(imageLiteralResourceName: "sunny")
        case "cloud.fill": return UIImage(imageLiteralResourceName: "cloudy")
        case "cloud": return UIImage(imageLiteralResourceName: "cloudy")
        default:
            return UIImage(imageLiteralResourceName: "clearSky")
        }
        
    }
}
