//
//  APIService.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import Foundation

class APIService {

    static let shared = APIService()
    private let geoDBBaseURL = URL(string: Constants.API.geoDBBaseURL)!
    private let openWeatherBaseURL = URL(string: Constants.API.openWeatherBaseURL)!


    func fetch<T: Decodable>(_ type: T.Type, baseURL: URL, from endpoint: Endpoint) async throws -> T {
            var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
            components.path = endpoint.path
            components.queryItems = endpoint.queryItems

            guard let url = components.url else {
                AppLogger.shared.log("Invalid URL created from endpoint: \(endpoint)")
                throw APIError.invalidURL
            }
            
            AppLogger.shared.log("Requesting URL: \(url.absoluteString)")

            var request = URLRequest(url: url)
            request.httpMethod = endpoint.method
            request.allHTTPHeaderFields = endpoint.headers

            let (data, response) = try await URLSession.shared.data(for: request)
            
            AppLogger.shared.log("Network Response: \(String(data: data, encoding: .utf8) ?? "Could not decode")")

            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                AppLogger.shared.log("Invalid response. Status Code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
                throw APIError.invalidResponse
            }

            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                return responseObject
            } catch {
                AppLogger.shared.log("Failed to decode JSON: \(error)")
                throw APIError.decodingFailed(error)
            }
        }

    func fetchCities(named name: String) async throws -> [City] {
        let endpoint = Endpoint.fetchCities(named: name)
        let response: GeoDBResponse = try await fetch(GeoDBResponse.self, baseURL: self.geoDBBaseURL, from: endpoint)
        return response.data
    }
    
    func fetchWeather(for city: City) async throws -> WeatherResponse {
        let endpoint = Endpoint.fetchWeather(lat: city.latitude, lon: city.longitude)
        return try await fetch(WeatherResponse.self, baseURL: self.openWeatherBaseURL, from: endpoint)
    }
}
