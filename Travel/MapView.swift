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
    
    var body: some View {
        VStack {
            MapReader { mapReader in
                Map(position: $viewModel.mapCameraPosition) {
                    
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
                            // When long pressing on a pin, load a pop up.
                                //.popover(isPresented: $detailsPopUp, arrowEdge: .bottom){
                                    //Text("Station Name:")
                                        //.frame(width: 150, height: 100)
                                    //Text("Address:")
                                        //.frame(width: 150, height: 100)
                                    //Text("Interchange:")
                                        //.frame(width: 150, height: 100)
                                    //Text("No. Platforms:")
                                        //.frame(width: 150, height: 100)
                                    //Text("Wheelchair Access:")
                                        //.frame(width: 150, height: 100)
                                //}
                            
                            if detailsPopUp {
                                PinDetails(stationName: pin.locality, stationAddress: pin.address, platform: pin.platforms, interchange: pin.interchange, wheelChairAccess: pin.wheelchairAccess)
                            }
                        }
                    }
                }
                .mapStyle(.standard)
                
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
