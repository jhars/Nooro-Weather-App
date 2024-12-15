//
//  CityModel.swift
//  Nooro03
//
//  Created by MAC PAN on 12/13/24.
//

import Foundation

//Mirrors API respinse for searchable cities
struct CitySearchAPIResponse: Codable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let url: String
}
