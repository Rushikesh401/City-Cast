//
//  HomeScreen.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import SwiftUI

struct HomeScreen: View {

    @State private var searchText: String = ""
    let sampleSearches: [String] = ["London", "Pune", "Mumbai", "New Delhi", "Bangalore"]

    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackground.ignoresSafeArea()

                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(text: $searchText)
                    RecentSearchesListView(searches: sampleSearches)
                }
            }
            .navigationTitle(Constants.Home.navigationTitle)
        }
    }
}

#Preview {
    HomeScreen()
}
