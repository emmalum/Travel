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
            List {
                ForEach(savedTrips) { savedTrip in
                    VStack(alignment: .leading) {
                        Text("Line: \(savedTrip.trainLine)")
                        Text("Platform: \(savedTrip.platform)")
                        
                    }
                    .contextMenu {
                        Button(action: {
                            deleteSavedTrip(savedTrip)
                        }) {
                            Text("Delete")
                            Image(systemName: "trash")
                        }
                    }
                }
            }
            .padding()
        }
        .padding()
        .onAppear(perform: loadSavedTrips)
    }

    private func loadSavedTrips() {
        if let data = UserDefaults.standard.data(forKey: "savedTrips"),
           let trips = try? JSONDecoder().decode([TrainTime].self, from: data) {
            savedTrips = trips
        }
    }

    private func deleteSavedTrip(_ trip: TrainTime) {
        if let index = savedTrips.firstIndex(where: { $0.id == trip.id }) {
            savedTrips.remove(at: index)
            saveTripsToUserDefaults()
        }
    }

    private func saveTripsToUserDefaults() {
        if let encoded = try? JSONEncoder().encode(savedTrips) {
            UserDefaults.standard.set(encoded, forKey: "savedTrips")
        }
    }
}

struct SavedTripsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedTripsView(selectedTrainTime: .constant(nil))
            .previewLayout(.sizeThatFits)
    }
}
