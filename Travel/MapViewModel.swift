//
//  MapViewModel.swift
//  Travel
//
//  Created by Joshua Isaraela on 7/5/2024.
//

import SwiftUI
import MapKit


// Below is the pin object which will be placed in the "pinArray".
// The localitiy field is the name of the place that the pin is placed on.
// It stores the coordinates for the MapPin.
struct Pin: Identifiable {
    let id: String = UUID().uuidString
    let locality: String
    let coordinates: CLLocationCoordinate2D
}

class MapViewModel: ObservableObject {
    
    // The coordinates for Sydney, Australia are:
    // latitude: -33.8688
    // longitude: 151.2093
    
    let sydneyCoordinates: CLLocationCoordinate2D
    let geocoder = CLGeocoder()
    
    @Published var mapCameraPosition: MapCameraPosition
    @Published var pinArray: [Pin] = []
    
    init() {
        @State var transitAPI: TrainTransitAPI = TrainTransitAPI()
        @State var transitParams: TripAPIParams = TripAPIParams(date: Date(), origin: "", destination: "")
        @State var refresh: Bool = false
        
        if let tripData = transitAPI.currentTransitRequest {
            ForEach(0..<tripData.journeys.count, id:\.self) {i in
                ForEach(0..<tripData.journeys[i].legs.count, id:\.self) { j in
                    
                    Text(tripData.journeys[i].legs[j].transportation?.number ?? "Walk")
//                    print(tripData.journeys[i].legs[j])
                    
//                    var location = CLLocationCoordinate2D(latitude: Double(tripData.journeys[i].legs[j].origin?.coord[0]), longitude: Double(tripData.journeys[i].legs[j].origin?.coord[1]))
//                    addPin(location)
                }
            }
        }
        self.sydneyCoordinates = CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)
        self.mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: sydneyCoordinates, distance: 10000))
    }
    
    // This function will add a pin onto the map and store the object in the "pinArray".
    // Give this function a coordinate so the pin will be created there.
    func addPin(coordinate: CLLocationCoordinate2D) async {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        do {
            // The locality is set to the pin depending on what the location is.
            let placemarks = try await geocoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                let locality = placemark.locality ?? "Unknown"
                
                // Create and add the pin onto the map and list.
                let newPin = Pin(locality: locality, coordinates: coordinate)
                pinArray.append(newPin)
            }
        } catch let error {
            print("An error occured \(error.localizedDescription)")
        }
    }
    
    // This function just zooms in onto the specific pin on the map.
    // It is only called when pressing on the pin for about 0.1 seconds.
    func annotationPressed(mapAnnotation: Pin) {
        withAnimation(.easeIn) {
            self.mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: mapAnnotation.coordinates, distance: 5000))
        }
    }
    
}
