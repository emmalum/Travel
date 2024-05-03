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
                var2 = "something"
            }
            else {
                var1 = "something"
            }
        } label: {
            Text("Hello World")
        }
        .tint(button ? .blue : .red)
        .buttonStyle(.borderedProminent)
        Button {
            button2.toggle()
            if var1 != nil {
                var2 = "else"
            }
            else {
                var1 = "else"
            }
        } label: {
            Text("Hello World")
        }
        .tint(button2 ? .blue : .red)
        .buttonStyle(.borderedProminent)
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
