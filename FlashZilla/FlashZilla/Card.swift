//
//  Card.swift
//  FlashZilla
//
//  Created by Julian Saxl on 2023-08-28.
//

import Foundation
struct Card: Codable {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Example promp", answer: "Example Answer")
}
