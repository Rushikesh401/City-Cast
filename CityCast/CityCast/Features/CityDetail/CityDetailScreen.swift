//
//  CityDetailScreen.swift
//  CityCast
//
//  Created by Rushikesh Suradkar on 20/09/25.
//

import SwiftUI
import MapKit

struct CityDetailScreen: View {
    
    @StateObject private var viewModel: CityDetailViewModel
    @State private var mapRegion: MKCoordinateRegion
    
    init(city: City) {
        _viewModel = StateObject(wrappedValue: CityDetailViewModel(city: city))
        
        _mapRegion = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: city.latitude, longitude: city.longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1) // This is the zoom level
        ))
    }
    
    //let city: City
    var body: some View {
        ZStack {
            Map(coordinateRegion: $mapRegion)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 15) {
                    if viewModel.state == .loading {
                        ProgressView()
                            .frame(height: 250)
                    } else {
                        Text(viewModel.city.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Image(systemName: viewModel.weatherIconName)
                            .renderingMode(.original)
                            .font(.system(size: 80))
                        
                        Text(viewModel.temperature)
                            .font(.system(size: 50, weight: .light))
                        
                        Text(viewModel.weatherDescription)
                            .font(.headline)
                        
                        // OFFLINE WARNING MESSAGE
                        if viewModel.isShowingOfflineData {
                            Text("You are viewing old data. Connect to the internet for the latest weather.")
                                .font(.caption)
                                .foregroundColor(.orange)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        
                        // Save/Remove City Button
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

                        .disabled(viewModel.isShowingOfflineData && !viewModel.isSaved)
                    }
                }
                .padding()
                .padding(.bottom)
                .background(.thinMaterial)
                .cornerRadius(20)
                .padding(.horizontal)
            }
        }
        .navigationTitle("Weather Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchWeather()
        }
    }
}

#Preview {
    NavigationView {
        let sampleCity = City(id: 1, name: "Mumbai", country: "India", region: "Maharashtra", latitude: 19.07, longitude: 72.87)
        CityDetailScreen(city: sampleCity)
    }
}
