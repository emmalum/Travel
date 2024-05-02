//
//  SettingsView.swift
//  Travel
//
//  Created by Joshua Isaraela on 2/5/2024.
//

import SwiftUI

struct SettingsView: View {
    
    var body: some View {
        VStack{
            Label("Settings", systemImage: "")
                .foregroundStyle(.green)
                .font(.title)
            Spacer()
        }
    }
}
    
#Preview {
    NavigationStack {
        SettingsView()
    }
}

