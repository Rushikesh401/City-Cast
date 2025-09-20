//
//  CoreDataManager.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    let container: NSPersistentContainer

    private init() {
        container = NSPersistentContainer(name: "CityCastDataModel")

        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                AppLogger.shared.log("FATAL ERROR: Core Data store failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveCity(from city: City) {
            let savedCity = SavedCity(context: container.viewContext)
            savedCity.id = Int64(city.id)
            savedCity.name = city.name
            savedCity.country = city.country
            savedCity.region = city.region
            savedCity.latitude = city.latitude
            savedCity.longitude = city.longitude
            savedCity.savedAt = Date()
            
            do {
                try container.viewContext.save()
                AppLogger.shared.log("Successfully saved city: \(city.name)")
            } catch {
                AppLogger.shared.log("Failed to save city: \(error)")
            }
        }
        
        func isCitySaved(id: Int) -> Bool {
            let request = SavedCity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                let count = try container.viewContext.count(for: request)
                return count > 0
            } catch {
                return false
            }
        }

        func fetchSavedCities() -> [SavedCity] {
            let request = SavedCity.fetchRequest()
            // Sort by the date saved, newest first.
            let sort = NSSortDescriptor(key: "savedAt", ascending: false)
            request.sortDescriptors = [sort]
            
            do {
                return try container.viewContext.fetch(request)
            } catch {
                return []
            }
        }

        func deleteCity(id: Int) {
            let request = SavedCity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %d", id)
            
            do {
                let cities = try container.viewContext.fetch(request)
                if let cityToDelete = cities.first {
                    container.viewContext.delete(cityToDelete)
                    try container.viewContext.save()
                    AppLogger.shared.log("Successfully deleted city with id: \(id)")
                }
            } catch {
                AppLogger.shared.log("Failed to delete city: \(error)")
            }
        }

}
