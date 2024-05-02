//
//  TrainViewModel.swift
//  Travel
//
//  Created by Emma Lum on 2/5/2024.
//

import Foundation

@MainActor

class TrainViewModel: ObservableObject{
    @Published var train = Train()
    var urlString = "https://opendata.transport.nsw.gov.au/dataset/66b02f02-9d8e-4bb9-9ac7-0c84d3f0b72c/resource/d5fa0a43-9db6-4e41-aa9b-98f26837d31a/download/transport-route_2.yaml"
    
    func getData() async {
        print("🐥 We are accessing the url \(urlString)")
        
        //convert url string to ios url type
        guard let url = URL(string: urlString) else {
            print("ERROR could not convert \(urlString) to a URL")
            return
        }
        do {
            let (data, _ ) = try await URLSession.shared.data(from: url)
            do{
                train = try JSONDecoder().decode(Train.self, from: data)
                print("my_timetable_route_name: \(train.my_timetable_route_name)")
                print("route_type: \(train.route_type)")
                
            } catch{
            print("JSON ERRORL: Could not decode JSON data. \(error.localizedDescription)")
            }
        } catch {
            print("ERROR could not get data from URL: \(urlString). \(error.localizedDescription)")
        }
    }
}
