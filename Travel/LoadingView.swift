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
    
    var body: some View {
        VStack {
            Text("Loading")
                .font(.title)
                .padding()
            
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
            
            // Doesn't work?
            if isLoaded{
                NavigationLink(
                    destination: SettingsView(),
                    label:{
                        EmptyView()
                    }
                )
            }
            
        }
        .onAppear{
            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()){
                self.isAnimating.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 10){
                self.isLoaded = true
            }
        }
        // Below works correctly, but it gives a dreprecation warning
        .background(
            NavigationLink(
                destination: SettingsView(),
                isActive: $isLoaded,
                label: {
                    EmptyView()
                }
            ).hidden()
        )
    }
}

#Preview {
    NavigationStack{
        LoadingView()
    }
}
