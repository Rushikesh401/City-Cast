//
//  SearchBarView.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    var onSearch: () -> Void
    
    private var isSearchButtonEnabled: Bool {
        text.count >= 3
    }
    
    @State private var isUserTyping = false
    
    var body: some View {
        HStack {
            Image(systemName: Constants.Images.magnifyingglassIcon)
                .foregroundColor(.gray)
            
            TextField(Constants.Home.searchPlaceholder, text: $text)
                .focused($isFocused)
            
            Button(action: onSearch) {
                Text(Constants.Home.searchText)
            }
            .disabled(!isSearchButtonEnabled)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isFocused ? Color.black : Color(.systemGray4), lineWidth: 1)
        )
        .padding()
    }
}

#Preview {
    SearchBarView(text: .constant(""), isFocused: FocusState<Bool>().projectedValue, onSearch: {})
}
