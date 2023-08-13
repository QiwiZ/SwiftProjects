//
//  Picture.swift
//  NameBook
//
//  Created by Julian Saxl on 2023-08-13.
//

import Foundation

struct Picture: Codable, Comparable {
    let id = UUID()
    var nameOfPerson: String
    
    static func < (lhs: Picture, rhs: Picture) -> Bool {
        lhs.nameOfPerson < rhs.nameOfPerson
    }
}
