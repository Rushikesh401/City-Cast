//
//  Endpoint.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
    var method: String = "GET"
    var headers: [String: String] = [:]
}

extension Endpoint {
    static func fetchCities(named name: String) -> Self {
        Endpoint(
            path: "/v1/geo/cities",
            queryItems: [
                URLQueryItem(name: "namePrefix", value: name),
                URLQueryItem(name: "limit", value: "5"),
                URLQueryItem(name: "sort", value: "-population")
            ],
            headers: [
                "X-RapidAPI-Key": Constants.API.rapidAPIKey,
                "X-RapidAPI-Host": Constants.API.rapidAPIHost
            ]
        )
    }
    
    static func fetchWeather(lat: Double, lon: Double) -> Self {
        Endpoint(
            path: "/data/2.5/weather",
            queryItems: [
                URLQueryItem(name: "lat", value: String(lat)),
                URLQueryItem(name: "lon", value: String(lon)),
                URLQueryItem(name: "appid", value: Constants.API.openWeatherAPIKey),
                URLQueryItem(name: "units", value: "metric")
            ]
        )
    }
    
    
}
