//
//  WeatherView.swift
//  Nooro03
//
//  Created by MAC PAN on 12/12/24.
//

import SwiftUI

struct CityWeatherView: View {
    @State private var weatherViewModel: CityWeatherViewModel
    
    init(weatherViewModel: CityWeatherViewModel) {
        self.weatherViewModel = weatherViewModel
    }
    
    var body: some View {
        VStack (alignment: .center){
            
            if let weather = weatherViewModel {
                
                AsyncImage(url: URL(string: "https:\(weather.condition_icon)")!) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 123, height: 123, alignment: .center)
                
                HStack {
                    Text(weather.city)
                        .font(.title)
                        .padding()
                    Image("Vector")
                }
            
                HStack {
                    HStack(alignment: .top) {
                        Text(weather.temp_f)
                            .frame(alignment: .center)
                            .font(.system(size: 60, weight: .semibold))
                        Image("degree")
                            .frame(width: 21, height:21, alignment: .center)
                            .padding(EdgeInsets(top: 15.0, leading: 0.0, bottom: 0.0, trailing: 0.0))
                    }
                }
                
                HStack (alignment: .center) {
                    VStack(alignment: .center) {
                        Text("HUMDITY")
                            .frame(alignment: .center)
                            .font(.system(size: 8))
                            .foregroundColor(.gray)
                        Text("\(weather.humidity)%")
                            .padding(EdgeInsets(top: 0.5, leading: 0.0, bottom: 0.0, trailing: 0.0))
                            .frame(alignment: .center)
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 154 / 255, green: 154 / 255, blue: 154 / 255))
                    }
                    Spacer()
                    VStack(alignment: .center) {
                        Text("UV")
                            .frame(alignment: .center)
                            .font(.system(size: 8))
                            .foregroundColor(.gray)
                        Text(weather.uv)
                            .padding(EdgeInsets(top: 0.5, leading: 0.0, bottom: 0.0, trailing: 0.0))
                            .frame(alignment: .center)
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 154 / 255, green: 154 / 255, blue: 154 / 255))
                            
                    }
                    Spacer()
                    VStack(alignment: .center) {
                        Text("FEELS LIKE")
                            .frame(alignment: .center)
                            .font(.system(size: 8))
                            .foregroundColor(.gray)
                        Text("\(weather.feelslike_f)°")
                            .padding(EdgeInsets(top: 0.5, leading: 0.0, bottom: 0.0, trailing: 0.0))
                            .frame(alignment: .center)
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 154 / 255, green: 154 / 255, blue: 154 / 255))
                        
                    }
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 46, alignment: .center)
                .background(Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255))
                .cornerRadius(15)
                .padding()
            }
        }
        .padding(EdgeInsets(top: 50.0, leading: 25.0, bottom: 0.0, trailing: 25.0))
    }
}
