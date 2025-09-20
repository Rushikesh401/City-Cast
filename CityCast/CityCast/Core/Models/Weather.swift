//
//  Weather.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation

struct WeatherResponse : Decodable {
    let main: WeatherMain
    let weather: [WeatherDetail]
    let timezone: Int
}

struct WeatherMain : Decodable {
    let temp: Double
}

struct WeatherDetail : Decodable {
        let main: String
        let description: String
        let icon: String
}
