//
//  SettingsView.swift
//  Travel
//
//  Created by Joshua Isaraela on 2/5/2024.
//

import SwiftUI

struct SettingsView: View {
    
    @State public var isStartButtonEnabled: Bool = false
    
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

