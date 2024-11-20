///Users/gulliverraed/WeatherManager.swift
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import CoreLocation
import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var returnToCurrentLocation: UIButton!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        weatherManager.delegate = self
        searchTextField.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        

    }

    @IBAction func returnToCurrentLocation(_ sender: UIButton) {
        self.returnToCurrentLocation.setBackgroundImage(
            UIImage(systemName: "location.north.circle.fill"), for: .normal)
        //My Solution
        /*locationManager.requestLocation()
        locationManager(locationManager, didUpdateLocations: [locationManager.location!])
         */

        // Dr.Angela's Solution
        locationManager.requestLocation()
        /* the rest is in func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
     */
    }

}

//MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            // rest of Dr.Angela's Solution :
            //locationManager.stopUpdatingLocation()
            //end of Dr.Angela's Solution
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchURL(latitude: lat, longtude: lon)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }

}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        print(searchTextField.text!)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        // change the weather according to selelcted city
        if let city = searchTextField.text {
            weatherManager.fetchURL(cityName: city)
        }

        searchTextField.text = ""
        searchTextField.placeholder = "Search"
        self.returnToCurrentLocation.setBackgroundImage(
            UIImage(systemName: "location.circle.fill"), for: .normal)
    }

}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {

    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.conditionImageView.image = UIImage(
                systemName: weather.conditonName)
            self.cityLabel.text = weather.cityname
            self.humidityLabel.text = weather.humidityString
            self.backgroundImage.image = weather.weatherWallpaper
            
        }
    }

    func didFailWithError(error: any Error) {
        print(error)
    }

}
