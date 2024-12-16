//
//  SearchResultsView.swift
//  Nooro03
//
//  Created by MAC PAN on 12/14/24.
//

import Foundation
import SwiftUI

struct SearchResultsView: View {
    
    @ObservedObject var searchResultsViewModel = SearchResultViewModel()
    
    @State var searchText: String = ""
    
    var body: some View {
        
        VStack {
            HStack {
                TextField("Search", text: $searchText)
                    .onChange(of: searchText) { value in
                        if !value.isEmpty && value.count >= 2 {
                            searchResultsViewModel.citySearch(term: value)
                            searchResultsViewModel.shouldShowSearchResults = true
                            searchResultsViewModel.shouldShowCityWeather = false
                        } else {
                            searchResultsViewModel.weatherForCities.removeAll()
                            searchResultsViewModel.shouldShowSearchResults = false
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
            
            if let errorMsg = searchResultsViewModel.errorMessage {
                Text(errorMsg)
            } else if searchResultsViewModel.shouldShowSearchResults == true {
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
                            searchResultsViewModel.shouldShowCityWeather = true
                            searchResultsViewModel.shouldShowSearchResults = false
                            searchResultsViewModel.savedCity = CityWeatherViewModel(city: weather.city,
                                                                  temp_f: weather.temp_f,
                                                                  condition_text: weather.condition_text,
                                                                  condition_icon: weather.condition_icon,
                                                                  humidity: weather.humidity,
                                                                  uv: weather.uv,
                                                                  feelslike_f: weather.feelslike_f,
                                                                  region: weather.region,
                                                                  country: weather.country)

                        }
                        .padding()
                        .frame(minWidth: 0, alignment: .topLeading)
                        .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                        .cornerRadius(15)
                    }
                    .listStyle(.plain)
                } else if searchResultsViewModel.shouldShowCityWeather == true {
                    if let weatherForCity = searchResultsViewModel.savedCity {
                        CityWeatherView(weatherViewModel: weatherForCity)
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("No City Selected")
                            .font(.title)
                            .frame(alignment: .center)
                        Text("Please Search For A City")
                            .font(.subheadline)
                            .frame(alignment: .center)
                        Spacer()
                    }
                    
                }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)

    }
}
