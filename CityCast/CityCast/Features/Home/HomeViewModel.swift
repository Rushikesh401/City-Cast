//
//  HomeViewModel.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation

class HomeViewModel: ObservableObject {

    @Published var recentSearches: [String] = []

    private let persistenceService: PersistenceService

    init(persistenceService: PersistenceService = .shared) {
        self.persistenceService = persistenceService
        loadRecentSearches()
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
}
