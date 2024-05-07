//
//  MapPin.swift
//  Travel
//
//  Created by Joshua Isaraela on 7/5/2024.
//

import SwiftUI

struct MapPin: View {
    var body: some View {
        VStack {
            Image(systemName: "mappin")
                .padding()
                .background(.orange)
                .foregroundStyle(.white)
                .clipShape(Circle())
            Image(systemName: "triangle.fill")
                .rotationEffect(.degrees(180))
                .offset(y: -8)
                .foregroundStyle(.orange)
        }
    }
}


#Preview {
    MapPin()
}
