//
//  User.swift
//  ChallengeDay60
//
//  Created by Julian Saxl on 2023-07-27.
//

import Foundation


struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}
