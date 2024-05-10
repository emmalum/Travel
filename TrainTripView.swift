//
//  TrainTripView.swift
//  Travel
//
//  Created by Harry Lecoutre on 10/5/2024.
//

import SwiftUI

struct TrainTimeRow: View {
    let trainTime: TrainTime
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("\(trainTime.trainLine),")
                Text("Platform: \(trainTime.platform)")
            }
            .foregroundColor(.black)
            Text("Departing at \(trainTime.departureTime)")
                .font(.headline)
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Journey time: \(trainTime.journeyTime)")
                }
                .font(.subheadline)
                .bold()
                Spacer()
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Arrival at")
                    Text(trainTime.arrivalTime)
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





struct TrainTime: Identifiable {
    let id = UUID()
    let trainLine: String
    let platform: String
    let departureTime: String
    let arrivalTime: String
    let journeyTime: String
}

struct TrainTripView: View {
    let trainTimes: [TrainTime] = [
        TrainTime(trainLine: "T1", platform: "1", departureTime: "08:00", arrivalTime: "09:00", journeyTime: "35 mins"),
        TrainTime(trainLine: "T2", platform: "2", departureTime: "08:30", arrivalTime: "09:30", journeyTime: "55 mins"),
        TrainTime(trainLine: "T8", platform: "3", departureTime: "09:00", arrivalTime: "10:00", journeyTime: "1 hour"),
        TrainTime(trainLine: "T5", platform: "5", departureTime: "10:00", arrivalTime: "11:00", journeyTime: "1 hour"),
        TrainTime(trainLine: "T7", platform: "8", departureTime: "10:00", arrivalTime: "12:00", journeyTime: "2 hours"),
        
    ]
    
    var body: some View {
        List(trainTimes) { trainTime in
            TrainTimeRow(trainTime: trainTime)
        }
    }
}

struct TrainTripView_Previews: PreviewProvider {
    static var previews: some View {
        TrainTripView()
    }
}
