//
//  Constants.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import Foundation

enum Constants {
    enum Home {
        static let navigationTitle = "CityCast"
        static let searchPlaceholder = "Search for a city..."
        static let recentsTitle = "Recent Searches"
        static let emptyRecentsMessage = "Your recent searches will appear here."
        static let savedText = "Saved"
        static let searchText = "Search"
    }
    
    enum API {
        //MARK: GeoDB
        static let geoDBBaseURL = "https://wft-geo-db.p.rapidapi.com"
        static let rapidAPIHost = "wft-geo-db.p.rapidapi.com"
        
        static var rapidAPIKey: String {
            guard let key = Bundle.main.object(forInfoDictionaryKey: "RAPIDAPI_KEY") as? String else {
                fatalError("RAPIDAPI_KEY not found in Info.plist. Make sure you've set it up correctly in Keys.xcconfig.")
            }
            return key
        }
        
        //MARK: OpenWeatherMap
        static let openWeatherBaseURL = "https://api.openweathermap.org"
        
        static var openWeatherAPIKey: String {
            guard let key = Bundle.main.object(forInfoDictionaryKey: "OWM_KEY") as? String else {
                fatalError("OPENWEATHERMAP_API_KEY not found in Info.plist...")
            }
            return key
        }
    }
    
    enum Settings {
        static let showLogs = true
    }
    
    enum SearchResults {
        static func noResultsFound(for query: String) -> String {
            return "No cities found for '\(query)'."
        }
        
        static func resultFor(city: String) -> String {
            return "Results for \(city)"
        }
    }
    
    enum CityDetails {
        static let offlineWarningMessage = "You are viewing old data. Connect to the internet for the latest weather."
        static let removeCityText = "Remove City"
        static let saveCityText = "Save City"
        static let navigationTitle = "Weather Details"
    }
    
    enum Persistence {
        static let recentSearchesKey = "RecentSearches"
    }
    
    enum SavedCities {
        static let noSavedCitiesText = "You haven't saved any cities yet."
        static let unknownCityErrorText = "Unknown City"
        static let navigationTitle = "Saved Cities"
    }
    
    enum Images {
        static let locationIcon = "location.circle.fill"
        static let magnifyingglassIcon = "magnifyingglass"
        static let trashIcon = "trash.circle.fill"
        static let plusIcon = "plus.circle.fill"
    }
}
