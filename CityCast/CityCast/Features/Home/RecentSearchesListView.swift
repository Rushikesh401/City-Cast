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
    
    var onResubmit: (String) -> Void
    var onDelete: (IndexSet) -> Void

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
                    Button(action: { onResubmit(search) }) {
                        Text(search)
                            .font(.body)
                            .foregroundColor(Color.primary)
                    }
                }
                .onDelete(perform: onDelete)
            }
        }
        .listStyle(.plain)
        .cornerRadius(10)
        .background(Color.clear)
        .padding(.horizontal)
    }
}

#Preview {
    RecentSearchesListView(
        searches: ["London", "New York", "Paris"],
        onResubmit: { term in
            print("Resubmit: \(term)")
        },
        onDelete: { offsets in
            print("Delete at: \(offsets)")
        }
    )
}
