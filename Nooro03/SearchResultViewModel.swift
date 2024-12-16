//
//  SearchResultsViewModel.swift
//  Nooro03
//
//  Created by MAC PAN on 12/13/24.
//

import Foundation
import Combine

protocol SearchResultViewModelInterface {
    func citySearch(term: String)
}

//JH: do i need this?
@MainActor
class SearchResultViewModel: ObservableObject {
    
    var weatherService: WeatherFetchable
    @Published var weatherForCities: [WeatherModel] = []
    private var bag = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetchable) {
        weatherService = weatherFetcher
        checkUserDefaults()
    }
    
    init() {
        weatherService = WeatherService()
        checkUserDefaults()
    }
    
    @Published var savedCity: CityWeatherViewModel?
    @Published var shouldShowSearchResults: Bool?
    @Published var shouldShowCityWeather: Bool?
    @Published var errorMessage: String?
    
    func checkUserDefaults() {
        let defaults = UserDefaults.standard
        let scity = defaults.string(forKey: "city")
        let stemp_f = defaults.float(forKey: "temp_f")
        let scondition_text = defaults.string(forKey: "condition_text")
        let scondition_icon = defaults.string(forKey: "condition_icon")
        let shumidity = defaults.integer(forKey: "humidity")
        let suv = defaults.float(forKey: "uv")
        let sfeelslike_f = defaults.float(forKey: "feelslike_f")
        let sregion = defaults.string(forKey: "region")
        let scountry = defaults.string(forKey: "country")

        if (scity != nil && scity != nil && scondition_icon != nil) {
            shouldShowSearchResults = false
            shouldShowCityWeather = true
            self.savedCity = CityWeatherViewModel(city: scity ?? "",
                                                  temp_f: stemp_f,
                                                  condition_text: scondition_text ?? "",
                                                  condition_icon: scondition_icon ?? "",
                                                  humidity: shumidity,
                                                  uv: suv,
                                                  feelslike_f: sfeelslike_f,
                                                  region: sregion ?? "",
                                                  country: scountry ?? "")
        } else {
            shouldShowSearchResults = true
            shouldShowCityWeather = false
        }
    }
    
}

extension SearchResultViewModel: SearchResultViewModelInterface {
    
    func citySearch(term: String) {
        weatherService.loadData(searchTerm: term)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                
                switch completion {
                case .finished:
                    print("Finished something")
                    self?.errorMessage = nil
                    break
                case .failure(let error):
                    print("Failed somwwhere")
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] multiCityWeather in
                print("receive value multi city data")
                print(multiCityWeather)
                print(multiCityWeather)
                self?.weatherForCities = multiCityWeather
            })
            .store(in: &bag)
        
    }
}
