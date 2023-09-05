//
//  Note.swift
//  TrackEverything
//
//  Created by Julian Saxl on 2023-08-28.
//

import Foundation

struct Note: Codable, Identifiable {
    var id = UUID()
    var note: String
    var createdAt = Date.now
}
