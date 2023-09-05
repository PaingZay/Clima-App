//
//  File.swift
//  Clima
//
//  Created by Paing Zay on 4/9/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=10cf81edcba67b3b37fdb2a65108224b&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //Create a URL
        if let url = URL(string: urlString){
            
        //Create a URlsession
        let session = URLSession(configuration: .default)
            
        //Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)//Unwrap error
                    return//If error happened exit out of this function
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)//Inside the closure requires an explicit self if we are calling a method from the current class
                }
            }
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
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
