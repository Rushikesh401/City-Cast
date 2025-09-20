//
//  CityDetailViewModel.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation

enum DetailState {
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

    let city: City
    private let apiService: APIService
    
    @Published var isSaved: Bool = false
    private let coreDataManager: CoreDataManager

    init(city: City, apiService: APIService = .shared, coreDataManager: CoreDataManager = .shared) {
        self.city = city
        self.apiService = apiService
        self.coreDataManager = coreDataManager
    }

    func fetchWeather() async {
        state = .loading

        do {
            let weatherResponse = try await apiService.fetchWeather(for: city)

            self.temperature = String(format: "%.0f°C", weatherResponse.main.temp)

            if let weatherDetail = weatherResponse.weather.first {
                self.weatherDescription = weatherDetail.description.capitalized
                self.weatherIconName = weatherIcon(for: weatherDetail.icon)
            }

            self.state = .success
            AppLogger.shared.log("Successfully fetched weather for \(city.name).")

        } catch {
            self.state = .error(message: "Could not load weather data.")
            AppLogger.shared.log("Error fetching weather: \(error.localizedDescription)")
        }
    }
    
    func checkIfCityIsSaved() {
        isSaved = coreDataManager.isCitySaved(id: city.id)
    }
    
    func toggleSave() {
        if isSaved {
            coreDataManager.deleteCity(id: city.id)
        } else {
            coreDataManager.saveCity(from: city)
        }
        isSaved.toggle()
    }
}
