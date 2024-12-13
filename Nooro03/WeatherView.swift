//
//  WeatherView.swift
//  Nooro03
//
//  Created by MAC PAN on 12/12/24.
//

import SwiftUI

struct WeatherView: View {
    @State private var city: String = ""

    @ObservedObject var weatherViewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            TextField("Enter city", text: $city, onCommit: {
                weatherViewModel.getWeatherForCity(city: city)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            
            if let weather = weatherViewModel {
                Text("Weather in \(weather.city)")
                    .font(.title)
                    .padding()
                
                Text("Temperature: \(weather.temp_f) °F")
                    .font(.headline)
                    .padding()
                
                Text(weather.condition_text)
                    .font(.subheadline)
            }
        }
        .padding()
    }
}
