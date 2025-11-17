//
//  CoreDataManager.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import Foundation
import CoreData

struct CitySavePayload {
    let city: City
    let weather: WeatherResponse
}

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
    
    // MARK: - Core Data Operations

    func saveCity(payload: CitySavePayload) {
        // First, check if the city already exists to update it.
        let request = SavedCity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", payload.city.id)
        
        let cityToSave: SavedCity
        if let existingCity = try? container.viewContext.fetch(request).first {
            cityToSave = existingCity
        } else {
            cityToSave = SavedCity(context: container.viewContext)
            cityToSave.id = Int64(payload.city.id)
        }
        
        // city properties
        cityToSave.name = payload.city.name
        cityToSave.country = payload.city.country
        cityToSave.region = payload.city.region
        cityToSave.latitude = payload.city.latitude
        cityToSave.longitude = payload.city.longitude
        
        // weather properties
        cityToSave.lastTemp = String(format: "%.0f°C", payload.weather.main.temp)
        if let weatherDetail = payload.weather.weather.first {
            cityToSave.lastWeatherDescription = weatherDetail.description.capitalized
            cityToSave.lastWeatherIconCode = weatherDetail.icon
        }
        cityToSave.lastUpdatedAt = Date()
        cityToSave.savedAt = Date()
        
        do {
            try container.viewContext.save()
            AppLogger.shared.log("Successfully saved/updated city: \(payload.city.name)")
        } catch {
            AppLogger.shared.log("Failed to save/update city: \(error)")
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
    
    func fetchSavedCity(id: Int) -> SavedCity? {
        let request = SavedCity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            return try container.viewContext.fetch(request).first
        } catch {
            return nil
        }
    }

    func fetchSavedCities() -> [SavedCity] {
        let request = SavedCity.fetchRequest()
        let sort = NSSortDescriptor(key: "savedAt", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func deleteCity(id: Int) {
        if let cityToDelete = fetchSavedCity(id: id) {
            container.viewContext.delete(cityToDelete)
            do {
                try container.viewContext.save()
                AppLogger.shared.log("Successfully deleted city with id: \(id)")
            } catch {
                AppLogger.shared.log("Failed to save context after deleting city: \(error)")
            }
        }
    }
}
