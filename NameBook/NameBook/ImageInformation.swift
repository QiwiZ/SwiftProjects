//
//  ImageInformation.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import Foundation

struct ImageInformation: Codable, Comparable, Identifiable {
    var id = UUID()
    var name: String
    
    var savePath: URL {
        FileManager.documentsDirectory.appendingPathComponent(name)
    }
    
    static func < (lhs: ImageInformation, rhs: ImageInformation) -> Bool {
        lhs.name < rhs.name
    }
}
