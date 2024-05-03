//
//  Decodables.swift
//  Travel
//
//  Created by Emma Lum on 3/5/2024.
//

import Foundation

struct TransitRequest: Decodable {
    var journeys: [Journey]
    var systemMessage: SystemMessage?
    var version: String
}

struct SystemMessage: Decodable {
    var code: String
    var module: String
    var subType: String
    var text: String
    var type: String
}

struct Journey: Decodable {
    var daysOfService: [String : String]
    var fare: Fare
    var interchanges: Int
    var isAdditional: Bool
    var legs: [Legs]
}

struct Fare: Decodable {
    var tickets: [String]
}

struct Legs: Decodable {
//    var coords: [Coords]?
    var destination: Destination?
    var origin: Origin?
    var transportation: Transportation?
}

struct Transportation: Decodable {
    var number: String?
}

struct Origin: Decodable {
//    var coord: [Coords]?
    var departureTimeBaseTimetable: Date
    var departureTimeEstimated: Date
    var departureTimePlanned: Date
//    var disassembledName: String?
    var id: String
    var isGlobalId: Bool
    var name: String
    var niveau: Int?
//    var parent: Parent?
    
    enum CodingKeys: CodingKey {
        case departureTimeBaseTimetable
        case departureTimeEstimated
        case departureTimePlanned
        case disassembledName
        case id
        case isGlobalId
        case name
        case niveau
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let departureTimeBaseTimetable = try container.decode(String.self, forKey: .departureTimeBaseTimetable)
        self.departureTimeBaseTimetable = DateFormatter().returnedTime.date(from: departureTimeBaseTimetable)!
        let departureTimeEstimated = try container.decode(String.self, forKey: .departureTimeEstimated)
        self.departureTimeEstimated = DateFormatter().returnedTime.date(from: departureTimeEstimated)!
        let departureTimePlanned = try container.decode(String.self, forKey: .departureTimePlanned)
        self.departureTimePlanned = DateFormatter().returnedTime.date(from: departureTimePlanned)!
//        self.disassembledName = try container.decode(String.self, forKey: .disassembledName)
        self.id = try container.decode(String.self, forKey: .id)
        self.isGlobalId = try container.decode(Bool.self, forKey: .isGlobalId)
        self.name = try container.decode(String.self, forKey: .name)
        self.niveau = try container.decodeIfPresent(Int.self, forKey: .niveau)
    }
}

struct Destination: Decodable {
    var arrivalTimeBaseTimetable: Date
    var arrivalTimeEstimated: Date
    var arrivalTimePlanned: Date
//    var coord: Coords?
//    var disassembledName: String?
    var id: String
    var isGlobalId: Bool
    var name: String
    var niveau: Int?
//    var parent: Parent?
    
    enum CodingKeys: CodingKey {
        case arrivalTimeBaseTimetable
        case arrivalTimeEstimated
        case arrivalTimePlanned
        case disassembledName
        case id
        case isGlobalId
        case name
        case niveau
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let arrivalTimeBaseTimetable = try container.decode(String.self, forKey: .arrivalTimeBaseTimetable)
        self.arrivalTimeBaseTimetable = DateFormatter().returnedTime.date(from: arrivalTimeBaseTimetable)!
        let arrivalTimeEstimated = try container.decode(String.self, forKey: .arrivalTimeEstimated)
        self.arrivalTimeEstimated = DateFormatter().returnedTime.date(from: arrivalTimeEstimated)!
        let arrivalTimePlanned = try container.decode(String.self, forKey: .arrivalTimePlanned)
        self.arrivalTimePlanned = DateFormatter().returnedTime.date(from: arrivalTimePlanned)!
//        self.disassembledName = try container.decode(String.self, forKey: .disassembledName)
        self.id = try container.decode(String.self, forKey: .id)
        self.isGlobalId = try container.decode(Bool.self, forKey: .isGlobalId)
        self.name = try container.decode(String.self, forKey: .name)
        self.niveau = try container.decodeIfPresent(Int.self, forKey: .niveau)
    }
}
