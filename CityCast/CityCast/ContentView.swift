//
//  ContentView.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 19/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            HomeScreen()
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
