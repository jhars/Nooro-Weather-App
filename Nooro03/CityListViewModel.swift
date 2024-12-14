//
//  SearchResultsViewModel.swift
//  Nooro03
//
//  Created by MAC PAN on 12/13/24.
//

import Foundation
import Combine

protocol CityListViewModelInterface {
    func citySearch(term: String)
}

//JH: do i need this?
@MainActor
class CityListViewModel: ObservableObject {
    
    var weatherService: WeatherFetchable
    @Published var cities: [CitySearchAPIResponse] = []
    @Published var weatherForCities: [WeatherModel] = []
    private var bag = Set<AnyCancellable>()
    
    init(weatherFetcher: WeatherFetchable) {
        weatherService = weatherFetcher
    }
    
    init() {
        weatherService = WeatherService()
    }
    
}

extension CityListViewModel: CityListViewModelInterface {
    
    func citySearch(term: String) {
        weatherService.loadData(searchTerm: term)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
//                self?.refreshView.update(isRefreshing: false)
                
                switch completion {
                case .finished:
                    print("Finished something")
                    break
                case .failure(let error):
                    print("Failed somwhere")
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
