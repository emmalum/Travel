//
//  ContentView.swift
//  Travel
//
//  Created by Emma Lum on 30/4/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var transitAPI: TrainTransitAPI = TrainTransitAPI()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
    
    }
}

#Preview {
    ContentView()
}
