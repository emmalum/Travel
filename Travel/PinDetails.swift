//
//  PinDetails.swift
//  Travel
//
//  Created by Joshua Isaraela on 9/5/2024.
//

import SwiftUI

struct PinDetails: View {
    
    var stationName: String
    var stationAddress: String
    var platform: Int
    var interchange: Int
    var wheelChairAccess: Bool
    
    init(stationName: String, stationAddress: String, platform: Int, interchange: Int, wheelChairAccess: Bool){
        self.stationName = stationName
        self.stationAddress = stationAddress
        self.platform = platform
        self.interchange = interchange
        self.wheelChairAccess = wheelChairAccess
    }
    
    var body: some View {
        VStack{
            Text("Station name: \(stationName)")
            Text("Address: \(stationAddress)")
            Text("Intergange: \(platform)")
            Text("No. Platforms: \(interchange)")
            Text("Wheelchair Access: \(wheelChairAccess)")
        }
    }
}

#Preview {
    PinDetails(stationName: "Station 6", stationAddress: "Somewhere", platform: 1, interchange: 2, wheelChairAccess: false)
}
