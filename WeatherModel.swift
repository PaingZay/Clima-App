//
//  WeatherModel.swift
//  Clima
//
//  Created by Paing Zay on 5/9/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String {
        String(format:"%.1f",temperature)
    }
    
    //This is called Computed Property. It performs the operation based on the property inside the class or struct
    //Looks like method but no need argument to call the method
    //Access the propety like a normal property of an object rather than calling a method of an object.
    var conditionName: String {
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
    
//    func getConditionName(weatherId:Int) -> String {
//
//    }
}
