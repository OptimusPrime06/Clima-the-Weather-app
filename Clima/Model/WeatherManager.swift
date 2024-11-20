//
//  WeatherManager.swift
//  Clima
//
//  Created by Gulliver Raed on 05/09/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {

    var delegate: WeatherManagerDelegate?
    let weatherURL =
        "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=" // put you app id

    func fetchURL(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        preformRequest(with: urlString)
    }
    
    func fetchURL(latitude: CLLocationDegrees, longtude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longtude)"
        preformRequest(with: urlString)
    }

    func preformRequest(with urlString: String) {

        // 1. create URL
        if let url = URL(string: urlString) {

            // 2. Create Session
            let session = URLSession(configuration: .default)

            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    // print(error!)
                    self.delegate?.didFailWithError(error: error!)
                    return
                }

                if let safeData = data {
                    //let dataString  = String(data: safeData, encoding: .utf8)
                    if let weather = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    //print(dataString ?? "Nothing recieved")
                }
            }

            // 4. start the task
            task.resume()
        }

    }

    func parseJSON(_ weatherData: Data) -> WeatherModel? {

        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(
                WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let humid = decodedData.main.humidity
            let cityName = decodedData.name

            let weather = WeatherModel(cityname: cityName, temprature: temp, humidity: humid, conditionId: id)
            return weather

        } catch {
            delegate?.didFailWithError(error: error )
            //print(error)
            return nil
        }
    }

}
