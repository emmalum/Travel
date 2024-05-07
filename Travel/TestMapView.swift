//
//  TestMapView.swift
//  Travel
//
//  Created by Joshua Isaraela on 7/5/2024.
//

import SwiftUI
import MapKit

//MARK: VIEW
struct TestMapView: View {
    
    @StateObject var viewModel = MapViewModel()
    
    var body: some View {
        VStack {
            MapReader { mapReader in
                Map(position: $viewModel.mapCameraPosition) {
                    ForEach(viewModel.mapAnnotations) { mapAnnotation in
                        Annotation(mapAnnotation.locality, coordinate: mapAnnotation.coordinates) {
                            MapPin()
                                .onLongPressGesture(minimumDuration: 0.1) {
                                    viewModel.annotationPressed(mapAnnotation: mapAnnotation)
                                }
                        }
                    }
                }
                .mapStyle(.standard)
                .onTapGesture { tap in
                    if let tapCoordinate = mapReader.convert(tap, from: .local) {
                        Task {
                            await viewModel.addMapAnnotation(coordinate: tapCoordinate)
                        }
                        print("Continuing program")
                        
                    }
                }
            }
            
        }
    }
}

#Preview {
    TestMapView()
}
