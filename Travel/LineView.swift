//
//  LineView.swift
//  Travel
//
//  Created by Emma Lum on 7/5/2024.
//

import SwiftUI

struct LineView: View {
    
    @State var transitAPI: TrainTransitAPI = TrainTransitAPI()
    @State var transitParams: TripAPIParams = TripAPIParams(date: Date(), origin: "", destination: "", type_destination: "")
    
    
    @State var button: Bool = false
    @State var button2: Bool = false
    @State var var1: String?
    @State var var2: String?
    
    var body: some View {
 
        ScrollView(.vertical){
            VStack{
                Text ("T1 North Shore and Western Line")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("T1Colour"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 60.0)
                
     
                    ScrollView(.horizontal){
                        HStack{
                            
                        ForEach(0...2, id: \.self){ _ in
                            Rectangle()
                                .frame(width: 100.0, height: 20)
                                .foregroundColor(.t1Colour)
                             
                            StationView(title:"Berowra")
                        }
                }
                        
//                        Rectangle()
//                            .frame(width: 100.0, height: 20)
//                            .foregroundColor(.t1Colour)
//                        
//                        StationView(title:"Mount Kuring-gai")
//                        
//                        Rectangle()
//                            .frame(width: 100.0, height: 20)
//                            .foregroundColor(.t1Colour)
//                
                }
                
           
                Text ("T2 Inner West and Leppington Line")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(Color("T2Colour"))
                    .multilineTextAlignment(.center)
                    .padding(.top, 60.0)
                ScrollView(.horizontal){
                    HStack{
                       
                        Rectangle()
                            .frame(width: 100.0, height: 20)
                            .foregroundColor(.t2Colour)
                         
                        StationView(title:"Museum")
                        
                        Rectangle()
                            .frame(width: 100.0, height: 20)
                            .foregroundColor(.t2Colour)
                        
                        StationView(title:"St James")
                        
                        Rectangle()
                            .frame(width: 100.0, height: 20)
                            .foregroundColor(.t2Colour)
                    }
                }
   
            }
            
        }
       
    }
}


struct StationView: View{
    @State var button: Bool = false
    @State var button2: Bool = false
    @State var var1: String?
    @State var var2: String?
    
    let title: String
    
    var body: some View{
            Button {
                button.toggle()
                if var1 != nil {
                    var2 = "origin"
                }
                else {
                    var1 = title
                }
            } label: {
            Text(title)
                .foregroundColor(button ? .white : .black)
        }
            .tint(button ? .blue : .orange)
        .buttonStyle(.bordered)
        .buttonBorderShape(.capsule)
//        .background(
//            RoundedRectangle(cornerRadius: 100)
//                .fill(button ? Color.buttonColour : Color.white)
//                .stroke(.buttonColour, lineWidth: 2)
//        )
      
    }
}

#Preview {
    LineView()
}
