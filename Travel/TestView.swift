//
//  TestView.swift
//  Travel
//
//  Created by Emma Lum on 10/5/2024.
//

import SwiftUI

struct TestView: View {
    
    @State var transitAPI: TrainTransitAPI = TrainTransitAPI()
    @State var transitParams: TripAPIParams = TripAPIParams(date: Date(), origin: "", destination: "", type_destination: "")
    @State private var t9NorthernLineStations: [String] = []
//    @State var refresh: Bool = false
    
    var body: some View {
        VStack {
            ScrollView(.vertical){
                if let tripData = transitAPI.currentTransitRequest {
                  
                    ForEach(0..<tripData.journeys.count, id:\.self) {i in
                        if tripData.journeys[i].legs.first(where: { $0.transportation?.number == "T9 Northern Line" }) != nil {
                            Spacer()
                            
                            ForEach(t9NorthernLineStations, id: \.self) { station in
                                            Text(station)
                                        }
                            }
                        }
                        
                    }
                }
            }
            .onAppear {
                         if let tripData = transitAPI.currentTransitRequest {
                             // Filter legs to include only the T9 Northern Line
                             let t9Legs = tripData.journeys.flatMap { $0.legs }
                                 .filter { $0.transportation?.number == "T9 Northern Line" }
        
                             t9NorthernLineStations = Array(Set(t9Legs.compactMap { $0.origin?.name }))
                         }
        }
        .padding()
        
    }
}


#Preview {
    TestView()
}
