//
//  WeatherViewModel.swift
//  Nooro03
//
//  Created by MAC PAN on 12/12/24.
//

import Foundation
import Combine

private enum APIKEY { static let key = "61cb84c280d54060a42201805240912" }

protocol WeatherViewModelInterface {
    func getWeatherForCity(city: String)
}

class WeatherViewModel: ObservableObject {
    
    var weatherService: WeatherFetchable
    @Published private var weatherModel: WeatherModel
    private var bag = Set<AnyCancellable>()
    
//    @Published private(set) var isLoading: Bool = false
    
    // For Testability, is 'required' keyword required?
    init(weatherFetcher: WeatherFetchable) {
        weatherService = weatherFetcher
        weatherModel = WeatherModel()
    }
    
    init() {
        weatherService = WeatherService()
        weatherModel = WeatherModel()
    }
    
    var city: String { return weatherModel.city }
    
    var temp_f: String { return String(weatherModel.temp_f) }
    
    var condition_text: String { return String(weatherModel.condition_text) }
    
    var condition_icon: String { return String(weatherModel.condition_icon) }
    
    var humidity: String { return String(weatherModel.humidity) }
    
    var uv: String { return String(weatherModel.uv) }
    
    var feelslike_f: String { return String(weatherModel.feelslike_f) }
}

extension WeatherViewModel: WeatherViewModelInterface {
    
    func getWeatherForCity(city: String) {
        weatherService.fetchWeatherData(city: city)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] res in
            
//                defer { self?.isRefreshing = false }
            
                switch res {
                case .failure(let error):
                    print(error)
                default: break
                }
            
            } receiveValue: { [weak self] weather in
                self?.weatherModel = WeatherModel(data: weather)
            }
            .store(in: &bag)
    }

}
