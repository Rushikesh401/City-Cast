//
//  SearchResultsScreen.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import SwiftUI

struct SearchResultsScreen: View {
    
    // Sample data to build the UI.
    let sampleCities: [City] = [
        City(id: 1, name: "Paris", country: "France", region: "Île-de-France", latitude: 48.85, longitude: 2.35),
        City(id: 2, name: "Paris", country: "United States", region: "Texas", latitude: 33.66, longitude: -95.55),
        City(id: 3, name: "Paris", country: "United States", region: "Tennessee", latitude: 36.30, longitude: -88.32)
    ]
    
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            VStack {
                if isLoading {
                    ProgressView()
                        .padding()
                }
                
                List(sampleCities) { city in
                    VStack(alignment: .leading) {
                        Text(city.name)
                            .font(.headline)
                        Text("\(city.region), \(city.country)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 4)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle("Results for 'Paris'")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationView {
        SearchResultsScreen()
    }
}
