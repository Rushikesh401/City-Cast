//
//  CityDetailViewModel.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation

enum DetailState : Equatable {
    case loading
    case success
    case error(message: String)
}

@MainActor
class CityDetailViewModel: ObservableObject {

    // MARK: - Published Properties for the View
    @Published var state: DetailState = .loading
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "Loading..."
    @Published var weatherIconName: String = "questionmark.circle.fill"
    @Published var isSaved: Bool = false
    @Published var isShowingOfflineData = false

    let city: City
    private let apiService: APIService
    private let coreDataManager: CoreDataManager
    
    private var latestWeatherResponse: WeatherResponse?
    
    init(city: City, apiService: APIService = .shared, coreDataManager: CoreDataManager = .shared) {
        self.city = city
        self.apiService = apiService
        self.coreDataManager = coreDataManager
    }

    func fetchWeather() async {
        state = .loading
        
        do {
            let weatherResponse = try await apiService.fetchWeather(for: city)
            self.latestWeatherResponse = weatherResponse
            
            isShowingOfflineData = false
            updateUI(with: weatherResponse)
            
            self.isSaved = coreDataManager.isCitySaved(id: city.id)
            
            if self.isSaved {
                let payload = CitySavePayload(city: city, weather: weatherResponse)
                coreDataManager.saveCity(payload: payload)
            }
            
            state = .success
            AppLogger.shared.log("Successfully fetched weather for \(city.name).")
            
        } catch {
            if let savedCity = coreDataManager.fetchSavedCity(id: city.id) {
                self.temperature = savedCity.lastTemp ?? "--"
                self.weatherDescription = savedCity.lastWeatherDescription ?? "No connection"
                if let iconCode = savedCity.lastWeatherIconCode {
                    self.weatherIconName = weatherIcon(for: iconCode)
                }
                
                self.state = .success
                self.isShowingOfflineData = true
                AppLogger.shared.log("Network failed. Displaying cached data for \(city.name).")
            } else {
                self.state = .error(message: "Could not load weather data.")
                AppLogger.shared.log("Error fetching weather: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateUI(with weatherResponse: WeatherResponse) {
        self.temperature = String(format: "%.0f°C", weatherResponse.main.temp)
        if let weatherDetail = weatherResponse.weather.first {
            self.weatherDescription = weatherDetail.description.capitalized
            self.weatherIconName = weatherIcon(for: weatherDetail.icon)
        }
    }
    
    func toggleSave() {
        if isSaved {
            coreDataManager.deleteCity(id: city.id)
        } else {
            guard let weather = latestWeatherResponse else {
                AppLogger.shared.log("Cannot save city without weather data.")
                return
            }
            let payload = CitySavePayload(city: city, weather: weather)
            coreDataManager.saveCity(payload: payload)
        }
        isSaved.toggle()
    }
}
