//
//  File.swift
//  Clima
//
//  Created by Paing Zay on 4/9/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=10cf81edcba67b3b37fdb2a65108224b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        //Create a URL
        if let url = URL(string: urlString){
            
        //Create a URlsession
        let session = URLSession(configuration: .default)
                
        //Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return//If error happened exit out of this function
                }
                    if let safeData = data {
                        //weatherData
                        //Inside the closure requires an explicit self if we are calling a method from the current class
                        if let weather = self.parseJSON(safeData) {
                            self.delegate?.didUpdateWeather(self, weather: weather)
                        }
                    }
            }
            //Start the task
            task.resume()
        }
    }
    
    //Here Weather Model need to be optional if there might be nil as a return
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
            
            print(weather.conditionName)
            print(weather.temperatureString)
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
//    func handle(data:Data?, response:URLResponse?, error:Error?) {
//        //Check to see was there an error in this whole networking process
//        if error != nil {
//            print(error!)//Unwrap error
//            return//If error happened exit out of this function
//        }
//        if let safeData = data {
//            let dataString = String(data:safeData, encoding: .utf8)
//            print(dataString)
//        }
//    }
}
