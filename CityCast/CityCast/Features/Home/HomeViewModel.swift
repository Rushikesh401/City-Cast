//
//  HomeViewModel.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation
import CoreLocation
import Combine

class HomeViewModel: ObservableObject {

    @Published var recentSearches: [String] = []

    private let persistenceService: PersistenceService
    
    @Published var userLocation: CLLocationCoordinate2D?

    private let locationManager = LocationManager()
    private var cancellables = Set<AnyCancellable>()

    init(persistenceService: PersistenceService = .shared) {
        self.persistenceService = persistenceService
        loadRecentSearches()
        
        locationManager.$location.sink { [weak self] location in
            self?.userLocation = location
        }.store(in: &cancellables)
    }

    func loadRecentSearches() {
        self.recentSearches = persistenceService.fetchRecentSearches()
    }

    func addSearch(term: String) {
        persistenceService.addRecentSearch(term: term)
        loadRecentSearches()
    }


    func deleteSearch(at offsets: IndexSet) {
        var currentSearches = persistenceService.fetchRecentSearches()
        currentSearches.remove(atOffsets: offsets)

        UserDefaults.standard.set(currentSearches, forKey: "RecentSearches")
        loadRecentSearches()
    }

    func resubmitSearch(term: String, isActive: inout Bool, searchText: inout String) {
        searchText = term
        addSearch(term: term)
        isActive = true
    }
    
    func requestLocation() {
        locationManager.requestLocation()
    }
}
