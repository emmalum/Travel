//
//  MapPin.swift
//  Travel
//
//  Created by Joshua Isaraela on 7/5/2024.
//

import SwiftUI

// Pin UI that will be shown on the MapView.
struct MapPin: View {
    var body: some View {
        VStack {
            Image(systemName: "tram.fill")
                .padding()
                .background(.red)
                .foregroundStyle(.white)
                .clipShape(Circle())
            Image(systemName: "triangle.fill")
                .rotationEffect(.degrees(180))
                .offset(y: -10)
                .foregroundStyle(.red)
        }
    }
}


#Preview {
    MapPin()
}
