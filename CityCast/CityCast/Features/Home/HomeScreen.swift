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
//    let sampleSearches: [String] = ["London", "Pune", "Mumbai", "New Delhi", "Bangalore"]

    var body: some View {
        NavigationStack {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(text: $searchText) {
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
            .navigationTitle(Constants.Home.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $searchIsActive) {
                SearchResultsScreen(query: searchText)
            }
        }
    }
}

#Preview {
    HomeScreen()
}
