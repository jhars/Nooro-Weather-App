//
//  WeatherViewModel.swift
//  Nooro03
//
//  Created by MAC PAN on 12/12/24.
//

import Foundation

class CityWeatherViewModel: ObservableObject {
    
    var city: String
    var temp_f: String
    var condition_text: String
    var condition_icon: String
    var humidity: String
    var uv: String
    var feelslike_f: String
    var region: String
    var country: String
    
    init(city: String,
         temp_f: Float,
         condition_text: String,
         condition_icon: String,
         humidity: Int,
         uv: Float,
         feelslike_f: Float,
         region: String,
         country: String
    ) {
        self.city = city
        self.temp_f = String(Int(temp_f))
        self.condition_text = condition_text
        self.condition_icon = condition_icon
        self.humidity = String(humidity)
        self.uv = String(humidity)
        self.feelslike_f = String(Int(feelslike_f))
        self.region = region
        self.country = country
        
        let defaults = UserDefaults.standard
        defaults.set(city, forKey: "city")
        defaults.set(temp_f, forKey: "temp_f")
        defaults.set(condition_text, forKey: "condition_text")
        defaults.set(condition_icon, forKey: "condition_icon")
        defaults.set(humidity, forKey: "humidity")
        defaults.set(uv, forKey: "uv")
        defaults.set(feelslike_f, forKey: "feelslike_f")
        defaults.set(region, forKey: "region")
        defaults.set(country, forKey: "country")
    }

}

