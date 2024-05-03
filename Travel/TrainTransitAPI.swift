//
//  TrainViewModel.swift
//  Travel
//
//  Created by Emma Lum on 2/5/2024.
//

import Foundation

@Observable
class TrainTransitAPI {

    var urlString: URL = URL(string: "https://api.transport.nsw.gov.au/v1/tp/trip")!
//    let APIKey: String = "apikey eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"
    let APIKey: String = "apikey 5RjqITN7W2Jaf9TzUwKzvMnoRfNkA6Jl32jw"
    let APIHeader: [String: String]
    
    var tripAPIParams: TripAPIParams?
    var currentTransitRequest: TransitRequest?
    
    init() {
        self.APIHeader = [
            "accept": "application/json",
            "authorization": APIKey,
        ]
    }
    
    func getData(currentDate: Date, origin: String, destination: String) {
        let tripAPIParams = TripAPIParams(date: currentDate, origin: origin, destination: destination)
        
        var urlComponents = URLComponents(url: urlString, resolvingAgainstBaseURL: false)
        
        urlComponents?.queryItems = tripAPIParams.toURLQuery()
        
        guard let modifiedURL = urlComponents?.url else{
            print("Failed to create url")
            return
        }
        
        //set up request
        var request = URLRequest(url: modifiedURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = APIHeader
        
        //prepare to preform request
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            if let safeData = data {
                self.parseJSON(data: safeData)
            }
        }
        
        task.resume()
    
    }
    

    func parseJSON(data: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(TransitRequest.self, from: data)
            print(decodedData)
            self.currentTransitRequest = decodedData
        }catch {
            print(error)
        }
    }
    
}

//arguments for the API to set up queries
//preset with defaults(4.3 example)
struct TripAPIParams {
    var outputFormat: String = "rapidJSON"
    var coordOutputFormat: String = "EPSG:4326"
    var depArrMacro: String = "dep"
    var itdDate: String
    var itdTime: String
    var type_origin = "stop"
    var name_origin: String
    var type_destination: String = "stop"
    var name_destination: String
    var TfNSWTR: Bool = true;
    
    //initialising the TripAPIParams - by making it in object
    init(date: Date, origin: String, destination: String) {
        self.itdDate = DateFormatter().currentDate.string(from: date)
        self.itdTime = DateFormatter().currentTime.string(from: date)
        self.name_origin = origin
        self.name_destination = destination
    }
    
    //formatting for API call
    func toURLQuery() -> [URLQueryItem] {
        var queries: [URLQueryItem] = []
        queries.append(URLQueryItem(name: "outputFormat", value: outputFormat))
        queries.append(URLQueryItem(name: "coordOutputFormat", value: coordOutputFormat))
        queries.append(URLQueryItem(name: "depArrMacro", value: depArrMacro))
        queries.append(URLQueryItem(name: "itdDate", value: itdDate))
        queries.append(URLQueryItem(name: "itdTime", value: itdTime))
        queries.append(URLQueryItem(name: "type_origin", value: type_origin))
        queries.append(URLQueryItem(name: "name_origin", value: name_origin))
        queries.append(URLQueryItem(name: "type_destination", value: type_destination))
        queries.append(URLQueryItem(name: "name_destination", value: name_destination))
        queries.append(URLQueryItem(name: "TfNSWTR", value: String(TfNSWTR)))
        return queries
    }
}
