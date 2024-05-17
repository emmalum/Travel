//
//  TrainTripView.swift
//  Travel
//
//  Created by Harry Lecoutre on 10/5/2024.
//

import SwiftUI

struct TrainTimeRow: View {
    let trainTime: TrainTime
    let onSaveTrip: (TrainTime) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(trainTime.trainLine), Platform: \(trainTime.platform)")
                    .padding(4)
                    .foregroundColor(.black)
                    .background(Color.orange)
                    .cornerRadius(8)
                Spacer()
                Text("Departure: \(trainTime.departureTime)")
                    .bold()
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Journey time: \(trainTime.journeyTime)")
            }
            .font(.headline)
            .bold()
            
            HStack {
                Text("Arrival at \(trainTime.arrivalTime)")
                    .font(.headline)
                    .bold()
                Spacer()
                Button(action: {
                    onSaveTrip(trainTime)
                }) {
                    Text("Save Trip")
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.cyan)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

struct TrainTime: Identifiable {
    let id = UUID()
    let trainLine: String
    let platform: String
    let departureTime: String
    let arrivalTime: String
    let journeyTime: String
}

struct TrainTripView: View {
    @State private var selectedTrainTime: TrainTime? // Track the selected TrainTime
    
    let trainTimes: [TrainTime] = [
        TrainTime(trainLine: "T1", platform: "1", departureTime: "08:00", arrivalTime: "08:35", journeyTime: "35 mins"),
        TrainTime(trainLine: "T2", platform: "2", departureTime: "08:30", arrivalTime: "09:25", journeyTime: "55 mins"),
        TrainTime(trainLine: "T8", platform: "3", departureTime: "08:40", arrivalTime: "09:40", journeyTime: "1 hour"),
        TrainTime(trainLine: "T5", platform: "5", departureTime: "9:00", arrivalTime: "10:00", journeyTime: "1 hour"),
        TrainTime(trainLine: "T7", platform: "8", departureTime: "9:00", arrivalTime: "10:30", journeyTime: "1 hour 30 mins"),
    ]
    
    var body: some View {
        List {
            ForEach(trainTimes) { trainTime in
                TrainTimeRow(trainTime: trainTime) { selectedTrainTime in
                    self.selectedTrainTime = selectedTrainTime
                }
            }
        }
        .navigationTitle("Train Trips")
        .background(
            NavigationLink(
                destination: SavedTripsView(selectedTrainTime: $selectedTrainTime),
                isActive: Binding(
                    get: { self.selectedTrainTime != nil },
                    set: { if !$0 { self.selectedTrainTime = nil } }
                )
            ) {
                EmptyView()
            }
            .hidden()
        )
    }
}

struct TrainTripView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TrainTripView()
        }
        .previewLayout(.sizeThatFits)
    }
}

