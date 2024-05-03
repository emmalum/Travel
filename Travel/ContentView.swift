//
//  ContentView.swift
//  Travel
//
//  Created by Emma Lum on 30/4/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var transitAPI: TrainTransitAPI = TrainTransitAPI()
    @State var transitParams: TripAPIParams = TripAPIParams(date: Date(), origin: "200039", destination: "201631")
    @State var refresh: Bool = false
    
    var body: some View {
        VStack {
            if let tripData = transitAPI.currentTransitRequest {
                ForEach(0..<tripData.journeys.count, id:\.self) {i in
                    ForEach(0..<tripData.journeys[i].legs.count, id:\.self) { j in
                        VStack {
                            Text(tripData.journeys[i].legs[j].transportation?.number ?? "Walk")
                            HStack {
                                Text("\(i), \(j)")
                                Text(tripData.journeys[i].legs[j].origin?.name ?? "No Origin Name")
                                Text(tripData.journeys[i].legs[j].destination?.name ?? "No Destination Name")
                            }
                            .frame(height: 50)
                        }
                    }
                }
            }
            HStack {
                Button{
                    refresh.toggle()
                } label: {
                    Text("Refresh")
                }
                .buttonStyle(.bordered)
                
                Button {
                    transitAPI.getData(currentDate: Date(), origin: "201833", destination: "2000167")
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
