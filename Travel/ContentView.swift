//
//  ContentView.swift
//  Travel
//
//  Created by Emma Lum on 30/4/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject var trainVM = TrainViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .task{
            await trainVM.getData()
        }
    }
}

#Preview {
    ContentView()
}
