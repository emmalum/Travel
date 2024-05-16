//
//  SavedTripsView.swift
//  Travel
//
//  Created by Harry Lecoutre on 16/5/2024.
//

import SwiftUI

struct SavedTripsView: View {
      var body: some View {
        VStack(alignment: .leading) {
          HStack {
            Text("Berowra")
              .font(.title2)
              .fontWeight(.bold)
              .foregroundColor(.white) // Station names in white
            Spacer()
            Text("St James")
              .font(.title2)
              .fontWeight(.bold)
              .foregroundColor(.white) // Station names in white
          }
          .padding(.top, 10) // Add top padding

          HStack(alignment: .top) {
            Rectangle()
              .foregroundColor(Color(red: 51/255, green: 153/255, blue: 255/255)) // Blue rectangle
              .frame(width: 80, height: 40)
              .cornerRadius(10) // Rounded corners for rectangle
            VStack(alignment: .leading) {
              Text("Berowra Platform 2 -> Wynyard Platform 3")
                .font(.body)
                .foregroundColor(.black) // Text in black within orange rectangle
              HStack(alignment: .center) {
                Image(systemName: "train.fill") // Train icon
                  .foregroundColor(.orange)
                Text("Leaving Now")
                  .font(.caption)
                  .foregroundColor(.white) // Text in white within orange rectangle
              }
            }
            Spacer()
          }

          // Repeat the above HStack elements for other trip times

          Spacer() // Add spacer at the bottom for balance
        }
        .padding()
        .background(Color.white) // White background
      }
    }


#Preview {
    SavedTripsView()
}
