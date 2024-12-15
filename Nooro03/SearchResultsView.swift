//
//  SearchResultsView.swift
//  Nooro03
//
//  Created by MAC PAN on 12/14/24.
//

import Foundation

    //JH: may need this if i can't uptate the City List View
    // which needs to...
    //- Persist search bar after licking on city search result
    //- Dismiss current city as soon as user starts typing

import SwiftUI

struct SearchResultsView: View {
    
    @ObservedObject var searchResultsViewModel = SearchResultViewModel()
    
    @State var searchText: String = ""
    
    @State var shouldShowSearchResults = false
    
    @State var shouldShowCityWeather = false
    
    @State var selectedCityId: Int?
    
    var body: some View {
        
            VStack {
                HStack {
                    TextField("Search", text: $searchText)
                        .onChange(of: searchText) { value in
                            if !value.isEmpty && value.count > 3 {
                                print("should show city list")
                                searchResultsViewModel.citySearch(term: value)
                                shouldShowSearchResults = true
                                shouldShowCityWeather = false
                            } else {
                                print("should not sow city list")
                                searchResultsViewModel.weatherForCities.removeAll()
                                shouldShowSearchResults = false
                            }
                        }
                        .font(.body)
                    Image("search_24px")
                        .foregroundColor(.secondary)
                    
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46, alignment: .topLeading)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(15)
                .padding()

                
            
            if shouldShowSearchResults {
                List(searchResultsViewModel.weatherForCities, id: \.id) { weather in
                    HStack {
                        VStack (alignment: .leading) {
                            
                            Text("\(weather.city), \(weather.region)")
                                .font(.system(size: 20, weight: .semibold))
                                .frame(maxWidth: .none, alignment: .bottomLeading)
                            
                            HStack(alignment: .top) {
                                Text(String(Int(weather.temp_f)))
                                    .frame(alignment: .leading)
                                    .font(.system(size: 60, weight: .semibold))
                                Image("degree")
                                    .frame(alignment: .leading)
                                    .padding(EdgeInsets(top: 15.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                                Spacer()
                            }
                            Spacer()
                            
                        }
                        .frame(alignment: .leading)
                        
                        Spacer()
                        
//                        AsyncImage(url: URL(string: "https:\(weather.condition_icon)")!)
                        AsyncImage(url: URL(string: "https:\(weather.condition_icon)")!) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .padding(.trailing)
                        .frame(width: 83, height: 67, alignment: .trailing)
                    
                    }
                    .onTapGesture {
                        print("user tapped city row")
                        shouldShowCityWeather = true
                        shouldShowSearchResults = false
                        selectedCityId = weather.id
                    }
                    .padding()
                    .frame(minWidth: 0, alignment: .topLeading)
                    .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                    .cornerRadius(15)
//                    .padding()
                }
                .listStyle(.plain)
            } else if shouldShowCityWeather {
                if let weatherForCity = searchResultsViewModel.weatherForCities.first { $0.id == selectedCityId } {
                    CityWeatherView(weatherViewModel: CityWeatherViewModel(city: weatherForCity.city,
                                                                   temp_f: weatherForCity.temp_f,
                                                                   condition_text: weatherForCity.condition_text,
                                                                   condition_icon: weatherForCity.condition_icon,
                                                                   humidity: weatherForCity.humidity,
                                                                   uv: weatherForCity.uv,
                                                                   feelslike_f: weatherForCity.feelslike_f,
                                                                   region: weatherForCity.region,
                                                                    country: weatherForCity.country))
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)

    }
}
