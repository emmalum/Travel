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

// Below is the details object which will be placed in the "detailsArray".
// The coordinates are needed so that the details cooralate with the correct pin on the map
// the name, address, interchange, platforms and wheel chair access are part of the details that are shown.
struct Details: Identifiable {
    let id: String = UUID().uuidString
    let coordinates: CLLocationCoordinate2D
    let name: String
    let address: String
    let interchange: Int
    let platforms: Int
    let wheelchairAccess: Bool
}

class MapViewModel: ObservableObject {
    
    // The coordinates for Sydney, Australia are:
    // latitude: -33.8688
    // longitude: 151.2093
    
    let sydneyCoordinates: CLLocationCoordinate2D
    let geocoder = CLGeocoder()
    
    // We couldn't get the API working properly in time so we had to use our example lists below to simulate what would be happening if the API did work.
    @Published var mapCameraPosition: MapCameraPosition
    @Published var pinArray: [Pin] = []
    @Published var detailsArray: [Details] = []
    
    // Example pins for what the API would have done for us:
    @Published var testPin: [Pin] = [
        Pin(locality: "Newtown Station", coordinates: CLLocationCoordinate2D(latitude: -33.8980, longitude: 151.1796)),
        Pin(locality: "Macdonaldtown Station", coordinates: CLLocationCoordinate2D(latitude: -33.8968, longitude: 151.1863)),
        Pin(locality: "Redfern Station", coordinates: CLLocationCoordinate2D(latitude: -33.8922, longitude: 151.1990)),
        Pin(locality: "Sydney Central Station", coordinates: CLLocationCoordinate2D(latitude: -33.8832, longitude: 151.2070)),
        Pin(locality: "Town Hall Station", coordinates: CLLocationCoordinate2D(latitude: -33.8732, longitude: 151.2071)),
        Pin(locality: "Wynyard Station", coordinates: CLLocationCoordinate2D(latitude: -33.8660, longitude: 151.2056)),
        Pin(locality: "Circular Quay Station", coordinates: CLLocationCoordinate2D(latitude: -33.8612, longitude: 151.2107)),
        Pin(locality: "St James Station", coordinates: CLLocationCoordinate2D(latitude: -33.8707, longitude: 151.2105)),
        Pin(locality: "Museum Station", coordinates: CLLocationCoordinate2D(latitude: -33.8766, longitude: 151.2093)),
        Pin(locality: "Milsons Point Station", coordinates: CLLocationCoordinate2D(latitude: -33.8459, longitude: 151.2118)),
        Pin(locality: "North Sydney Station", coordinates: CLLocationCoordinate2D(latitude: -33.8412, longitude: 151.2074)),
        Pin(locality: "Waverton Station", coordinates: CLLocationCoordinate2D(latitude: -33.8376, longitude: 151.1974)),
        Pin(locality: "Wollstonecraft Station", coordinates: CLLocationCoordinate2D(latitude: -33.8319, longitude: 151.1918)),
        Pin(locality: "St Leonards Station", coordinates: CLLocationCoordinate2D(latitude: -33.8222, longitude: 151.1941)),
        Pin(locality: "Artarmon Station", coordinates: CLLocationCoordinate2D(latitude: -33.8088, longitude: 151.1851)),
        Pin(locality: "Chatswood Station", coordinates: CLLocationCoordinate2D(latitude: -33.7980, longitude: 151.1809))
    ]
    
    //Example details for what the API would have done for us:
    @Published var testDetails: [Details] = [
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8980, longitude: 151.1796), name: "Newtown Station", address: "Sydney, NSW, Australia", interchange: 3, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8968, longitude: 151.1863), name: "Macdonaldtown Station", address: "Sydney, NSW, Australia", interchange: 3, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8922, longitude: 151.1990), name: "Redfern Station", address: "Sydney, NSW, Australia", interchange: 6, platforms: 6, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8832, longitude: 151.2070), name: "Sydney Central Station", address: "Sydney, NSW, Australia", interchange: 6, platforms: 26, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8732, longitude: 151.2071), name: "Town Hall Station", address: "Sydney, NSW, Australia", interchange: 6, platforms: 6, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8660, longitude: 151.2056), name: "Wynyard Station", address: "Sydney, NSW, Australia", interchange: 5, platforms: 6, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8612, longitude: 151.2107), name: "Circular Quay Station", address: "Sydney, NSW, Australia", interchange: 3, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8707, longitude: 151.2105), name: "St James Station", address: "Sydney, NSW, Australia", interchange: 3, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8766, longitude: 151.2093), name: "Museum Station", address: "Sydney, NSW, Australia", interchange: 3, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8766, longitude: 151.2093), name: "Milsons Point Station", address: "Sydney, NSW, Australia", interchange: 2, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8412, longitude: 151.2074), name: "North Sydney Station", address: "Sydney, NSW, Australia", interchange: 2, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8376, longitude: 151.1974), name: "Waverton Station", address: "Sydney, NSW, Australia", interchange: 2, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8319, longitude: 151.1918), name: "Wollstonecraft Station", address: "Sydney, NSW, Australia", interchange: 2, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8222, longitude: 151.1941), name: "St Leonards Station", address: "Sydney, NSW, Australia", interchange: 2, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.8088, longitude: 151.1851), name: "Artarmon Station", address: "Sydney, NSW, Australia", interchange: 2, platforms: 2, wheelchairAccess: true),
        Details(coordinates: CLLocationCoordinate2D(latitude: -33.7980, longitude: 151.1809), name: "Chatswood Station", address: "Sydney, NSW, Australia", interchange: 3, platforms: 4, wheelchairAccess: true)
    ]
    
    init() {
        @State var transitAPI: TrainTransitAPI = TrainTransitAPI()
        @State var transitParams: TripAPIParams = TripAPIParams(date: Date(), origin: "", destination: "", type_destination: "")
        @State var refresh: Bool = false
        
        /* Below doesn't work for some reason :/
         
        if let tripData = transitAPI.currentTransitRequest {
            ForEach(0..<tripData.journeys.count, id:\.self) {i in
                ForEach(0..<tripData.journeys[i].legs.count, id:\.self) { j in
                    
                    //Text(tripData.journeys[i].legs[j].transportation?.number ?? "Walk")
                    //print(tripData.journeys[i].legs[j])
                    
                    var location = CLLocationCoordinate2D(latitude: Double(tripData.journeys[i].legs[j].destination?.coord[0]), longitude: Double(tripData.journeys[i].legs[j].destination?.coord[1]) ?? CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093))
                    
                    addPin(coordinate: location)
                    
                    var stationName: String = tripData.journeys[i].legs[j].origin?.name
                    var stationAddress: String = "Sydney, NSW, Australia"
                    var stationInterchanges: Int = tripData.journeys[i].interchanges
                    var stationPlatform: Int = 2
                    var wheelChairAccess: Bool = true
                    
                    addDetails(coordinate: location, name: stationName, address: stationAddress, interchange: stationInterchanges, platforms: stationPlatform, wheelchair: wheelChairAccess)
                }
            }
        }
        */
        
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
    
    
    // This function will add details from the pin onto the "detailsArray"
    // It works in the smae way as the addpin() function but for the information box.
    func addDetails(coordinate: CLLocationCoordinate2D, name: String, address: String, interchange: Int, platforms: Int, wheelchair: Bool) async {
        
        let newDetails = Details(coordinates: coordinate, name: name, address: address, interchange: interchange, platforms: platforms, wheelchairAccess: wheelchair)
        detailsArray.append(newDetails)
    }
     
    // This function just zooms in onto the specific pin on the map.
    // It is only called when pressing on the pin for about 0.1 seconds.
    // Tried to make it so that it only loads the details for the correstponding pin, but I'm unsure on how to do that :/
    func annotationPressed(mapAnnotation: Pin) {
        withAnimation(.easeIn) {
            self.mapCameraPosition = MapCameraPosition.camera(MapCamera(centerCoordinate: mapAnnotation.coordinates, distance: 5000))
        }
    }
    
}
