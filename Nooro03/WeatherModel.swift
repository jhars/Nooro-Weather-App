//
//  WeatherModel.swift
//  Nooro03
//
//  Created by MAC PAN on 12/12/24.
//

import Foundation

// JH: Do we need codable? what is utility here?
struct WeatherModel: Codable {
    let city: String
    let temp_f: Float
    let condition_text: String
    let condition_icon: String
    let humidity: Int
    let uv: Float
    let feelslike_f: Float
    
    init() {
        city = ""
        temp_f = 0.0
        condition_text = ""
        condition_icon = ""
        humidity = 0
        uv = 0.0
        feelslike_f = 0.0
    }
    
}

extension WeatherModel {
    init(data: CityWeatherAPIResponse) {
        city = data.location.name
        temp_f = data.current.temp_f
        condition_text = data.current.condition.text
        condition_icon = data.current.condition.icon
        humidity = data.current.humidity
        uv = data.current.uv
        feelslike_f = data.current.feelslike_f
    }
}

//############ HOW TO HANDLE SOECIFIC MODEL FROM API #####################
struct CityWeatherAPIResponse: Codable {
    let location: Location
    let current: Current
    
    struct Current: Codable {
        let temp_f: Float
        let condition: Condition
        let humidity: Int
        let uv: Float
        let feelslike_f: Float
    }
    
    struct Condition: Codable {
        let text: String
        let icon: String
    }
    
    struct Location: Codable {
        let name: String
    }
}
