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
        NavigationView {
            List(cityListViewModel.weatherForCities, id: \.id) { city in
                HStack {
                    Text(city.city)
//                    Text(String(city.id))
                    //add icon image here
                }
            }.listStyle(.plain)
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
        }
    }
}
