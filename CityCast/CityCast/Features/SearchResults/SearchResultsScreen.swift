//
//  SearchResultsScreen.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import SwiftUI

import SwiftUI

struct SearchResultsScreen: View {
    
    @StateObject private var searchViewModel: SearchResultsViewModel
    
    init(query: String) {
        _searchViewModel = StateObject(wrappedValue: SearchResultsViewModel(query: query))
    }
    
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            switch searchViewModel.state {
            case .idle, .loading:
                ProgressView()
                
            case .success:
              
                if searchViewModel.cities.isEmpty {
                    Text(Constants.SearchResults.noResultsFound(for: searchViewModel.query))
                        .fontWeight(.bold)

                } else {
                    
                    VStack {
                        List(searchViewModel.cities) { city in
                            NavigationLink(destination: CityDetailScreen(city: city)) {
                                VStack(alignment: .leading) {
                                    Text(city.name)
                                        .font(.headline)
                                    Text("\(city.region), \(city.country)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 4)
                            }
                            .padding(.vertical, 4)
                        }
                        .listStyle(.plain)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                
            case .error(let message):
                Text(message)
                    .foregroundColor(.red)
                    .padding()
                    .fontWeight(.bold)
            }
        }
        .navigationTitle(Constants.SearchResults.resultFor(city: searchViewModel.query))
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await searchViewModel.search()
        }
    }
}

#Preview {
    NavigationView {
        SearchResultsScreen(query: "Paris")
    }
}
