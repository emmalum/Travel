//
//  PinDetails.swift
//  Travel
//
//  Created by Joshua Isaraela on 9/5/2024.
//

import SwiftUI

struct PinDetails: View {
    
    @State var stationName: String
    @State var address: String
    @State var interchange: Int
    @State var platforms: Int
    @State var wheelchairAccess: Bool
    
    init(name: String, address: String, interchange: Int, platform: Int, wheelchair: Bool){
        self.stationName = name
        self.address = address
        self.interchange = interchange
        self.platforms = platform
        self.wheelchairAccess = wheelchair
    }
    
    var body: some View {
        VStack{
            Text("Station name: \(stationName)")
            Text("Address: \(address)")
            Text("Intergange: \(platforms)")
            Text("No. Platforms: \(interchange)")
            Text("Wheelchair Access: \(wheelchairAccess)")
        }
    }
}

#Preview {
    PinDetails(name: "Station 6", address: "Somewhere", interchange: 1, platform: 2, wheelchair: false)
}
