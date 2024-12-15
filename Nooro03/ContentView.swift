//
//  ContentView.swift
//  Nooro03
//
//  Created by MAC PAN on 12/12/24.
//

import SwiftUI

struct ContentView: View {
//    @State private var searchText: String = ""
//    @ObservedObject var cityListViewModel = CityListViewModel()
//    var searchResultsView = SearchResultsView()
//    var weatherView = WeatherView()
    
    var body: some View {
//        TextField("Search", text: searchResultsView.$searchText)
//            .onChange(of: searchResultsView.searchText) { value in
//                if !value.isEmpty && value.count > 3 {
//                    print("should show city list")
//                    searchResultsView.cityListViewModel.citySearch(term: value)
//                } else {
//                    print("should not sow city list")
//                    searchResultsView.cityListViewModel.weatherForCities.removeAll()
//                }
//            }
//        searchResultsView
        
        SearchResultsView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
