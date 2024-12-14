//
//  CityWeatherDetailsModel.swift
//  Nooro03
//
//  Created by MAC PAN on 12/13/24.
//

import Foundation

struct CityWeatherDetilsModel: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let url: String
    let weather: WeatherModel
}
