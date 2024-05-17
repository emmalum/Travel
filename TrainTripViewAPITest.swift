//
//  TrainTripView.swift
//  Travel
//
//  Created by Harry Lecoutre on 10/5/2024.
//

import SwiftUI

struct TrainTimeRowAPITest: View {
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

struct TrainTripViewAPITest: View {
    @ObservedObject var trainTransitAPI = TrainTransitAPI()
    
    var body: some View {
        Group {
            if let legs = trainTransitAPI.currentTransitRequest?.journeys.first?.legs { List {
                ForEach(legs.indices, id: \.self) { index in
                    TrainTimeRowAPITest(leg: legs[index])
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

struct TrainTripViewAPITest_Previews: PreviewProvider {
    static var previews: some View {
        TrainTripView()
    }
}
