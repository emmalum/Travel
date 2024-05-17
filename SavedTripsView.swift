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
                //foreach loop to show ALL saved trips
                ForEach(savedTrips) { savedTrip in
                    VStack(alignment: .leading) {
                        Text("Line: \(savedTrip.trainLine)")
                        Text("Platform: \(savedTrip.platform)")
                        
                    }
                    .contextMenu {
                        Button(action: {
                            deleteSavedTrip(savedTrip)
                        }) {
                            //implemented force touch to delete, instead of slide. More modern.
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
        } //loading the actual save trips,
    }

    private func deleteSavedTrip(_ trip: TrainTime) {
        if let index = savedTrips.firstIndex(where: { $0.id == trip.id }) {
            savedTrips.remove(at: index)
            saveTripsToUserDefaults()
        } //actually deleting the trip from force touch prompt
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
