//
//  TrainTripView.swift
//  Travel
//
//  Created by Harry Lecoutre on 10/5/2024.
//

import SwiftUI

struct TrainTimeRow: View {
    let leg: Legs
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Leaves: ")
            }
            .padding(4)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.bottom, 3)
            HStack {
                Text("\(leg.transportation?.number ?? ""),")
                Text("Platform: \(leg.origin?.name ?? "")")
            }
            .padding(4)
            .foregroundColor(.black)
            .background(.orange)
            .cornerRadius(8)

            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Journey time: \(dateFormatter.string(from: leg.origin?.departureTimePlanned ?? Date()))")
                }
                .font(.subheadline)
                .bold()
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Arrival at")
                    Text(dateFormatter.string(from: leg.destination?.arrivalTimePlanned ?? Date()))
                }
                .font(.headline)
            }
        }
        .padding()
        .background(Color.cyan)
        .cornerRadius(10)
        .foregroundColor(.white)
    }
}

struct TrainTripView: View {
    @ObservedObject var trainTransitAPI = TrainTransitAPI()
    
    var body: some View {
        Group {
            if let legs = trainTransitAPI.currentTransitRequest?.journeys.first?.legs { List {
                ForEach(legs.indices, id: \.self) { index in
                    TrainTimeRow(leg: legs[index])
                }
            }
            } else {
                Text("Loading...")
                    .onAppear {
                        let currentDate = Date()
                        trainTransitAPI.getData(
                            currentDate: currentDate,
                            origin: "YourOriginStation",
                            destination: "YourDestinationStation",
                            type_destination: "stop"
                        )
                    }
            }
        }
    }
}

struct TrainTripView_Previews: PreviewProvider {
    static var previews: some View {
        TrainTripView()
    }
}
