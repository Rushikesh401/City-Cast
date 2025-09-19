//
//  SearchBarView.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    
    var onSearch: () -> Void
    
    private var isSearchButtonEnabled: Bool {
        text.count >= 3
    }
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(Constants.Home.searchPlaceholder, text: $text)
            
            Button(action: onSearch) {
                Text("Search")
            }
            .disabled(!isSearchButtonEnabled)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(.systemGray4), lineWidth: 1)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(text: .constant(""), onSearch: {})
}
