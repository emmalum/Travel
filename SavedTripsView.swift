
import SwiftUI

struct SavedTripsView: View {
    @Binding var selectedTrainTime: TrainTime?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let trainTime = selectedTrainTime {
                Text("Saved Trips")
                HStack {
                    Text("Line: \(trainTime.trainLine)")
                        .padding(4)
                        .foregroundColor(.black)
                        .background(Color.orange)
                        .cornerRadius(8)
                    Spacer()
                    Text("Platform: \(trainTime.platform)")
                        .padding(4)
                        .foregroundColor(.black)
                        .background(Color.orange)
                        .cornerRadius(8)
                }
            } else {
                Text("No trip selected")
            }
            Spacer()
        }
        .padding()
    }
}

struct SavedTripsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedTripsView(selectedTrainTime: .constant(nil))
    }
}
