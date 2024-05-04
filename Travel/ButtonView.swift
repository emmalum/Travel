//
//  ButtonView.swift
//  Travel
//
//  Created by Emma Lum on 3/5/2024.
//


import SwiftUI

struct ButtonView: View {
    
    @State var button: Bool = false
    @State var button2: Bool = false
    @State var var1: String?
    @State var var2: String?
    
    var body: some View {
  
        Text("\(var1 ?? "") \(var2 ?? "")")
        Button {
            button.toggle()
            if var1 != nil {
                var2 = "origin"
            }
            else {
                var1 = "destination"
            }
        } label: {
        Text("location1")
            .foregroundColor(button ? .white : .black)
    }
    .tint(button ? .blue : .white)
    .buttonStyle(.bordered)
    .background(
        RoundedRectangle(cornerRadius: 100)
            .fill(button ? Color.buttonColour : Color.white)
            .stroke(.buttonColour, lineWidth: 2)
    )

        
        
        Button {
            button2.toggle()
            if var1 != nil {
                var2 = "origin"
            }
            else {
                var1 = "destination"
            }
        } label: {
            Text("location2")
                .foregroundColor(button ? .white : .black)
        }
        .tint(button2 ? .blue : .white)
        .buttonStyle(.bordered)
        .background(
            RoundedRectangle(cornerRadius: 100)
                .fill(button2 ? Color.buttonColour : Color.white)
                .stroke(.buttonColour, lineWidth: 2)
        )
        
        
        Button {
            
        } label: {
            Text("Confirm")
        }
        .buttonStyle(.borderedProminent)
        .disabled(var1 == nil && var2 == nil)
    }
}

#Preview {
    ButtonView()
}
