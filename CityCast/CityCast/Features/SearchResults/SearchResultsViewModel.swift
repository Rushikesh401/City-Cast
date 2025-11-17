//
//  SearchResultsViewModel.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation
import Combine

enum SearchState {
    case idle
    case loading
    case success
    case error(message: String)
}

@MainActor // to ensure all UI updates happen on main thread
class SearchResultsViewModel: ObservableObject {

    @Published private(set) var cities: [City] = []
    @Published private(set) var state: SearchState = .idle

    private let apiService: APIService
    let query: String

    init(query: String, apiService: APIService = .shared) {
        self.query = query
        self.apiService = apiService
    }

    func search() async {
        AppLogger.shared.log("Searching for cities with query: '\(query)'")
        state = .loading

        do {
            let fetchedCities = try await apiService.fetchCities(named: query)
            self.cities = fetchedCities
            self.state = .success
            
            AppLogger.shared.log("Successfully fetched \(fetchedCities.count) cities.")
            
        } catch {
            AppLogger.shared.log("Error fetching cities: \(error.localizedDescription)")
            self.state = .error(message: "Failed to fetch cities. Please try again.")
        }
    }
}
