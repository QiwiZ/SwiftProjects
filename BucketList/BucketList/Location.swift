//
//  Location.swift
//  BucketList
//
//  Created by Julian Saxl on 2023-08-06.
//
import MapKit

import Foundation

struct Location: Identifiable, Equatable, Codable {
    var id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        lhs.id == rhs.id
    }
    
    static let example = Location(id: UUID(), name: "Example", description: "Description", latitude: 51.501, longitude: -0.141)
}
