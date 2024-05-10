//
//  LoadingView.swift
//  Travel
//
//  Created by Joshua Isaraela on 2/5/2024.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    @State private var isLoaded = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            VStack {
                
                Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                    .resizable()
                    .frame(width: 128.0, height: 128.0)
                
                Text("Loading")
                    .font(.title)
                    .padding()
                
                // This is the 3 dots that will animate on the loading screen
                HStack {
                    Circle()
                        .foregroundColor(isAnimating ? .red: .gray)
                        .frame(width: 10, height: 10)
                    Circle()
                        .foregroundColor(isAnimating ? .green: .gray)
                        .frame(width: 10, height: 10)
                    Circle()
                        .foregroundColor(isAnimating ? .blue: .gray)
                        .frame(width: 10, height: 10)
                }
            }
            
            .onAppear{
                // Animates the 3 dots by making them change colours every 1 second.
                withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()){
                    self.isAnimating.toggle()
                }
                // When 5 seconds have past, load the next screen. (Sets the isLoaded to true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    self.isLoaded = true
                }
            }
            
            // On Zstack, when the isloaded is true, load the next screen:
            // Also set the background colour to white so we can't see the loading screen overlapping.
            if isLoaded{
                Color.white
                    .ignoresSafeArea()
                ContentView()
            }
        }
    }
}

#Preview {
    NavigationStack{
        LoadingView()
    }
}
