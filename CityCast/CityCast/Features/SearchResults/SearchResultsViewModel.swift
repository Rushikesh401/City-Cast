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
    private let query: String

    init(query: String, apiService: APIService = .shared) {
        self.query = query
        self.apiService = apiService
    }

    func search() async {
        state = .loading

        do {
            let fetchedCities = try await apiService.fetchCities(named: query)
            self.cities = fetchedCities
            self.state = .success
        } catch {
            self.state = .error(message: "Failed to fetch cities. Please try again.")
        }
    }
}
