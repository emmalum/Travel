//
//  SavedTripsView.swift
//  Travel
//
//  Created by Harry Lecoutre on 10/5/2024.
//
import SwiftUI

struct SavedTripsView: View {
    @Binding var selectedTrainTime: TrainTime?
    @State private var savedTrips: [TrainTime] = []
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Spacer()
                Text("Saved Trips")
                    .font(.largeTitle)
                Spacer()
            }
            HStack {
                if let trainTime = selectedTrainTime {
                    Text("Line: \(trainTime.trainLine)")
                        .padding(4)
                        .foregroundColor(.black)
                        .background(Color.orange)
                        .cornerRadius(8)
                    Text("Platform: \(trainTime.platform)")
                        .padding(4)
                        .foregroundColor(.black)
                        .background(Color.orange)
                        .cornerRadius(8)
                } else {
                    Spacer()
                    Text("No trip selected")
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                    Spacer()
                }
            }
            Spacer()
            List(savedTrips) { savedTrip in
                VStack(alignment: .leading) {
                    Text("Line: \(savedTrip.trainLine)")
                    Text("Platform: \(savedTrip.platform)")
                }
            }
            .padding()
        }
        .padding()
    }
    
    private func saveTrip(_ trip: TrainTime) {
        savedTrips.append(trip)
    }
}

struct SavedTripsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedTripsView(selectedTrainTime: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}
