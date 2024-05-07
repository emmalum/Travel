//
//  MapViewModel.swift
//  Travel
//
//  Created by Joshua Isaraela on 7/5/2024.
//

import SwiftUI
import MapKit

//MARK: MODEL
struct MyMapAnnotation: Identifiable {
    let id: String = UUID().uuidString
    let locality: String
    let coordinates: CLLocationCoordinate2D
}


//MARK: VIEWMODEL
class MapViewModel: ObservableObject {
    
    let sydneyCoordinates: CLLocationCoordinate2D
    let geocoder = CLGeocoder()
    
    @Published var mapCameraPosition: MapCameraPosition
    @Published var mapAnnotations: [MyMapAnnotation] = []
    
    init() {
        self.sydneyCoordinates = CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)
        self.mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: sydneyCoordinates, distance: 10000))
    }
    
    func addMapAnnotation(coordinate: CLLocationCoordinate2D) async {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        do {
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let locality = placemark.locality ?? "Unknown"
                let mapAnnotation = MyMapAnnotation(locality: locality, coordinates: coordinate)
                mapAnnotations.append(mapAnnotation)
            }
        } catch let error {
            print("An error occured \(error.localizedDescription)")
        }
    }
    
    func annotationPressed(mapAnnotation: MyMapAnnotation) {
        withAnimation(.easeIn) {
            self.mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: mapAnnotation.coordinates, distance: 5000))
        }
    }
    
}
