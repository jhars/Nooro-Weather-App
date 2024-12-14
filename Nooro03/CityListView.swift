//
//  CityListView.swift
//  Nooro03
//
//  Created by MAC PAN on 12/13/24.
//

import SwiftUI

struct CityListView: View {
    @State private var searchText: String = ""
    @ObservedObject var cityListViewModel = CityListViewModel()
    
    var body: some View {
        NavigationStack {
            List(cityListViewModel.weatherForCities, id: \.id) { weather in
                NavigationLink(value: weather) {
                    HStack {
                        Text(weather.city)
                        AsyncImage(url: URL(string: "https:\(weather.condition_icon)")!)
                    }
                }
            }
            .listStyle(.plain)
            .searchable(text: $searchText, prompt: "Search Location")
            .onChange(of: searchText) { value in
                if !value.isEmpty && value.count > 3 {
                    print("should show city list")
                    cityListViewModel.citySearch(term: value)
                } else {
                    print("should not sow city list")
                    cityListViewModel.weatherForCities.removeAll()
                }
            }
            .navigationDestination(for: WeatherModel.self) { cityWeather in
                Text(cityWeather.condition_text)
                AsyncImage(url: URL(string: "https:\(cityWeather.condition_icon)")!)
            }
            
        }
    }
}
