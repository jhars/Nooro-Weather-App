//
//  WeatherService.swift
//  Nooro03
//
//  Created by MAC PAN on 12/13/24.
//

import Foundation
import Combine

private enum APIKEY {
    static let key = "61cb84c280d54060a42201805240912"
}

protocol WeatherFetchable {
    func fetchWeatherData(city: String) -> AnyPublisher<CityWeatherAPIResponse, Error>
}

class WeatherService: WeatherFetchable {
    
    private let baseURL = "http://api.weatherapi.com/v1/current.json"
    
    func fetchWeatherData(city: String) -> AnyPublisher<CityWeatherAPIResponse, Error> {
        let baseURL = "http://api.weatherapi.com/v1/current.json"
        guard let url = URL(string: "\(baseURL)?key=\(APIKEY.key)&q=\(city)") else {
            fatalError("Invalid URL")
        }
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap({ res in
                
                guard let response = res.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode <= 300 else {
                    throw URLError(.badURL)
                }
                
                let decoder = JSONDecoder()
                guard let weather = try? decoder.decode(CityWeatherAPIResponse.self, from: res.data) else {
                    throw URLError(.badServerResponse)
                }
                
                return weather
            })
            //JH: is this API call proper format?
            .eraseToAnyPublisher()
            
    }
}
