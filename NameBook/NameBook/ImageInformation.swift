//
//  ImageInformation.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import Foundation
import CoreLocation

struct ImageInformation: Codable, Comparable, Identifiable {
    var id = UUID()
    var name: String
    var latitude: Double?
    var longitude: Double?
    
    var savePath: URL {
        FileManager.documentsDirectory.appendingPathComponent(name)
    }
    
    var location: CLLocationCoordinate2D {
        if latitude != nil && longitude != nil {
            return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        }
        return CLLocationCoordinate2D()
    }
    
    var wrappedLatitude: String {
        (latitude != nil) ? String(latitude!) : "Unknown"
    }
    
    var wrappedLongitude: String {
        (longitude != nil) ? String(longitude!) : "Unknown"
    }
    
    static func < (lhs: ImageInformation, rhs: ImageInformation) -> Bool {
        lhs.name < rhs.name
    }
}
