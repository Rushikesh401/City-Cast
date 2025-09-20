//
//  HomeScreen.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import SwiftUI

struct HomeScreen: View {

    @StateObject private var homeViewModel = HomeViewModel()

    @State private var searchText: String = ""
    @State private var searchIsActive = false
    @FocusState private var isSearchFieldFocused: Bool

//    let sampleSearches: [String] = ["London", "Pune", "Mumbai", "New Delhi", "Bangalore"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(text: $searchText, isFocused: $isSearchFieldFocused) {
                        if !searchText.trimmingCharacters(in: .whitespaces).isEmpty {
                            homeViewModel.addSearch(term: searchText)
                            searchIsActive = true
                        }
                    }
                    
                    RecentSearchesListView(
                        searches: homeViewModel.recentSearches,
                        onResubmit: { term in
                            homeViewModel.resubmitSearch(term: term, isActive: &searchIsActive, searchText: &searchText)
                        },
                        onDelete: { offsets in
                            homeViewModel.deleteSearch(at: offsets)
                        }
                    )
                }
            }
            .onTapGesture {
                isSearchFieldFocused = false
            }
            .navigationTitle(Constants.Home.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $searchIsActive) {
                SearchResultsScreen(query: searchText)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SavedCitiesScreen()) {
                        Text("Saved")
                    }
                }
            }
            .onAppear{
                handleOnAppear()
            }
        }
    }
    
    private func handleOnAppear() {
        searchText = ""
    }
}

#Preview {
    HomeScreen()
}
