//
//  SavedCitiesScreen.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import SwiftUI

struct SavedCitiesScreen: View {

    @StateObject private var viewModel = SavedCitiesViewModel()

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()

            if viewModel.savedCities.isEmpty {
                Text(Constants.SavedCities.noSavedCitiesText)
                    .foregroundColor(.gray)
                    .fontWeight(.bold)
            } else {
                List {
                    ForEach(viewModel.savedCities) { city in
                        // Each row is a link to the detail screen.
                        NavigationLink(destination: CityDetailScreen(city: mapSavedCityToCity(savedCity: city))) {
                            VStack(alignment: .leading) {
                                Text(city.name ?? Constants.SavedCities.unknownCityErrorText)
                                    .font(.headline)
                                Text("\(city.region ?? ""), \(city.country ?? "")")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .onDelete(perform: viewModel.deleteCity)
                }
                .listStyle(.plain)
            }
        }
        .navigationTitle(Constants.SavedCities.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchSavedCities()
        }
    }

    // map 'SavedCity' to 'City' object for the detail screen.
    private func mapSavedCityToCity(savedCity: SavedCity) -> City {
        return City(
            id: Int(savedCity.id),
            name: savedCity.name ?? "",
            country: savedCity.country ?? "",
            region: savedCity.region ?? "",
            latitude: savedCity.latitude,
            longitude: savedCity.longitude
        )
    }
}

#Preview {
    NavigationView {
        SavedCitiesScreen()
    }
}
