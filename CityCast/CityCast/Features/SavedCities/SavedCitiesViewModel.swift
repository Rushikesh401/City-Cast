//
//  SavedCitiesViewModel.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation
import CoreData

@MainActor
class SavedCitiesViewModel: ObservableObject {

    @Published var savedCities: [SavedCity] = []

    private let coreDataManager: CoreDataManager

    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
        fetchSavedCities()
    }

    func fetchSavedCities() {
        savedCities = coreDataManager.fetchSavedCities()
        AppLogger.shared.log("Fetched \(savedCities.count) saved cities.")
    }

    func deleteCity(at offsets: IndexSet) {
        guard let index = offsets.first else { return }
        let cityToDelete = savedCities[index]

        // Use its ID to delete it from Core Data
        coreDataManager.deleteCity(id: Int(cityToDelete.id))

        // Refresh the list
        fetchSavedCities()
    }
}
