//
//  PersistenceService.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation

class PersistenceService {

    static let shared = PersistenceService()
    private let userDefaults = UserDefaults.standard

  //  let recentsKey = "RecentSearches"

    private init() {}

    func fetchRecentSearches() -> [String] {
        return userDefaults.stringArray(forKey: Constants.Persistence.recentSearchesKey) ?? []
    }

    func addRecentSearch(term: String) {
        var currentTerms = fetchRecentSearches()

        // Remove the term if it already exists to avoid duplicates.
        currentTerms.removeAll { $0.lowercased() == term.lowercased() }

        // Add the new search to the beginning.
        currentTerms.insert(term, at: 0)

        let maxRecents = 10
        if currentTerms.count > maxRecents {
            currentTerms = Array(currentTerms.prefix(maxRecents))
        }

        userDefaults.set(currentTerms, forKey: Constants.Persistence.recentSearchesKey)
    }
}
