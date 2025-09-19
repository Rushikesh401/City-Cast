//
//  RecentSearchesListView.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import SwiftUI

import SwiftUI

struct RecentSearchesListView: View {
    let searches: [String]

    var body: some View {
        Text(Constants.Home.recentsTitle)
            .font(.headline)
            .padding([.leading, .trailing, .bottom])

        List {
            if searches.isEmpty {
                Text(Constants.Home.emptyRecentsMessage)
                    .foregroundColor(.gray)
            } else {
                ForEach(searches, id: \.self) { search in
                    Text(search)
                        .font(.body)
                }
            }
        }
        .listStyle(.plain)
        .cornerRadius(10)
        .background(Color.clear)
        .padding(.horizontal)
    }
}

#Preview {
    RecentSearchesListView(searches: ["London", "New York", "Paris"])
}
