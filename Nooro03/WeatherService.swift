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
    func loadData(searchTerm: String) -> AnyPublisher<[WeatherModel], Error>
}

class WeatherService: WeatherFetchable {

    private let baseURL = URL(string: "http://api.weatherapi.com/v1")!
    
    func loadData(searchTerm: String) -> AnyPublisher<[WeatherModel], Error> {
        loadCities(citySearch: searchTerm)
            .flatMap(loadWeatherForMultipleCities)
            .replaceEmpty(with: [])
            .eraseToAnyPublisher()
    }
    
    private func loadCities(citySearch: String) -> AnyPublisher<[CitySearchAPIResponse], Error> {
        let searchString = citySearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let apiUrl = URL(string: "\(baseURL)/search.json?key=\(APIKEY.key)&q=\(searchString)") else {
            fatalError("Invalid URL")
        }

        return URLSession.shared.dataTaskPublisher(for: apiUrl)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                
                let decoder = JSONDecoder()
                guard let cityList = try? decoder.decode([CitySearchAPIResponse].self, from: result.data) else {
                    throw URLError(.badServerResponse)
                }
                return cityList
            }
            .eraseToAnyPublisher()
    }
    
    private func loadWeatherForMultipleCities(cities: [CitySearchAPIResponse]) -> AnyPublisher<[WeatherModel], Error> {
        let publishers: [AnyPublisher<WeatherModel, Error>] = cities.map(loadWeather)
        return Publishers.MergeMany(publishers)
            .collect()
            .eraseToAnyPublisher()
    }
    
    private func loadWeather(city: CitySearchAPIResponse) -> AnyPublisher<WeatherModel, Error> {
        guard let apiUrl = URL(string: "\(baseURL)/current.json?key=\(APIKEY.key)&q=id:\(city.id)") else {
            fatalError("Invalid URL")
        }
        return URLSession.shared.dataTaskPublisher(for: apiUrl)
            .tryMap { result in
                guard let response = result.response as? HTTPURLResponse, response.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }

                let decoder = JSONDecoder()
                guard let weather = try? decoder.decode(WeatherAPIResponse.self, from: result.data) else {
                    throw URLError(.badServerResponse)
                }

                return WeatherModel(data: weather, id: city.id)
            }
            .eraseToAnyPublisher()
    }

}

struct CitySearchAPIResponse: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let url: String
}

