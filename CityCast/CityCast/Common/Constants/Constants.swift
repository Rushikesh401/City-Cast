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
    }
    
    enum API {
        static let geoDBBaseURL = "https://wft-geo-db.p.rapidapi.com"
        static let rapidAPIHost = "wft-geo-db.p.rapidapi.com"
        
        static var rapidAPIKey: String {
            guard let key = Bundle.main.object(forInfoDictionaryKey: "RAPIDAPI_KEY") as? String else {
                fatalError("RAPIDAPI_KEY not found in Info.plist. Make sure you've set it up correctly in Keys.xcconfig.")
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
}
