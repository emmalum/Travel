//
//  MapView.swift
//  Travel
//
//  Created by Joshua Isaraela on 4/5/2024.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    // These are the coordinates in the world
    // The coordinates for Sydney, Australia are:
    // Latitude: -33.865143
    // Longitude: 151.209900
    var coordinate: CLLocationCoordinate2D

    var body: some View {
        Map(position: .constant(.region(region)))
    }
    
    // Below is the region where the map should show
    // The center is the cordinates and the span is how much the map is zoomed in.
    // A larger latitudeDelta/longitudeDelta, the more zoomed out the map will be.
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    }
}

#Preview {
    MapView(coordinate: CLLocationCoordinate2D(latitude: -33.865143, longitude: 151.209900))
}
