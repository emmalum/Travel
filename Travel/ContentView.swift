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
                    ForEach(0..<tripData.journeys[i].legs.count, id:\.self) { j in
                 
                        Spacer()
                        Text("new")
                        
//
//                        ForEach(tripData.origin.coord, id: \.self) { coord in
//                            Text(String(coord[0]))
//                            Text(String(coord[1]))
////                            Text("Longitude: \(String(coord.lng) ?? "")")
//                        }
//                        Text(String(tripData.journeys[i].legs[j].destination?.coord) ?? "0.0")
                      
//                        VStack {
                      
                            Text(tripData.journeys[i].legs[j].transportation?.number ?? "Walk")
//                            HStack {
//                                Text("\(i), \(j)")
                                Text(tripData.journeys[i].legs[j].origin?.name ?? "No Origin Name")
                                Text(tripData.journeys[i].legs[j].destination?.name ?? "No Destination Name")
//                                
//                        
//                            }
//                            .frame(height: 50)
//                        }
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

