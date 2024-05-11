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
    
    @State var detailsPopUp = false;
    @Namespace private var locationSpace;
    
    var body: some View {
        VStack {
            MapReader { mapReader in
                Map(position: $viewModel.mapCameraPosition, scope: locationSpace) {
                    
                    // For each pin, spawn them on the map:
                    ForEach(viewModel.pinArray) { pin in
                        Annotation(pin.locality, coordinate: pin.coordinates) {
                            
                            // Place the MapPin from the coordinates above.
                            // The locality is just a string that tells us about the name of the location.
                            // The locality appears below the pin on the map.
                            MapPin()
                            // When you press the pin for 0.1 seconds, the camera will zoom in.
                                .onLongPressGesture(minimumDuration: 0.1) {
                                    viewModel.annotationPressed(mapAnnotation: pin)
                                    detailsPopUp = true;
                                    print("Long Pressed")
                                }
                            
                            // If the pin is long pressed for 0.1 seconds, then show the details:
                            //if detailsPopUp {
                            //PinDetails(stationName: pin.locality, stationAddress: pin.address, platform: pin.platforms, interchange: pin.interchange, wheelChairAccess: pin.wheelchairAccess)
                            //}
                        }
                    }
                    
                    // For every pin detail, spawn them on the map.
                    ForEach(viewModel.detailsArray) { detail in
                        Annotation(detail.name, coordinate: detail.coordinates) {
                    
                            //If the pin is long press for 0.1 seconds, then show the details.
                            if detailsPopUp {
                                PinDetails(stationName: detail.name, stationAddress: detail.address, platform: detail.platforms, interchange: detail.interchange, wheelChairAccess: detail.wheelchairAccess)
                            }
                        }
                    }
                }
                .mapStyle(.standard)
                .mapScope(locationSpace)
                .overlay(alignment: .topTrailing){
                    VStack(spacing: 15){
                        MapCompass(scope: locationSpace)
                    }
                    .buttonBorderShape(.circle)
                    .padding()
                }
                
                // Probably can be changed for when we put in permanent pins.
                // This is for spawning the map pin in the place that the user has clicked
                .onTapGesture { tap in
                    if let tapCoordinate = mapReader.convert(tap, from: .local) {
                        Task {
                            await viewModel.addPin(coordinate: tapCoordinate)
                        }
                        print("Continuing program")
                        detailsPopUp = false;
                    }
                }
            }
            
        }
    }
}

#Preview {
    MapView()
}
