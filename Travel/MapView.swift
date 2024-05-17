//
//  MapView.swift
//  Travel
//
//  Created by Joshua Isaraela on 4/5/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @StateObject var viewModel = MapViewModel()
    
    @State var detailsPopUp = false
    @Namespace private var locationSpace
    
    var body: some View {
        NavigationView {
            ZStack {
                MapReader { mapReader in
                    Map(position: $viewModel.mapCameraPosition, scope: locationSpace) {
                        
                        // For each pin, spawn them on the map:
                        ForEach(viewModel.testPin) { pin in
                            Annotation(pin.locality, coordinate: pin.coordinates) {
                                MapPin()
                                // When you press the pin for 0.1 seconds, the camera will zoom in.
                                .onLongPressGesture(minimumDuration: 0.1) {
                                    viewModel.annotationPressed(mapAnnotation: pin)
                                    detailsPopUp = true
                                    print("Long Pressed")
                                }
                            }
                        }
                        
                        // For every pin detail, spawn them on the map.
                        ForEach(viewModel.testDetails) { detail in
                            Annotation(detail.name, coordinate: detail.coordinates) {
                                // If the pin is long pressed for 0.1 seconds, then show the details.
                                if detailsPopUp {
                                    PinDetails(stationName: detail.name, stationAddress: detail.address, platform: detail.platforms, interchange: detail.interchange, wheelChairAccess: detail.wheelchairAccess)
                                }
                            }
                        }
                    }
                    .mapStyle(.standard)
                    .mapScope(locationSpace)
                    .overlay(alignment: .topTrailing) {
                        VStack(spacing: 15) {
                            MapCompass(scope: locationSpace)
                        }
                        .buttonBorderShape(.circle)
                        .padding()
                    }
                    
                    // This is for spawning the map pin and its details in the place that the user has clicked
                    .onTapGesture { tap in
                        if let tapCoordinate = mapReader.convert(tap, from: .local) {
                            Task {
                                await viewModel.addPin(coordinate: tapCoordinate)
                                await viewModel.addDetails(coordinate: tapCoordinate, name: "Train station", address: "Sydney, NSW, Australia", interchange: 2, platforms: 2, wheelchair: true)
                            }
                            print("Continuing program")
                            detailsPopUp = false
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                // Overlay the button at the bottom over the map
                VStack {
                    Spacer()
                    NavigationLink(destination: TrainTripView()) {
                        Text("Go to Train Trips")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.bottom, 30)
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MapView()
}
