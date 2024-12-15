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
    @State var searchText: String = ""
    @ObservedObject var cityListViewModel = CityListViewModel()
    //JH: do i need @State?
    @State var shouldShowSearchResults = false
    
    @State var userSelectedCity = false
    
    var body: some View {
        
        TextField("Search", text: $searchText)
            .onChange(of: searchText) { value in
                if !value.isEmpty && value.count > 3 {
                    print("should show city list")
                    cityListViewModel.citySearch(term: value)
                    shouldShowSearchResults = true
                } else {
                    print("should not sow city list")
                    cityListViewModel.weatherForCities.removeAll()
                    shouldShowSearchResults = false
                }
            }
        
        

        if shouldShowSearchResults {
            List(cityListViewModel.weatherForCities, id: \.id) { weather in
                HStack {
                    Text(weather.city)
                    AsyncImage(url: URL(string: "https:\(weather.condition_icon)")!)
                }
                .onTapGesture {
                    print("user tapped city row")
                    userSelectedCity = true
                    shouldShowSearchResults = false
                }
            }
            .listStyle(.plain)
        } else if userSelectedCity {
            WeatherView()
        }


    }
}
