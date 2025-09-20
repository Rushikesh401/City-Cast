//
//  CityDetailScreen.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import SwiftUI

struct CityDetailScreen: View {

    @StateObject private var viewModel: CityDetailViewModel

    init(city: City) {
        _viewModel = StateObject(wrappedValue: CityDetailViewModel(city: city))
    }
    
    //let city: City

    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            
            switch viewModel.state {
            case .loading:
                ProgressView()
                
            case .success, .error:
                VStack(spacing: 20) {
                    Text(viewModel.city.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Image(systemName: viewModel.weatherIconName)
                        .renderingMode(.original)
                        .font(.system(size: 120))
                    
                    Text(viewModel.temperature)
                        .font(.system(size: 70, weight: .bold))
                    
                    Text(viewModel.weatherDescription)
                        .font(.headline)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                    
                    if case .error(let message) = viewModel.state {
                        Text(message)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // Save City Button
                    Button(action: {
                        viewModel.toggleSave()
                    }) {
                        
                        Label(viewModel.isSaved ? "Remove City" : "Save City",
                              systemImage: viewModel.isSaved ? "trash.circle.fill" : "plus.circle.fill")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(viewModel.isSaved ? Color.red : Color.blue)
                        .cornerRadius(12)
                    }
                    .padding()
                    
                }
                .padding()
            }
        }
        .navigationTitle("Weather Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchWeather()
        }
        .onAppear {
            viewModel.checkIfCityIsSaved()
        }
    }
}

#Preview {
    NavigationView {
        let sampleCity = City(id: 1, name: "Mumbai", country: "India", region: "Maharashtra", latitude: 19.07, longitude: 72.87)
        CityDetailScreen(city: sampleCity)
    }
}
