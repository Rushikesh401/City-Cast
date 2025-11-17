//
//  City.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import Foundation

struct GeoDBResponse: Decodable {
    let data: [City]
}

struct City: Decodable, Identifiable, Hashable {
    let id: Int
    let name: String
    let country: String
    let region: String
    let latitude: Double
    let longitude: Double
}
