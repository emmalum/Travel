//
//  ContentView.swift
//  Travel
//
//  Created by Emma Lum on 30/4/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var transitAPI: TrainTransitAPI = TrainTransitAPI()
    @State var transitParams: TripAPIParams = TripAPIParams(date: Date(), origin: "", destination: "")
    @State var refresh: Bool = false
    
    var body: some View {
        VStack {
        ScrollView(.vertical){
            if let tripData = transitAPI.currentTransitRequest {
                    ForEach(0..<tripData.journeys.count, id:\.self) {i in
                        
                        if let legs = tripData.journeys[i].legs.first(where: { $0.transportation?.number == "T9 Northern Line" }) {
                       
                        Spacer()
                        Text("Journey \(i)")
                            .fontWeight(.bold)
                            
                        
//                        ForEach(0..<tripData.journeys[i].legs.count, id:\.self) { j in
//                            Text(tripData.journeys[i].legs[j].transportation?.number ?? "Walk")
//                                .foregroundColor(Color("T1Colour"))
                            HStack{
                                Text("Origin:")
                                    .fontWeight(.semibold)
//                                Text(tripData.journeys[i].legs[j].origin?.name ?? "No Origin Name")
                                Text(legs.origin?.name ?? "No Origin Name")
                            }
                        
                            HStack{
                                Text("Destination:")
                                    .fontWeight(.semibold)
//                                Text(tripData.journeys[i].legs[j].destination?.name ?? "No Destination Name")
                                Text(legs.destination?.name ?? "No Destination Name")
                                
                            }
                            //                                Text("\(i), \(j)")
                            Spacer()
                        }
                    
                    }
                }
            }
            HStack {
                Button {
                    transitAPI.getData(currentDate: Date(), origin: "Berorwa Station", destination: "Roseville Station")
                } label: {
                    Text("Get Data")
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
    }
}



#Preview {
    ContentView()
}

